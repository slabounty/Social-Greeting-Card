class Signature < ActiveRecord::Base

    belongs_to :card
    belongs_to :signer, :class_name => "User"

    attr_accessible :signer_id, :card_id, :signed, :message

    validates :signer_id, :presence => true
    validates :card_id, :presence => true
    validates :message, :length => { :maximum => 50 }

end
