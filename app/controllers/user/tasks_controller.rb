class User::TasksController < UserController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @subject = Subject.find(params[:subject_id])
    @category = @subject.categories.find(params[:category_id])
    @list = @category.lists.find(params[:list_id])
    @tasks = @list.tasks
  end

  def new
    @task = Task.new
  end

  def edit
    @subject = Subject.find(params[:subject_id])
    @category = @subject.categories.find(params[:category_id])
    @list = @category.lists.find(params[:list_id])
    @task = @list.tasks.find(params[:id])
  end

  def create
    @subject = Subject.find(params[:subject_id])
    @category = @subject.categories.find(params[:category_id])
    @list = @category.lists.find(params[:list_id])
    @task = Task.new(task_params)
    @task.list = @list
    @task.save
    redirect_to user_subject_category_list_path(@subject, @category, @list)
  end

  def update
    @subject = Subject.find(params[:subject_id])
    @category = @subject.categories.find(params[:category_id])
    @list = @category.lists.find(params[:list_id])
    @task = @list.tasks.find(params[:id])

    if @task.update(task_params)
      redirect_to user_subject_category_list_path(@subject, @category, @list)
    else
      render 'edit'
    end
  end

  def destroy
    @subject = Subject.find(params[:subject_id])
    @category = @subject.categories.find(params[:category_id])
    @list = @category.lists.find(params[:list_id])
    @task = @list.tasks.find(params[:id])
    @task.destroy
    redirect_to user_subject_category_list_path(@subject, @category, @list)
  end

  private
    def set_task
      @subject = Subject.find(params[:subject_id])
      @category = @subject.categories.find(params[:category_id])
      @list = @category.lists.find(params[:list_id])
      @task = @list.tasks.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:name, :url, :status, :level, :list_id)
    end
end
