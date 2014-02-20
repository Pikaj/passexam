class User::UserController < UserController
  def index
  	@users = User.all
  	respond_to  do |format|
      format.html {redirect_to user_categories_path}
      format.json {render :json => @users.to_json} 
    end
  end
end
