class TasksController < ApplicationController
  before_action :set_task, only: [:show]

  def index
    @tasks = Task.find(params[:list_id])
    render :json => @tasks.to_json 
  end

  def show
    @subject = Subject.find(params[:subject_id])
    @category = @subject.categories.find(params[:category_id])
    @list = @category.lists.find(params[:list_id])
    @task = @list.tasks.find(params[:id])
    @solution = Solution.new
  end

   def im_done
     @subject = Subject.find(params[:subject_id])
     @category = @subject.categories.find(params[:category_id])
     @list = @category.lists.find(params[:list_id])
     @task = @list.tasks.find(params[:id])
    if !current_user.task_done?(@task)
      @progress = Progress.create(:task => @task, :user => current_user, :subject => @subject)
      @task.status = true
      @task.save
    end
    redirect_to subject_category_list_task_path(@subject, @category, @list, @task), notice: 'Task was marked as done.'
  end

  def im_done_cancel
    @subject = Subject.find(params[:subject_id])
    @category = @subject.categories.find(params[:category_id])
    @list = @category.lists.find(params[:list_id])
    @task = @list.tasks.find(params[:id])
    if current_user.task_done?(@task)
      Progress.all.where(:task => @task, :user => current_user, :subject => @subject).delete_all
      @task.save
    end
    redirect_to subject_category_list_task_path(@subject, @category, @list, @task), notice: 'Cancel marked as done'
  end

  def too_hard
    @subject = Subject.find(params[:subject_id])
    @category = @subject.categories.find(params[:category_id])
    @list = @category.lists.find(params[:list_id])
    @task = @list.tasks.find(params[:id])
    if !current_user.task_too_hard?(@task)
      @progress = NoProgress.create(:task => @task, :user => current_user, :subject => @subject)
    end
    redirect_to subject_category_list_task_path(@subject, @category, @list, @task), notice: 'Task was marked as too hard.'
  end

  def too_hard_cancel
    @subject = Subject.find(params[:subject_id])
    @category = @subject.categories.find(params[:category_id])
    @list = @category.lists.find(params[:list_id])
    @task = @list.tasks.find(params[:id])
    if current_user.task_too_hard?(@task)
      NoProgress.all.where(:task => @task, :user => current_user, :subject => @subject).delete_all
    end
    redirect_to subject_category_list_task_path(@subject, @category, @list, @task), notice: 'Cancel marked as done.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @subject = Subject.find(params[:subject_id])
      @category = @subject.categories.find(params[:category_id])
      @list = @category.lists.find(params[:list_id])
      @task = @list.tasks.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:name, :url, :status, :level)
    end
end
