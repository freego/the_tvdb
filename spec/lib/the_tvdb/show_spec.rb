require (File.expand_path('./../../../spec_helper', __FILE__))
# For Ruby > 1.9.3, use this instead of require
# require_relative '../../spec_helper'

describe TheTvdb::Show do

  before do
    VCR.insert_cassette 'shows', record: :new_episodes
  end
    
  after do
    VCR.eject_cassette
  end
  
  describe ".search" do

    let(:shows) { TheTvdb::Show.search('Game of Thrones') }
    let(:show) { shows.first }

    it "should return related series when searching for a show name" do
      shows.size.should be(1)
      show.name.should == 'Game of Thrones'
      show.remote_id.should == 121361
      description = 'Based on the fantasy novel series "A Song of Ice and Fire," Game of Thrones explores the story of an epic battle among seven kingdoms and two ruling families in the only game that matters - the Game of Thrones. All seek control of the Iron Throne, the possession of which ensures survival through the 40-year winter to come.'
      show.description.should == description
      show.imdb_id.should == 'tt0944947'
      show.zap2it_id.should == 'SH01389809'
      show.first_aired.should == '2011-04-17'
      show.banner.should == 'http://thetvdb.com/banners/graphical/121361-g26.jpg'
      show.language.should == 'en'
    end
    
    it "should return nil as a banner on no image" do
      no_image_show = TheTvdb::Show.search("Good Girls Don't").first
      no_image_show.banner.should be_nil
    end
    
  end

  describe ".find" do
    
    context "Game of Thrones" do

      let(:show) { TheTvdb::Show.find(121361) }
      let(:episode) { show.episodes[24] }
      
      it "should return advanced information if available" do
        show.name.should == 'Game of Thrones'
        show.airs_day_of_week.should == "Sunday"
        show.airs_time.should == "9:00 PM"
        show.content_rating.should == 'TV-MA'
        show.genre.should == [ 'Action and Adventure', 'Drama', 'Fantasy' ]
        show.network.should == 'HBO'
        show.runtime.should == 60
        show.fanart.should == 'http://thetvdb.com/banners/fanart/original/121361-15.jpg'
        show.rating.should == 9.4
        show.rating_count.should == 411
        show.status.should == 'Continuing'
        show.added_at.should == '2009-10-26 16:51:46'
        show.last_updated.should == '1355962803'
        show.poster.should == 'http://thetvdb.com/banners/posters/121361-4.jpg'
      end

      it "should return an array of actors" do
        show.actors.should include('Peter Dinklage')
        show.should have(46).actors
      end
    
      it "should return info and episodes when looking up a show id" do
        show.should have(27).episodes
        episode.name.should == 'Blackwater'
      end

      it "should return an array of episodes even if there is just one episode" do
        one_episode_show = TheTvdb::Show.find(77856)
        one_episode_show.episodes.size.should == 1
      end

    end

    it "should return an array of episodes even if there is just one episode" do
      one_episode_show = TheTvdb::Show.find(77856)
      one_episode_show.episodes.size.should == 1
    end

  end

end
