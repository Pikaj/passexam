class User::CardCategoriesController < UserController
  def new
    @card_category = CardCategory.new
  end

  def index
    @subject = Subject.find(params[:subject_id])
    @card_categories = @subject.card_categories
  end

  def show
    @subject = Subject.find(params[:subject_id])
    @card_category = @subject.card_categories.find(params[:id])
    @card = Card.new
  end

  def create
    @subject = Subject.find(params[:subject_id])
    @card_category = CardCategory.new(category_params)
    @card_category.subject = @subject
    @card_category.save
    redirect_to user_subject_categories_path(@subject)
  end

  def edit
    @subject = Subject.find(params[:subject_id])
    @card_category = @subject.card_categories.find(params[:id])
  end

  def destroy
    @subject = Subject.find(params[:subject_id])
    @card_category = @subject.card_categories.find(params[:id])
    @card_category.destroy
    redirect_to user_subject_categories_path(@subject)
  end

  def update
    @subject = Subject.find(params[:subject_id])
    @card_category = @subject.card_categories.find(params[:id])

    if @card_category.update(params[:card_category].permit(:name))
      redirect_to user_subject_categories_path(@subject)
    else
      render 'edit'
    end
  end

  private

  def category_params
    params.require(:card_category).permit(:name)
  end
end
