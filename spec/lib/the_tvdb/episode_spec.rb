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
  
  describe "find" do

    let(:episode) { TheTvdb::Episode.find(4245778) }
    
    it "should return all the info of the episode" do
      episode.name.should == 'Blackwater'
      episode.number.should == 9
      episode.aired_at.should == Date.parse('2012-05-28')
      episode.description.should == "Tyrion and the Lannisters fight for their lives as Stannis’ fleet assaults King’s Landing."
    end
    
  end

end