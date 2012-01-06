require 'spec_helper'

describe Tag do

  before(:each) do
      @attr = { :tag => "congratulations" }
  end

  it "should create a new instance given valid attributes" do
      Tag.create!(@attr)
  end

  it "should require a tag" do
      no_tag = Tag.new(@attr.merge(:tag => nil ))
      no_tag.should_not be_valid
  end

    it "should reject tags that are too long" do
        long_tag = Tag.new(@attr.merge(:tag => ("a"*51)))
        long_tag.should_not be_valid
    end
end
