class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_categories
  before_filter :set_lists
  # before_filter :redirect_signed_user
  before_filter :set_noprogresses
  before_filter :set_rating
  # layout :determine_layout

  before_filter :instantiate_controller_and_action_names

  def set_categories
    @categories = Category.all
  end

  def set_lists
    @lists = List.all
    @tasks_size = @lists.map{ |l| l.tasks.size }.sum
  end

  def set_noprogresses
    @lnoprogresses = NoProgress.all
  end

  # def redirect_signed_user
  #   if user_signed_in? and (!request.fullpath.include? '/user' and request.fullpath != '/')
  #     redirect_to "/user"+request.fullpath
  #   end
  # end

  def set_rating
    users = User.all
    @rating = users.sort_by{|obj| obj.no_progresses.size }.reverse
  end

  private
  # def determine_layout
  #   current_user ? "user" : "application"
  # end

  def instantiate_controller_and_action_names
    @current_action = action_name
    @current_controller = controller_name
  end

end
