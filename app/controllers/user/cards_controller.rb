class User::CardsController < UserController
  def new
    @card = Card.new
  end

  def index
    @subject = Subject.find(params[:subject_id])
    @card_category = @subject.card_categories.find(params[:card_category_id])
    @card = @card_category.cards
  end

  def create
    @subject = Subject.find(params[:subject_id])
    @card_category = @subject.card_categories.find(params[:card_category_id])
    @card = Card.new(card_params)
    @card.card_category = @card_category
    @card.save
    redirect_to user_subject_card_category_path(@subject, @card_category)
  end

  def edit
    @subject = Subject.find(params[:subject_id])
    @card_category = @subject.card_categories.find(params[:card_category_id])
    @card = @card_category.cards.find(params[:id])
  end

  def destroy
    @subject = Subject.find(params[:subject_id])
    @card_category = @subject.card_categories.find(params[:card_category_id])
    @card = @card_category.cards.find(params[:id])
    @card.destroy
    redirect_to user_subject_card_category_path(@subject, @card_category)
  end

  def update
    @subject = Subject.find(params[:subject_id])
    @card_category = @subject.card_categories.find(params[:card_category_id])
    @card = @card_category.cards.find(params[:id])

    if @card.update(card_params)
      redirect_to user_subject_card_category_path(@subject, @card_category)
    else
      render 'edit'
    end
  end

  private

  def card_params
    params.require(:card).permit(:question, :answer, :number)
  end
end
