module TheTvdb
  class Show
    
    attr_accessor :remote_id, :name, :banner, :description, :episodes, :seasons#, :aired_at
    
    def self.search(name)
      shows = TheTvdb.gateway.get_series(name)
      shows.map {|s| self.new(s) }
    end

    def self.find(remote_id)
      info = TheTvdb.gateway.get_series_package(remote_id)
      show = self.new(info['Series'])
      show.episodes = info['Episode'].map {|e| TheTvdb::Episode.new(e) }
      show
    end

    def initialize(info)
      @remote_id = info['id'].to_i
      @name = info['SeriesName']
      @banner = info['banner']
      @description = info['Overview']
      #@aired_at = info['FirstAired']
    end
    
    def to_hash
      { remote_id: @remote_id, name: @name, banner: @banner, description: @description }
    end

  end
end