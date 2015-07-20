class List < ActiveRecord::Base
	belongs_to :category
	has_many :tasks

  scope :visible, -> { where(is_visible: true) }

end
