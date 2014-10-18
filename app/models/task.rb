class Task < ActiveRecord::Base
	belongs_to :list
	has_many :progresses
	has_many :no_progresses
  has_many :solutions

	def too_hard?
    !self.no_progresses.empty?
  end
end
