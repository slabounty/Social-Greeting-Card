require 'spec_helper'

describe Signature do
    before(:each) do
        @signer = Factory(:user)
        @sender = Factory(:sender)
        @recipient = Factory(:recipient)
        @card = Factory(:card, :sender => @sender, :recipient => @recipient)
        @attr = { :signer_id => @signer.id, :card_id => @card.id, :message => "Congratulations!" }
    end

    it "should create a new instance given valid attributes" do
        Signature.create!(@attr)
    end

    it "should require a signer" do
        no_signer_signature = Signature.new(@attr.merge(:signer_id => nil))
        no_signer_signature.should_not be_valid
    end

    it "should require a card" do
        no_card_signature = Signature.new(@attr.merge(:card_id => nil))
        no_card_signature.should_not be_valid
    end

    it "should reject messages that are too long" do
        long_message_signature = Signature.new(@attr.merge(:message => ("a"*51)))
        long_message_signature.should_not be_valid
    end
end
