class User::TasksController < UserController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = Task.find(params[:id])
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  def im_done
    @task = Task.find(params[:id])
    if !current_user.task_done?(@task)
      @progress = Progress.create(:task => @task, :user => current_user)
      @task.status = true
      @task.save
    end
    redirect_to user_category_list_task_path(@task.list.category, @task.list, @task), notice: 'Task was marked as done.'
  end

  def im_done_cancel
    @task = Task.find(params[:id])
    if current_user.task_done?(@task)
      Progress.all.where(:task_id => @task.id).delete_all
      @task.status = false
      @task.save
    end
    redirect_to user_category_list_task_path(@task.list.category, @task.list, @task), notice: 'Task was marked as done.'
  end

  def too_hard
    @task = Task.find(params[:id])
    if !current_user.task_too_hard?(@task)
      @progress = NoProgress.create(:task => @task, :user => current_user)
    end
    redirect_to user_category_list_task_path(@task.list.category, @task.list, @task), notice: 'Task was marked as too hard.'
  end

  def too_hard_cancel
    @task = Task.find(params[:id])
    if current_user.task_too_hard?(@task)
      NoProgress.all.where(:task_id => @task.id).delete_all
    end
    redirect_to user_category_list_task_path(@task.list.category, @task.list, @task), notice: 'Task was marked as done.'
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
    @list = @task.list
    @category = @list.category
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @task.list_id = params[:list_id]
    @task.save
    redirect_to user_category_list_path(@task.list.category, @task.list)
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      redirect_to user_category_list_path(@task.list.category, @task.list)
    else
      render 'edit'
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @list = @task.list
    @task.destroy
    redirect_to user_category_list_path(@list.category, @list)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:name, :url, :status, :level, :list_id)
    end
end
