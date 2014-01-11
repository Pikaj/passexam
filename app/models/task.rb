class Task < ActiveRecord::Base
	belongs_to :list
	has_many :progresses
	has_many :noprogresses
end
