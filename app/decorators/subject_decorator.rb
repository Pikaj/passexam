class SubjectDecorator < Draper::Decorator
  include ActionView::Helpers::DateHelper
  delegate_all

  def time_to_exam
    if object.exam_date
      distance_of_time_in_words(Time.now, object.exam_date, :locale => 'pl')
    end
  end

end