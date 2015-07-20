class Solution < ActiveRecord::Base
  belongs_to :user
  belongs_to :task

  scope :visible, -> { where(is_visible: true) }

end
