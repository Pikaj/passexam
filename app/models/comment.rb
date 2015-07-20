class Comment < ActiveRecord::Base
  belongs_to :task
  belongs_to :user
  belongs_to :solution
end
