module TheTvdb
  class Episode
    
    attr_accessor :remote_id, :season_remote_id, :season_number, :name, :number, :aired_at, :description,
      :guest_stars, :director, :writer, :updated_at, :dvd_disc, :dvd_season, :dvd_episode_number, :dvd_chapter,
      :absolute_number, :image_url, :imdb_id, :language, :production_code

    def initialize(info)
      @remote_id = info['id'].to_i
      @season_remote_id = info['seasonid'].to_i
      @season_number = info['SeasonNumber'].to_i
      @name = info['EpisodeName']
      @number = info['EpisodeNumber'].to_i
      @aired_at = info['FirstAired']
      @description = info['Overview']
      @guest_stars = info['GuestStars']
      @director = info['Director']
      @writer = info['Writer']
      @updated_at = Time.at(info['lastupdated'].to_i)
      @dvd_disc = info['DVD_discid']
      @dvd_season = info['DVD_season']
      @dvd_episode_number = info['DVD_episodenumber']
      @dvd_chapter = info['DVD_chapter']
      @absolute_number = info['absolute_number']
      @image_url = "#{TheTvdb.gateway.mirror}/banners/#{info['filename']}" unless info['filename'].nil?
      @imdb_id = info['IMDB_ID']
      @language = info['Language']
      @prodiction_code = info['ProductionCode']
    end
    
    def self.find(remote_id)
      info = TheTvdb.gateway.get_episode_details(remote_id)
      self.new(info)
    end
    
    def to_hash
      {
        remote_id: @remote_id,
        name: @name,
        description: @description,
        season_remote_id: @season_remote_id,
        season_number: @season_number,
        number: @number,
        aired_at: @aired_at,
        guest_stars: @guest_stars,
        director: @director,
        writer: @writer,
        updated_at: @updated_at,
        dvd_disc: @dvd_disc,
        dvd_season: @dvd_season,
        dvd_episode_number: @dvd_episode_number,
        dvd_chapter: @dvd_chapter,
        absolute_number: @absolute_number,
        image_url: @image_url,
        imdb_id: @imdb_id,
        language: @language,
        production_code: @production_code
      }
    end

  end
end
