module TheTvdb
  class Show

    attr_accessor :remote_id, :name, :banner, :description, :episodes,
      :first_aired, :imdb_id, :zap2it_id, :language, :actors, :airs_day_of_week,
      :airs_time, :content_rating, :genre, :network, :runtime, :fanart,
      :rating, :rating_count, :status, :added_at, :last_updated, :poster

    def self.search(name)
      shows = TheTvdb.gateway.get_series(name)
      shows.map {|s| self.new(s, true) }
    end

    def self.find(remote_id)
      begin
        info = TheTvdb.gateway.get_series_package(remote_id)
        show = self.new(info['Series'])
        show.episodes = info['Episode'].blank? ? [] : [ info['Episode'] ].flatten.map {|e| TheTvdb::Episode.new(e) }
        show
      rescue
        puts 'There was an issue with the series you tried to fetch'
        nil
      end
    end

    def initialize(info, partial=false)
      @remote_id = info['id'].to_i
      @name = info['SeriesName']
      @banner = "#{TheTvdb.gateway.mirror}/banners/#{info['banner']}" unless info['banner'].nil?
      @description = info['Overview']
      @imdb_id = info['IMDB_ID']
      @zap2it_id = info['zap2it_id']
      @first_aired = info['FirstAired']
      @language = info['language']

      unless partial
        @episodes = []
        @actors = info['Actors'].try(:to_tvdb_array)
        @airs_day_of_week = info['Airs_DayOfWeek']
        @airs_time = info['Airs_Time']
        @content_rating =  info['ContentRating']
        @genre = info['Genre'].try(:to_tvdb_array)
        @network = info['Network']
        @runtime = info['Runtime'].try(:to_i)
        @fanart = "#{TheTvdb.gateway.mirror}/banners/#{info['fanart']}" unless info['fanart'].nil?
        @rating = info['Rating'].try(:to_f)
        @rating_count = info['RatingCount'].try(:to_i)
        @status = info['Status']
        @added_at = info['added']
        @last_updated = info['lastupdated']
        @poster = "#{TheTvdb.gateway.mirror}/banners/#{info['poster']}" unless info['poster'].nil?
      end

    end
    
    def banners
      xml = TheTvdb.gateway.get_banners(@remote_id), 'Banners'
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
        language: @language,
        actors: @actors,
        airs_day_of_week: @airs_day_of_week,
        airs_time: @airs_time,
        content_rating: @content_rating,
        genre: @genre,
        network: @network,
        runtime: @runtime,
        fanart: @fanart,
        rating: @rating,
        rating_count: @rating_count,
        status: @status,
        added_at: @added_at,
        last_updated: @last_updated,
        poster: @poster
      }
    end

  end
end
