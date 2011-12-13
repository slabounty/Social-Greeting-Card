require 'spec_helper'

describe User do

    before(:each) do
        @attr = { :first_name => "Example", :last_name => "User", :email => "exampleuser@gmail.com" }
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
end
