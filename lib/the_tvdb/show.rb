module TheTvdb
  class Show
    
    attr_accessor :remote_id, :name, :banner, :description, :episodes,
      :first_aired, :imdb_id, :zap2it_id, :language
    
    def self.search(name)
      shows = TheTvdb.gateway.get_series(name)
      shows.map {|s| self.new(s) }
    end

    def self.find(remote_id)
      info = TheTvdb.gateway.get_series_package(remote_id)
      show = self.new(info['Series'])
      show.episodes = info['Episode'].blank? ? [] : [ info['Episode'] ].flatten.map {|e| TheTvdb::Episode.new(e) }
      show
    end

    def initialize(info)
      @remote_id = info['id'].to_i
      @name = info['SeriesName']
      @banner = "#{TheTvdb.gateway.mirror}/banners/#{info['banner']}" unless info['banner'].nil?
      @description = info['Overview']
      @imdb_id = info['IMDB_ID']
      @zap2it_id = info['zap2it_id']
      @first_aired = info['FirstAired']
      @language = info['language']
      @episodes = []
    end
    
    def to_hash
      { 
        remote_id: @remote_id,
        name: @name,
        banner: @banner,
        description: @description,
        first_aired: @first_aired,
        imdb_id: @imdb_id,
        zap2it_id: @zap2it_id,
        language: @language
      }
    end

  end
end