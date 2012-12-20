module TheTvdb
  class Episode
    
    attr_accessor :remote_id, :season_remote_id, :season_number, :name, :number, :aired_at, :description

    def initialize(info)
      @remote_id = info['id'].to_i
      @season_remote_id = info['seasonid'].to_i
      @season_number = info['Combined_season'].to_i
      @name = info['EpisodeName']
      @number = info['EpisodeNumber'].to_i
      @aired_at = Date.parse(info['FirstAired'])
      @description = info['Overview']
    end
    
    def self.find(remote_id)
      info = TheTvdb.gateway.get_episode_details(remote_id)
      self.new(info)
    end

  end
end

# For reference, the episode yaml:
#
# id: '4245778'
# seasonid: '473271'
# EpisodeNumber: '9'
# EpisodeName: Blackwater
# FirstAired: '2012-05-28'
# GuestStars: 
# Director: Neil Marshall
# Writer: George R. R. Martin
# Overview: Tyrion and the Lannisters fight for their lives as Stannis’ fleet assaults King’s Landing.
# ProductionCode: 
# lastupdated: '1352849383'
# flagged: '0'
# DVD_discid: 
# DVD_season: '2'
# DVD_episodenumber: '9.0'
# DVD_chapter: 
# absolute_number: '19'
# filename: episodes/121361/4245778.jpg
# seriesid: '121361'
# mirrorupdate: '2012-11-13 15:28:01'
# IMDB_ID: tt2084342
# EpImgFlag: '2'
# Rating: '8.4'
# SeasonNumber: '2'
# Language: en
