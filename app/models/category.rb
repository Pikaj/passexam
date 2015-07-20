class Category < ActiveRecord::Base
	has_many :lists
  belongs_to :subject

  scope :visible, -> { where(is_visible: true) }

end
