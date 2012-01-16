require 'spec_helper'

describe Card do
    before(:each) do
        @sender = Factory(:user)
        @recipient = Factory(:user, :email => "example@example.net")
        @template = Factory(:template)
        @attr = {   :greeting => "Hello World", 
                    :template => @template,
                    :recipient => @recipient,
                    :hash_value => "abcdef123456"
                }
    end

    it "should create a new instance given valid attributes" do
        @sender.sent_cards.create!(@attr)
    end

    describe "user associations" do
        before(:each) do
            @card = @sender.sent_cards.create(@attr)
        end

        it "should have a sender attribute" do
            @card.should respond_to(:sender)
        end

        it "should have a recipient attribute" do
            @card.should respond_to(:recipient)
        end

        it "should have the right sender" do
            @card.sender_id.should == @sender.id
            @card.sender.should == @sender
        end        

        it "should have the right recipient" do
            @card.recipient_id.should == @recipient.id
            @card.recipient.should == @recipient
        end        

    end

    describe "validations" do
        it "should require a user id" do
            Card.new(@attr).should_not be_valid
        end

        it "should require non-blank content" do
            @sender.sent_cards.build(:content => "     ").should_not be_valid
        end

        it "should reject long content" do
            @sender.sent_cards.build(:content => "a" * 150).should_not be_valid
        end
    end
end
