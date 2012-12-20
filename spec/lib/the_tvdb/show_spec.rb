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
  
  describe "search" do

    let(:shows) { TheTvdb::Show.search('Game of Thrones') }
    let(:show) { shows.first }

    it "should return related series when searching for a show name" do
      shows.size.should be(1)
      show.name.should == 'Game of Thrones'
      show.remote_id.should == 121361
      description = 'Based on the fantasy novel series "A Song of Ice and Fire," Game of Thrones explores the story of an epic battle among seven kingdoms and two ruling families in the only game that matters - the Game of Thrones. All seek control of the Iron Throne, the possession of which ensures survival through the 40-year winter to come.'
      show.description.should == description
    end
    
  end

  describe "find" do

    let(:show) { TheTvdb::Show.find(121361) }
    let(:episode) { show.episodes[24] }
    
    it "should return info and episodes when looking up a show id" do
      show.should have(27).episodes
      episode.name.should == 'Blackwater'
    end
    
  end

end