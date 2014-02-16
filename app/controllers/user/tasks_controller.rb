class User::TasksController < UserController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.find(params[:id])
    @list = @task.list
    @category = @list.category
  end

  def create
    @task = Task.new(task_params)
    @task.list_id = params[:list_id]
    @task.save
    redirect_to category_list_path(@task.list.category, @task.list)
  end

  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      redirect_to user_category_list_path(@task.list.category, @task.list)
    else
      render 'edit'
    end
  end

  def destroy
    @list = @task.list
    @task.destroy
    redirect_to user_category_list_path(@list.category, @list)
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:name, :url, :status, :level, :list_id)
    end
end
