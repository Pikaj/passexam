class Task < ActiveRecord::Base
	belongs_to :list
	has_many :progresses
	has_many :no_progresses

	def too_hard?
  		!self.no_progresses.empty?
  	end
end
