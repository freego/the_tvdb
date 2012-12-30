# encoding: utf-8

require (File.expand_path('./../../../spec_helper', __FILE__))
# For Ruby > 1.9.3, use this instead of require
# require_relative '../../spec_helper'

describe TheTvdb::Episode do

  before do
    VCR.insert_cassette 'episodes', record: :new_episodes
  end
    
  after do
    VCR.eject_cassette
  end
  
  describe ".find" do

    let(:episode) { TheTvdb::Episode.find(4245778) }
    
    it "should return all the info of the episode" do
      episode.name.should == 'Blackwater'
      episode.number.should == 9
      episode.season_number.should == 2
      episode.aired_at.should == '2012-05-28'
      episode.description.should == "Tyrion and the Lannisters fight for their lives as Stannis’ fleet assaults King’s Landing."
      episode.season_remote_id.should == 473271
      episode.guest_stars.should be_nil
      episode.director.should == [ 'Neil Marshall' ]
      episode.writer.should == [ 'George R. R. Martin' ]
      episode.updated_at.should == Time.at(1352849383)
      # episode.flagged.should == '0'
      episode.dvd_disc.should be_nil
      episode.dvd_season.should == '2'
      episode.dvd_episode_number.should == '9.0'
      episode.dvd_chapter.should be_nil
      episode.absolute_number.should == '19'
      episode.image_url.should == 'http://thetvdb.com/banners/episodes/121361/4245778.jpg'
      episode.imdb_id.should == 'tt2084342'
      episode.language.should == 'en'
      episode.production_code.should be_nil
      episode.rating.should == 8.4
      # RatingCount is not included in the detail data, just in the series package
      # episode.rating_count.should == 282
    end
    
  end

end

describe "Weird case episode" do

  before do
    VCR.insert_cassette 'weird_episode', record: :new_episodes
  end
    
  after do
    VCR.eject_cassette
  end
  

end