class Card < ActiveRecord::Base
  belongs_to :card_category
  has_many :points
end
