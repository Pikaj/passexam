class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :progresses
  has_many :no_progresses

  has_many :tasks, :through => :progresses
  has_many :tasks, :through => :noprogresses

  def task_done?(task)
  	!self.progresses.where(:task_id => task.id).empty?
  end

  def task_too_hard?(task)
  	!self.no_progresses.where(:task_id => task.id).empty?
  end

  def task_counter
    if (!Task.all.empty?)
      counter = (self.progresses.size.to_f/Task.all.size.to_f)*100.0
    else 
      counter = 0
    end
    return counter.round(2)
  end

  def rating
    users = User.all
    rating = users.sort_by{|obj| obj.no_progresses.size }
    return rating.reverse
  end

end
