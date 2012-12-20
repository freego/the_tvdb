module TheTvdb
  
  def self.config
    @config ||= Configuration.new
  end
  
  class Configuration
  
    def dump_path
      @dump_path ||= default_path
      if !File.directory?(@dump_path)
        FileUtils.mkdir_p("#{@dump_path}/zipfiles")
        FileUtils.mkdir_p("#{@dump_path}/data")
      end
      @dump_path
    end

    def default_path
      'tmp/the_tvdb/'
    end

  end
end
