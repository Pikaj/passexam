class Task < ActiveRecord::Base
	belongs_to :list
	has_many :progresses
	has_many :no_progresses
  has_many :solutions
  has_many :comments

  scope :visible, -> { where(is_visible: true) }

  def too_hard?
    !self.no_progresses.empty?
  end
end
