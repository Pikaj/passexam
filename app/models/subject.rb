class Subject < ActiveRecord::Base
  has_many :categories
  has_many :progresses
  has_many :no_progresses

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
end
