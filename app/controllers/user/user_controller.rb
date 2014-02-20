class User::UserController < UserController
  def index
  	@users = User.all
  	respond_to  do |format|
      format.html 
      format.json {render :json => @users.to_json} 
    end
  end
end
