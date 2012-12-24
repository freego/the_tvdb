require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'zip/zip'
require 'active_support/core_ext'

module TheTvdb
  class Gateway
    
    include Singleton
    
    def config
      TheTvdb.configuration
    end
    
    def zip_path
      config.zip_path
    end
    def data_path
      config.data_path
    end
    def episodes_path
      config.episodes_path
    end
    
    attr_accessor :api_key, :mirror, :api_path, :last_updated
    
    # TODO: setup a reliable env system for apikey
    def initialize(api_key = nil)
      @api_key = config.api_key
      raise 'No API key was provided. Please set one as TheTvdb::Configuration.apikey or as an environment variable (e.g.: `export TVDBKEY=1234567898765432`).' if !@api_key
      @mirror = get_mirror
      @api_path = "#{@mirror}/api/#{@api_key}"
    end
    
    ENDPOINT = 'http://www.thetvdb.com/api/'
    
    def endpoint
      ENDPOINT
    end
    
    def get_mirror
      hash = xml_to_hash "#{endpoint}#{@api_key}/mirrors.xml", 'Mirror'
      hash['mirrorpath']
    end
    
    def update(time)
      hash = xml_to_hash "#{endpoint}/Updates.php?time=#{time || last_updated}", 'Items'
    end
    
    def time
      @last_updated = xml_to_hash "#{endpoint}/Updates.php?type=none", 'Time'
    end
    
    def get_series(name)
      doc = open_xml "#{endpoint}/GetSeries.php?seriesname=#{URI.escape(name)}"
      result = doc.css('Series').map { |series| Hash.from_xml(series.to_s)['Series'] }
      #puts result.to_yaml
      result
    end
    
    def get_series_package(seriesid, language = 'en')
      begin
        open("#{zip_path}/#{seriesid}.zip", 'wb') do |file|
          file << open("#{@api_path}/series/#{seriesid}/all/#{language}.zip").read
        end
        unzip_file("#{zip_path}/#{seriesid}.zip", "#{data_path}/xml/#{seriesid}")
        xml_to_hash "#{data_path}/xml/#{seriesid}/#{language}.xml", 'Data'
      rescue Exception => e
        puts "Could not retrieve series package"
        puts "#{@api_path}/series/#{seriesid}/all/#{language}.zip"
        nil
      end
    end

    def get_episode_details(episodeid, language = 'en')
      file_path = "#{episodes_path}/#{episodeid}.xml"
      open(file_path, 'wb') do |file|
        file << open("#{@api_path}/episodes/#{episodeid}/#{language}.xml").read
      end
      xml_to_hash(file_path, 'Episode')
    end
    
    private
      
      def open_xml(xml)
        begin
          location = (xml =~ URI::regexp) ? open(xml) : File.open(xml)
          Nokogiri::XML(location)
        rescue Exception => e
          p e
          #puts e.backtrace
        end
      end
    
      def xml_to_hash(url, selector = nil)
        doc = open_xml(url)
        doc = doc.css(selector) if selector.present?
        result = Hash.from_xml(doc.to_s)
        result[selector] if selector.present?
      end
    
      # def xmlurl_to_array(url, selector = nil)
      #   if selector
      #     document = open_xml(url).css(selector)
      #   
      #   else
      #     Array.from_xml(open_xml(url).to_s)
      #   end
      # end

      def unzip_file (file, destination)
        Zip::ZipFile.open(file) { |zip_file|
          zip_file.each { |f|
            f_path=File.join(destination, f.name)
            FileUtils.mkdir_p(File.dirname(f_path))
            zip_file.extract(f, f_path) unless File.exist?(f_path)
          }
        }
      end
    
  end
end
