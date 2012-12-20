module TheTvdb
  class Show
    
    attr_accessor :remote_id, :name, :banner, :description, :aired_at, :episodes, :seasons
    
    def self.search(name)
      shows = TheTvdb.gateway.get_series(name)
      shows.map {|s| self.new(s) }
    end

    def initialize(info)
      @remote_id = info['seriesid'].to_i
      @name = info['SeriesName']
      @banner = info['banner']
      @description = info['Overview']
      @aired_at = info['FirstAired']
    end
    
    def self.find(show_id)
      info = TheTvdb.gateway.get_series_package(show_id)
      show = self.new(info['Series'])
      show.episodes = info['Episode'].map {|e| TheTvdb::Episode.new(e) }
      show
    end

  end
end