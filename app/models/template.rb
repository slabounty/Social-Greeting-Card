class Template < ActiveRecord::Base
    has_and_belongs_to_many :tags
    has_many :cards

    validates :image_name, :presence => true, :length => { :maximum => 50 }
end
