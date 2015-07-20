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

  def get_current_status(current_user)
    if current_user.task_done?(object)
      if current_user.is_verified_solution?(object)
        'done_verified'
      else
        'done_not_verified'
      end
    elsif current_user.task_too_hard?(object)
      'not_done_too_hard'
    elsif object.level != nil && object.level > 1
      'not_done_hard'
    else
      'not_done_easy'
    end
  end
end
