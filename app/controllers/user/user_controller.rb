class User::UserController < UserController
  def index
  	redirect_to user_categories_path
  end
end
