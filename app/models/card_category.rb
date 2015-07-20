class CardCategory < ActiveRecord::Base
  belongs_to :subject
  has_many :cards

  scope :visible, -> { where(is_visible: true) }
end
