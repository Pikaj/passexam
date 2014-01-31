class User::ListsController < UserController
  def new
    @list = List.new
  end

  def index
    @lists = List.all
    @category = Category.find(params[:category_id])
    @list = List.new
  end

  def show
    @list = List.find(params[:id])
    @task = Task.new
  end

  def create
    @list = List.new(list_params)
    @list.category_id = params[:category_id]
    @list.save
    redirect_to user_category_path(@list.category)
  end

  def edit
    @list = List.find(params[:id])
    @category = @list.category
  end

  def destroy
    @list = List.find(params[:id])
    @category = @list.category
    @list.destroy
    redirect_to user_category_path(@category)
  end

  def update
    @list = List.find(params[:id])

    if @list.update(params[:list].permit(:name))
      redirect_to user_category_path(@list.category)
    else
      render 'edit'
    end
  end

  private
    
  def list_params
    params.require(:list).permit(:name, :category_id)
  end
end
