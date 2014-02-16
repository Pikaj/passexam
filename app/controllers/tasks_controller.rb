class TasksController < ApplicationController
  before_action :set_task, only: [:show]

  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
    render :show, :layout => 'sidebar'
  end

   def im_done
    @task = Task.find(params[:id])
    if !current_user.task_done?(@task)
      @progress = Progress.create(:task => @task, :user => current_user)
      @task.status = true
      @task.save
    end
    redirect_to category_list_task_path(@task.list.category, @task.list, @task), notice: 'Task was marked as done.'
  end

  def im_done_cancel
    @task = Task.find(params[:id])
    if current_user.task_done?(@task)
      Progress.all.where(:task_id => @task.id).delete_all
      @task.status = false
      @task.save
    end
    redirect_to category_list_task_path(@task.list.category, @task.list, @task), notice: 'Cancel marked as done'
  end

  def too_hard
    @task = Task.find(params[:id])
    if !current_user.task_too_hard?(@task)
      @progress = NoProgress.create(:task => @task, :user => current_user)
    end
    redirect_to category_list_task_path(@task.list.category, @task.list, @task), notice: 'Task was marked as too hard.'
  end

  def too_hard_cancel
    @task = Task.find(params[:id])
    if current_user.task_too_hard?(@task)
      NoProgress.all.where(:task_id => @task.id).delete_all
    end
    redirect_to category_list_task_path(@task.list.category, @task.list, @task), notice: 'Cancel marked as done.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:name, :url, :status, :level)
    end
end
