class User < ActiveRecord::Base
  include RoleModel
  roles_attribute :roles_mask
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :progresses
  has_many :no_progresses
  has_many :solutions
  has_many :points
  has_many :comments
  has_many :tickets
  has_many :logs

  has_many :tasks, :through => :progresses
  has_many :tasks, :through => :noprogresses

  scope :visible, -> { where(is_visible: true) }

  roles :admin, :manager, :student

  def full_name
    self.first_name + ' ' + self.last_name
  end

  def task_done?(task)
  	!self.progresses.where(:task_id => task.id).empty?
  end

  def card_done?(card)
    point = Point.where(card_id: card.id, user_id: self.id).first
    point.present? and point.percent >= 1.0
  end

  def card_level(card)
    point = Point.where(card_id: card.id, user_id: self.id).first
    point.nil? ? 0.0 : point.percent * 100
  end

  def category_done?(category)
    for card in category.cards
      point = Point.where(card_id: card.id, user_id: self.id).first
      if point.nil? or point.percent != 1.0
        return false
      end
    end
    true
  end

  def is_verified_solution?(task)
    self.progresses.where(:task_id => task.id).first.is_verified
  end

  def task_too_hard?(task)
  	!self.no_progresses.where(:task_id => task.id).empty?
  end

  def task_counter(subject)
    progresses_tasks = self.progresses_tasks(subject)
    lists = subject.categories.map(&:lists).flatten
    tasks_size = lists.map{ |l| l.tasks.size }.sum
    if tasks_size > 0
      counter = (progresses_tasks.to_f/tasks_size.to_f)*100.0
    else 
      counter = 0
    end
    counter.round(2)
  end

  def progresses_tasks(subject)
    progresses = self.progresses.where(:subject_id => subject.id)
    progresses.size
  end

  def point_counter(subject)
    points = 0.0
    categories_size = subject.card_categories.select{|c| c.cards.size > 0}.size
    for category in subject.card_categories
      if category.cards.size > 0
        points = points + (points_card_category(category) / category.cards.size.to_f)
      end
    end
    if categories_size > 0
      counter = (points/categories_size.to_f)*100.0
    else
      counter = 0
    end
    counter.round(2)
  end

  def points_cards(subject)
    points = self.points.select{|p| p.card.card_category.subject.id == subject.id and p.percent >= 1.0}
    points.size
  end

  def points_card_category(category)
    points = self.points.select{|p| p.card.card_category.id == category.id}
    points.empty? ? 0.0 : points.map{ |p| p.percent }.sum
  end

  def category_percent(category)
    ((points_card_category(category) / category.cards.size.to_f)*100.0).round(2)
  end

  def ready_form
    if self.email.split("@")[0].split(".")[0].last == "a"
      "przygotowana"
    else
      "przygotowany"
    end
  end
end
