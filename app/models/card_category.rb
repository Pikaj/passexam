class CardCategory < ActiveRecord::Base
  belongs_to :subject
  has_many :cards


end
