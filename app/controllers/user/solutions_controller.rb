class User::SolutionsController < UserController

  def create
    @subject = Subject.find(params[:subject_id])
    @category = @subject.categories.find(params[:category_id])
    @list = @category.lists.find(params[:list_id])
    @task = @list.tasks.find(params[:task_id])
    @solution = Solution.new(solution_params)
    @solution.task = @task
    @solution.user = current_user
    @solution.save
    redirect_to subject_category_list_task_path(@subject, @category, @list, @task)
  end

  def destroy
    @subject = Subject.find(params[:subject_id])
    @category = @subject.categories.find(params[:category_id])
    @list = @category.lists.find(params[:list_id])
    @task = @list.tasks.find(params[:task_id])
    @solution = @task.solutions.find(params[:id])
    @solution.destroy
    redirect_to subject_category_list_task_path(@subject, @category, @list, @task)
  end

  private
  def solution_params
    params.require(:solution).permit(:url)
  end

end