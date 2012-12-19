require_relative '../../spec_helper'
# For Ruby < 1.9.3, use this instead of require_relative
# require (File.expand_path('./../../../spec_helper', __FILE__))
describe TheTvdb::Show do
  
  describe "search" do
    VCR.use_cassette 'series_search', record: :new_episodes do
      it "should return related series when searching for a show" do
        shows = TheTvdb::Show.search('Game of Thrones')
        shows.size.should be(1)
        show = shows.first
        show['SeriesName'].should == 'Game of Thrones'
      end
    end
  end

end