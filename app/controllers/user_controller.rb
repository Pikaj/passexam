class UserController < ApplicationController
  before_filter :check_user

  private
  def check_user
    if !user_signed_in?
      redirect_to new_user_session_path
    end
  end
end