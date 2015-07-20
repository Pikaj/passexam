class CardCategoriesController  < ApplicationController

  scope :visible, -> { where(is_visible: true) }

  def all_cards
    @subject = Subject.find(params[:subject_id])
    @card_categories = @subject.card_categories
    @cards = @subject.card_categories.map{|cat| cat.cards}.flatten
    @users = User.all
    @rating_cards = @users.sort_by{|obj| obj.point_counter(@subject)}.reverse
  end

end
