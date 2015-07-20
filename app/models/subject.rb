class Subject < ActiveRecord::Base
  has_many :categories
  has_many :progresses
  has_many :no_progresses
  has_many :card_categories
  has_many :tickets

  scope :visible, -> { where(is_visible: true) }


  def exam_date
    now = Time.now
    if self.first_exam.present?
      if self.first_exam > now
        self.first_exam
      elsif self.second_exam.present?
        if self.second_exam > now
          self.second_exam
        end
      end
    end
  end

  def exam_date_first
    self.first_exam.present? ? self.first_exam.strftime("%d-%m-%Y %H:%M") : ""
  end

  def exam_date_second
    self.second_exam.present? ? self.second_exam.strftime("%d-%m-%Y %H:%M") : ""
  end

  def tasks_size
    self.categories.map(&:lists).flatten.map(&:tasks).flatten.size
  end

  def cards_size
    self.card_categories.map(&:cards).flatten.size
  end

  def solutions_size
    self.categories.map(&:lists).flatten.map(&:tasks).flatten.map(&:solutions).flatten.size
  end

  def has_ticket_user(user)
    self.tickets.select{|t| t.user==user}.size > 0
  end

  def has_ticket_accepted?(user)
    self.tickets.select{|t| t.user==user}.first.accepted
  end
end
