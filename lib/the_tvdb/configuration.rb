module TheTvdb
  class Configuration
    
    include Singleton
    
    attr_accessor :api_key
    def initialize
      @api_key = ENV['TVDBKEY']
    end
      
    def dump_path
      @dump_path ||= default_path
      FileUtils.mkdir_p("#{@dump_path}/zipfiles") if !File.directory?("#{@dump_path}/zipfiles")
      FileUtils.mkdir_p("#{@dump_path}/data/episodes") if !File.directory?("#{@dump_path}/data/episodes")
      @dump_path
    end

    def default_path
      'tmp/the_tvdb/'
    end
    
    def zip_path
      "#{dump_path}/zipfiles"
    end
    def data_path
      "#{dump_path}/data"
    end
    def episodes_path
      "#{data_path}/episodes"
    end
    

  end
end
