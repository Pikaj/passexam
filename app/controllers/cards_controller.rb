class CardsController  < ApplicationController

  def correct_answer
    @table = session[:cards]["#{params[:card_category_id]}"]
    @card_previous = params[:id].to_i > 1
    @current_card_id = params[:id].to_i
    @card_next = @table.size-params[:id].to_i > 0
    @subject = Subject.find(params[:subject_id])
    @card_category = @subject.card_categories.find(params[:card_category_id])
    #@card = @card_category.cards.find(params[:id])
    #@next_cards = @card_category.cards.where(number: (@card.number + 1))
    points = current_user.points.where(card_id: @table[params[:id].to_i-1])
    if points.empty?
      point = Point.create(
          user_id: current_user,
          card_id: @table[params[:id].to_i-1],
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
    if !@card_next
      redirect_to end_subject_card_category_cards_path(@subject, @card_category)
    else
      redirect_to subject_card_category_card_path(@subject, @card_category, @current_card_id+1)
    end
  end

  def wrong_answer
    @table = session[:cards]["#{params[:card_category_id]}"]
    @card_previous = params[:id].to_i > 1
    @current_card_id = params[:id].to_i
    @card_next = @table.size-params[:id].to_i > 0
    @subject = Subject.find(params[:subject_id])
    @card_category = @subject.card_categories.find(params[:card_category_id])
    #@card = @card_category.cards.find(params[:id])
    #@next_cards = @card_category.cards.where(number: (@card.number + 1))
    points = current_user.points.where(card_id: @table[params[:id].to_i-1])
    if points.present?
      point = points.first
      point.percent = point.percent - point.percent/2.0
      point.level = 0.1
      point.percent = 0.0 if point.percent < 0.0
      point.save
    end
    if !@card_next
      redirect_to end_subject_card_category_cards_path(@subject, @card_category)
    else
      redirect_to subject_card_category_card_path(@subject, @card_category, @current_card_id+1)
    end
  end
  def start
    @subject = Subject.find(params[:subject_id])
    @card_category = @subject.card_categories.find(params[:card_category_id])
    table = @card_category.cards.map{ |c| c.id }
    table.shuffle!
    session[:cards] = {"#{params[:card_category_id]}" => table}
    redirect_to subject_card_category_card_path(@subject, @card_category, 1)

  end
  def show
    @table = session[:cards]["#{params[:card_category_id]}"]
    @subject = Subject.find(params[:subject_id])
    @card_categories = @subject.card_categories
    @card_category = @subject.card_categories.find(params[:card_category_id])
    @card = @card_category.cards.find(@table[params[:id].to_i-1])
    @card_previous = params[:id].to_i > 1
    @current_card_id = params[:id].to_i
    @card_next = @table.size-params[:id].to_i > 0
    #@card_next = @card_category.cards.where(number: (@card.number + 1)).first
    #@card_previous = @card_category.cards.where(number: (@card.number - 1)).first
  end

  def end
    session[:cards].delete("#{params[:card_category_id]}")
    redirect_to all_cards_subject_card_categories_path(params[:subject_id])
  end

end
