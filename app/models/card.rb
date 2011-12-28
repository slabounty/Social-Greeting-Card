class Card < ActiveRecord::Base
    belongs_to :sender, :class_name => "User"
    belongs_to :recipient, :class_name => "User"

    has_many :signatures
    has_many :signers, :through => :signatures, :foreign_key => 'signer_id'

    attr_accessible :greeting, :recipient, :image_file_name

    validates :greeting, :presence => true, :length => { :maximum => 50 }
    validates :image_file_name, :presence => true
    validates :sender, :presence => true
    validates :recipient, :presence => true

    default_scope :order => 'cards.created_at DESC'

end
