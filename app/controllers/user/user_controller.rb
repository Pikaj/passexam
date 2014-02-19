class User::UserController < UserController
  def index
  	@users = User.all
  	render :json => @users.to_json
  end
end
