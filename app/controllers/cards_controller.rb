class CardsController  < ApplicationController

  def correct_answer
    @subject = Subject.find(params[:subject_id])
    @card_category = @subject.card_categories.find(params[:card_category_id])
    @card = @card_category.cards.find(params[:id])
    @next_cards = @card_category.cards.where(number: (@card.number + 1))
    points = current_user.points.where(card_id: params[:id])
    if points.empty?
      point = Point.create(
          user_id: current_user,
          card_id: params[:id],
          percent: 0.1
      )
      current_user.points << point
    else
      point = points.first
      point.percent = point.percent + point.level
      point.level = point.level + 0.05
      point.percent = 1.0 if point.percent > 1.0
      point.save
    end
    if @next_cards.empty?
      redirect_to all_cards_subject_card_categories_path(@subject)
    else
      redirect_to subject_card_category_card_path(@subject, @card_category, @next_cards.first)
    end
  end

  def wrong_answer
    @subject = Subject.find(params[:subject_id])
    @card_category = @subject.card_categories.find(params[:card_category_id])
    @card = @card_category.cards.find(params[:id])
    @next_cards = @card_category.cards.where(number: (@card.number + 1))
    points = current_user.points.where(card_id: params[:id])
    if points.empty?
      point = Point.create(
          user_id: current_user,
          card_id: params[:id],
          percent: 0.1
      )
      current_user.points << point
    else
      point = points.first
      point.percent = point.percent - point.percent/2.0
      point.level = 0.1
      point.percent = 0.0 if point.percent < 0.0
      point.save
    end
    if @next_cards.empty?
      redirect_to all_cards_subject_card_categories_path(@subject)
    else
      redirect_to subject_card_category_card_path(@subject, @card_category, @next_cards.first)
    end
  end

  def show
    @subject = Subject.find(params[:subject_id])
    @card_categories = @subject.card_categories
    @card_category = @subject.card_categories.find(params[:card_category_id])
    @card = @card_category.cards.find(params[:id])
    @card_next = @card_category.cards.where(number: (@card.number + 1)).first
    @card_previous = @card_category.cards.where(number: (@card.number - 1)).first
  end

end
