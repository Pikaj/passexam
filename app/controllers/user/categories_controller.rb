class User::CategoriesController < UserController
  def new
    @category = Category.new
  end

  def index
    @subject = Subject.find(params[:subject_id])
    @categories = @subject.categories
    @category = Category.new
  end

  def show
    @subject = Subject.find(params[:subject_id])
    @category = @subject.categories.find(params[:id])
    @list = List.new
  end

  def create
    @subject = Subject.find(params[:subject_id])
    @category = Category.new(category_params)
    @category.subject = @subject
    @category.save
    redirect_to user_subject_categories_path(@subject)
  end

  def edit
    @subject = Subject.find(params[:subject_id])
    @category = @subject.categories.find(params[:id])
  end

  def destroy
    @subject = Subject.find(params[:subject_id])
    @category = @subject.categories.find(params[:id])
    @category.destroy
    redirect_to user_subject_categories_path(@subject)
  end

  def update
    @subject = Subject.find(params[:subject_id])
    @category = @subject.categories.find(params[:id])

    if @category.update(params[:category].permit(:name))
      redirect_to user_subject_categories_path(@subject)
    else
      render 'edit'
    end
  end

  private
    
  def category_params
    params.require(:category).permit(:name)
  end
end
