class Card < ActiveRecord::Base
    belongs_to :sender, :class_name => "User", :foreign_key => "sender_id"
    belongs_to :recipient, :class_name => "User", :foreign_key => "recipient_id"

    attr_accessible :greeting, :recipient, :image_file_name

    validates :greeting, :presence => true, :length => { :maximum => 50 }
    validates :image_file_name, :presence => true
    validates :sender, :presence => true
    validates :recipient, :presence => true

    default_scope :order => 'cards.created_at DESC'

end
