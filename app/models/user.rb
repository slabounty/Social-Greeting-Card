require 'digest'

class User < ActiveRecord::Base

    has_many :sent_cards, :class_name => "Card", :foreign_key => "sender_id", :dependent => :destroy
    has_many :received_cards, :class_name => "Card", :foreign_key => "recipient_id", :dependent => :destroy

    has_many :signatures, :foreign_key => "signer_id", :dependent => :destroy
    has_many :signed_cards, :through => :signatures, :source => :card , :dependent => :destroy

    attr_accessor :password
    attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :active

    email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    validates :first_name, :presence => true, :length => { :maximum => 50 }
    validates :last_name, :presence => true, :length => { :maximum => 50 }
    validates :email, :presence => true, 
              :format => { :with => email_regex },
              :uniqueness => { :case_sensitive => false }
    validates :password, :presence => true,
        :confirmation => true,
        :length => { :within => 6..40 }

    before_create :add_hash_value
    before_save :encrypt_password

    def has_password?(submitted_password)
        # Compare encrypted_password with the encrypted version
        # of submitted_password
        encrypted_password == encrypt(submitted_password)
    end

    def display_name
        active == true ? "#{first_name} #{last_name}" : email
    end

    def self.find_or_create_inactive_by_email(email_address)
        User.find_or_create_by_email(email_address,
            { :password => 'password',
            :password_confirmation => 'password',
            :first_name => 'First',
            :last_name => 'Last',
            :active => false})
    end

    def self.authenticate(email, submitted_password)
        user = find_by_email(email)
        return nil if user.nil?
        return user if user.has_password?(submitted_password)
    end

    def self.authenticate_with_salt(id, cookie_salt)
        user = find_by_id(id)
        (user && user.salt == cookie_salt) ? user : nil
    end

    private

    def add_hash_value
        self.hash_value = email.hash
    end

    def encrypt_password
        self.salt = make_salt if new_record?
        self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
        secure_hash("#{salt}--#{string}")
    end

    def make_salt
        secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
        Digest::SHA2.hexdigest(string)
    end
end
