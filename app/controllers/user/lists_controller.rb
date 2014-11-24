class User::ListsController < UserController
  def new
    @list = List.new
  end

  def index
    @subject = Subject.find(params[:subject_id])
    @category = @subject.categories.find(params[:category_id])
    @lists = @category.lists
    @list = List.new
  end

  def show
    @subject = Subject.find(params[:subject_id])
    @category = @subject.categories.find(params[:category_id])
    @list = @category.lists.find(params[:id])
    @task = Task.new
  end

  def create
    @list = List.new(list_params)
    @list.category_id = params[:category_id]
    @list.save
    redirect_to user_subject_category_path(@list.category.subject, @list.category)
  end

  def edit
    @subject = Subject.find(params[:subject_id])
    @category = @subject.categories.find(params[:category_id])
    @list = @category.lists.find(params[:id])
  end

  def destroy
    @subject = Subject.find(params[:subject_id])
    @category = @subject.categories.find(params[:category_id])
    @list = @category.lists.find(params[:id])
    @list.destroy
    redirect_to user_subject_category_path(@subject, @category)
  end

  def update
    @subject = Subject.find(params[:subject_id])
    @category = @subject.categories.find(params[:category_id])
    @list = @category.lists.find(params[:id])

    if @list.update(params[:list].permit(:name))
      redirect_to user_subject_category_path(@subject, @category)
    else
      render 'edit'
    end
  end

  private
    
  def list_params
    params.require(:list).permit(:name, :category_id)
  end
end
