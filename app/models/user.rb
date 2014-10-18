class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :progresses
  has_many :no_progresses
  has_many :solutions

  has_many :tasks, :through => :progresses
  has_many :tasks, :through => :noprogresses

  def task_done?(task)
  	!self.progresses.where(:task_id => task.id).empty?
  end

  def task_too_hard?(task)
  	!self.no_progresses.where(:task_id => task.id).empty?
  end

  def task_counter(subject)
    lists = subject.categories.map(&:lists).flatten
    tasks_size = lists.map{ |l| l.tasks.size }.sum
    if (tasks_size > 0)
      counter = (self.progresses.size.to_f/tasks_size.to_f)*100.0
    else 
      counter = 0
    end
    return counter.round(2)
  end

  def ready_form
    if self.email.split("@")[0].split(".")[0].last == "a"
      "przygotowana"
    else
      "przygotowany"
    end
  end
end
