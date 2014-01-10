class List < ActiveRecord::Base
	belongs_to :category
	has_many :tasks
end
