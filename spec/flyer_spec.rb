require 'spec_helper'

describe ".new" do
  context "should return flyer name" do
    it "returns flyer's name and url" do
      @flyer = double("Flyer")
      @flyer.stub(:name).and_return("Fake name")
      @flyer.stub(:url).and_return("http://fakeurl.com")
      @flyer.name.should eq("Fake name")
      @flyer.url.should eq("http://fakeurl.com")
    end
  end
end
