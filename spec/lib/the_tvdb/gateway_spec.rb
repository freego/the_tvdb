require (File.expand_path('./../../../spec_helper', __FILE__))
# For Ruby > 1.9.3, use this instead of require
# require_relative '../../spec_helper'

describe TheTvdb::Gateway do

  before do
    VCR.insert_cassette 'gateway', record: :new_episodes
  end
    
  after do
    VCR.eject_cassette
  end
  
  let(:gateway) { TheTvdb.gateway }

  describe "#time" do
    it "should return the current server time for update purposes" do
      gateway.time.should == '1356080760'
    end
  end
  
  describe "#update" do
    it "should return an array of updated series and episodes" do
      result = TheTvdb.update(1356079970, true)
      result[:time].should == 1356080761
      result[:shows].should have(3).items
      gateway.last_updated.should == 1356080761
    end

    it "should return the ids of updated series" do
      result = TheTvdb.update(1356079970)
      result[:shows].should have(3).items
      result[:shows].first.should == 80367
      gateway.last_updated.should == 1356080761
    end
  end

end
