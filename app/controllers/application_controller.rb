class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # before_filter :redirect_signed_user
  before_filter :set_home_values
  # layout :determine_layout

  before_filter :instantiate_controller_and_action_names
  before_filter :store_location


  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    if (request.fullpath != "/users/sign_in" &&\
        request.fullpath.gsub( /\?.*/, "" ) != "/users/confirmation" && \
        request.fullpath != "/users/sign_up" && \
        request.fullpath != "/users" && \
        request.fullpath != "/registration_completed" && \
        !request.xhr?) and (!user_signed_in?)
      session[:previous_url] = request.fullpath
    end
  end

  def after_sign_in_path_for(resource)
    path = session[:previous_url] || root_path
    session[:previous_url] = nil
    return path
  end

  def set_home_values
    @noprogresses = NoProgress.all
    @users_size = User.all.size
    @tasks_size = Task.all.size
    @cards_size = Card.all.size
    @solutions_size = Solution.all.size
  end

  # def redirect_signed_user
  #   if user_signed_in? and (!request.fullpath.include? '/user' and request.fullpath != '/')
  #     redirect_to "/user"+request.fullpath
  #   end
  # end

  private
  # def determine_layout
  #   current_user ? "user" : "application"
  # end

  def instantiate_controller_and_action_names
    @current_action = action_name
    @current_controller = controller_name
  end

end
