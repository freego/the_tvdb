require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'zip/zip'
require 'active_support/core_ext'

module TheTvdb
  
  def self.gateway
    @gateway ||= Gateway.new(api_key = nil)
  end
  
  class Gateway
    
    # def zip_path
    #   "tmp/zipfiles"
    # end
    # def data_path
    #   "tmp/data"
    # end
    
    # TODO: setup a reliable env system for apikey
    def initialize(api_key = nil)
      @api_key = api_key || ENV['TVDBKEY']
      @mirror = get_mirror
    end
    
    ENDPOINT = 'http://www.thetvdb.com/api/'
    
    def endpoint
      ENDPOINT
    end
    
    # def api_key
    #   APIKEY
    # end
    
    def get_mirror
      hash = xmlurl_to_hash "#{endpoint}#{@api_key}/mirrors.xml", 'Mirror'
      "#{hash['mirrorpath']}/api/#{@api_key}"
    end
    
    def get_time
      xmlurl_to_hash "#{endpoint}/Updates.php?type=none", 'Time'
    end
    
    def get_series(name)
      doc = open_xml "#{endpoint}/GetSeries.php?seriesname=#{URI.escape(name)}"
      result = doc.css('Series').map { |series| Hash.from_xml(series.to_s)['Series'] }
      #puts result.to_yaml
      result
    end
    
    # def get_series_package(seriesid, language = 'en')
    #   begin
    #     open("#{zip_path}/#{seriesid}.zip", 'wb') do |file|
    #       file << open("#{@mirror}/series/#{seriesid}/all/#{language}.zip").read
    #     end
    #     unzip_file("#{zip_path}/#{seriesid}.zip", "#{data_path}/xml/#{seriesid}")
    #     xmlfile_to_hash "#{data_path}/xml/#{seriesid}/#{language}.xml", 'Data'
    #   rescue Exception => e
    #     p e
    #     puts e
    #     puts "BOOOHs"
    #     puts "#{@mirror}/series/#{seriesid}/all/#{language}.zip"
    #     nil
    #   end
    # end
    # 
    # def get_episode_details(episodeid, language = 'en')
    #   file_path = make_path_for_file("#{data_path}/episodes", "#{episodeid}.xml")
    #   open(file_path, 'wb') do |file|
    #     file << open("#{@mirror}/episodes/#{episodeid}/#{language}.xml").read
    #   end
    #   xmlfile_to_hash(file_path, 'Episode')
    # end
    
    private

      # def make_path_for_file(destination, file_name)
      #   f_path=File.join(destination, file_name)
      #   FileUtils.mkdir_p(File.dirname(f_path))
      #   f_path
      # end
      
      def open_xml(url)
        Nokogiri::XML(open(url))
      end
          
      # def open_local_xml(file_path)
      #   Nokogiri::XML(File.open(file_path))
      # end
    
      # def xmlfile_to_hash(file_path, selector = nil)
      #   if selector
      #     document = open_local_xml(file_path).css(selector)
      #     Hash.from_xml(document.to_s)[selector]
      #   else
      #     Hash.from_xml(open_local_xml(file_path).to_s)
      #   end      
      # end
    
      def xmlurl_to_hash(url, selector = nil)
        doc = open_xml(url)
        doc = doc.css(selector) if selector
        result = Hash.from_xml(doc.to_s)
      end
    
      # def xmlurl_to_array(url, selector = nil)
      #   if selector
      #     document = open_xml(url).css(selector)
      #   
      #   else
      #     Array.from_xml(open_xml(url).to_s)
      #   end
      # end
      # 
      # def unzip_file (file, destination)
      #   Zip::ZipFile.open(file) { |zip_file|
      #     zip_file.each { |f|
      #       f_path=File.join(destination, f.name)
      #       FileUtils.mkdir_p(File.dirname(f_path))
      #       zip_file.extract(f, f_path) unless File.exist?(f_path)
      #     }
      #   }
      # end

    
  end
end
