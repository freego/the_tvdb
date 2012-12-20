module TheTvdb
  class Episode
    
    attr_accessor :remote_id, :season_remote_id, :season_number, :name, :number, :aired_at

    def initialize(info)
      @remote_id = info['id'].to_i
      @season_remote_id = info['seasonid'].to_i
      @season_number = info['Combined_season'].to_i
      @name = info['EpisodeName']
      @number = info['EpisodeNumber']
      @aired_at = info['FirstAired']
    end

  end
end