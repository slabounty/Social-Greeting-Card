require 'spec_helper'

describe User do

    before(:each) do
        @attr = { 
            :first_name => "Example", 
            :last_name => "User", 
            :email => "exampleuser@gmail.com",
            :password => "foobar",
            :password_confirmation => "foobar" 
        }
    end

    it "should create a new instance given valid attributes" do
        User.create!(@attr)
    end

    it "should require a first_name" do
        no_first_name_user = User.new(@attr.merge(:first_name => ""))
        no_first_name_user.should_not be_valid
    end

    it "should require a last_name" do
        no_last_name_user = User.new(@attr.merge(:last_name => ""))
        no_last_name_user.should_not be_valid
    end

    it "should require an email address" do
        no_email_user = User.new(@attr.merge(:email => ""))
        no_email_user.should_not be_valid
    end

    it "should reject first names that are too long" do
        long_first_name_user = User.new(@attr.merge(:first_name => ("a"*51)))
        long_first_name_user.should_not be_valid
    end

    it "should reject last names that are too long" do
        long_last_name_user = User.new(@attr.merge(:last_name => ("a"*51)))
        long_last_name_user.should_not be_valid
    end

    it "should accept valid email addresses" do
        addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
        addresses.each do |address|
            valid_email_user = User.new(@attr.merge(:email => address))
            valid_email_user.should be_valid
        end
    end

    it "should reject invalid email addresses" do
        addresses = %w[user@foo,com THE_USER_at_foo.org first.last@foo.]
        addresses.each do |address|
            invalid_email_user = User.new(@attr.merge(:email => address))
            invalid_email_user.should_not be_valid
        end
    end

    it "should reject duplicate email addresses" do
        User.create!(@attr)
        user_with_duplicate_email = User.new(@attr)
        user_with_duplicate_email.should_not be_valid
    end
 
    it "should reject email addresses identical to case" do
        upcased_email = @attr[:email].upcase
        User.create!(@attr.merge(:email => upcased_email))
        user_with_duplicate_email = User.new(@attr)
        user_with_duplicate_email.should_not be_valid
    end

    describe "password validations" do
        it "should require a password" do
            User.new(@attr.merge(:password => "", :password_confirmation => "")).should_not be_valid
        end

        it "should require a matching password confirmation" do
            User.new(@attr.merge(:password_confirmation => "invalid")).should_not be_valid
        end

        it "should reject short passwords" do
            short = "a"*5
            User.new(@attr.merge(:password => short, :password_confirmation => short)).should_not be_valid
        end
        
        it "should reject long passwords" do
            long = "a"*41
            User.new(@attr.merge(:password => long, :password_confirmation => long)).should_not be_valid
        end
        
    end

    describe "password encryption" do
        before(:each) do
            @user = User.create!(@attr)
        end

        it "should have an encrypted password attribute" do
            @user.should respond_to(:encrypted_password)
        end

        it "should set the encrypted password" do
            @user.encrypted_password.should_not be_blank
        end

        describe "has_password? method" do
            it "should be true if the passwords match" do
                @user.has_password?(@attr[:password]).should be_true
            end

            it "should be false if the passwords don't match" do
                @user.has_password?("invalid").should be_false
            end
        end

        describe "authenticate method" do
            it "should return nil on email/password mismatch" do
                wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
                wrong_password_user.should be_nil
            end

            it "should return nil for an email address with no user" do
                nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
                nonexistent_user.should be_nil
            end

            it "should return the user on email/password match" do
                matching_user = User.authenticate(@attr[:email], @attr[:password])
                matching_user.should == @user
            end
        end
    end

    describe "admin attribute" do
        before(:each) do
            @user = User.create!(@attr)
        end

        it "should respond to admin" do
            @user.should respond_to(:admin)
        end

        it "should not be an admin by default" do
            @user.should_not be_admin
        end

        it "should be convertible to an admin" do
            @user.toggle!(:admin)
            @user.should be_admin
        end
    end

    describe "cards associations" do
        
        before(:each) do
            @sender = Factory(:sender)
            @recipient = Factory(:recipient)
            @template = Factory(:template)
            @card1 = Factory(:card, :sender => @sender, :recipient => @recipient, :template => @template, :created_at => 1.day.ago)
            @card2 = Factory(:card, :sender => @sender, :recipient => @recipient, :template => @template, :created_at => 1.hour.ago)
        end

        it "should have a sent cards attribute" do
            @sender.should respond_to(:sent_cards)
        end

        it "should have a received cards attribute" do
            @recipient.should respond_to(:received_cards)
        end

        it "should have the cards in the right order" do
            @sender.sent_cards.should == [@card2, @card1]
        end

        it "should have the cards in the right order" do
            @recipient.received_cards.should == [@card2, @card1]
        end

    end

    describe "signer associations" do
        before(:each) do
            @sender = Factory(:sender)
            @recipient = Factory(:recipient)
            @template = Factory(:template)
            @card = Factory(:card, :sender => @sender, :recipient => @recipient, :template => @template, :created_at => 1.day.ago)
            @signer = Factory(:signer)
            @card.signers << @signer
        end

        it "should have a signed cards attribute" do
            @signer.should respond_to(:signed_cards)
        end

        it "should be able to sign a card" do
            @signer.signed_cards[0].should == @card
        end

        it "should be able to add a signed message" do
        end

    end
end
