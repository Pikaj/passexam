class SolutionsController < ApplicationController

  def index
    @subject = Subject.find(params[:subject_id])
    @category = @subject.categories.find(params[:category_id])
    @list = @category.lists.find(params[:list_id])
    @task = @list.tasks.find(params[:task_id])
    if user_signed_in?
      @solutions = @task.solutions
    else
      @solutions = []
    end
  end
end