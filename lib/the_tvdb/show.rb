module TheTvdb
  class Show
    
    attr_accessor :id, :name, :banner, :description, :first_aired
    
    def self.search(name)
      shows = TheTvdb.gateway.get_series(name)
      shows.map {|s| Show.new(s) }
    end

    def initialize(info)
      @id = info['seriesid'].to_i
      @name = info['SeriesName']
      @banner = info['banner']
      @description = info['Overview']
      @first_aired = info['FirstAired']
    end
        
    def episodes
      []
    end

  end
end