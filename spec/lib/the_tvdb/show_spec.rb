require_relative '../../spec_helper'
# For Ruby < 1.9.3, use this instead of require_relative
# require (File.expand_path('./../../../spec_helper', __FILE__))
describe TheTvdb::Show do

  before do
    VCR.insert_cassette 'series', record: :new_episodes
  end
    
  after do
    VCR.eject_cassette
  end
  
  let(:shows) { TheTvdb::Show.search('Game of Thrones') }
  let(:show) { shows.first }
  
  describe "#search" do
    it "should return related series when searching for a show" do
      shows.size.should be(1)
      show.name.should == 'Game of Thrones'
      show.id.should == 121361
      description = 'Based on the fantasy novel series "A Song of Ice and Fire," Game of Thrones explores the story of an epic battle among seven kingdoms and two ruling families in the only game that matters - the Game of Thrones. All seek control of the Iron Throne, the possession of which ensures survival through the 40-year winter to come.'
      show.description.should == description
    end
  end

  describe "#find" do
    it "should return episodes related series when searching for a show" do
      show.should have(3).episodes
    end
  end


end