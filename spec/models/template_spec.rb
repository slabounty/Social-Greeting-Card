require 'spec_helper'

describe Template do
    before(:each) do
        @attr = { :image_name => "birthday_cake.jpeg" }
    end

    it "should create a new instance given valid attributes" do
        Template.create!(@attr)
    end

    it "should require an image_name" do
        no_image_name = Template.new(@attr.merge(:image_name => nil ))
        no_image_name.should_not be_valid
    end

    it "should reject image_names that are too long" do
        long_image_name = Template.new(@attr.merge(:image_name => ("a"*51)))
        long_image_name.should_not be_valid
    end

    describe "tagging" do
        before do
            @template = Factory(:template)
            @tag = Factory(:tag)
            @template.tags << @tag
        end

        it "should have a tag attribute" do
            @template.should respond_to(:tags) 
        end
    
        it "should be able to sign a tag" do
            @template.tags[0].should == @tag
        end

    end
end
