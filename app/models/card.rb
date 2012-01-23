class Card < ActiveRecord::Base
    belongs_to :sender, :class_name => "User"
    belongs_to :recipient, :class_name => "User"
    belongs_to :template

    has_many :signatures
    has_many :signers, :through => :signatures, :foreign_key => 'signer_id'

    attr_accessible :greeting, :recipient, :template # , :hash_value

    validates :greeting, :presence => true, :length => { :maximum => 50 }
    validates :sender, :presence => true
    validates :recipient, :presence => true
    validates :template, :presence => true
#    validates :hash_value, :presence => true

    default_scope :order => 'cards.created_at DESC'

    before_create :add_hash_value

    private

    def add_hash_value
        self.hash_value = "#{Time.now}/#{self.greeting}".hash
    end

end
