class User::ProgressesController < UserController

  def index
    @subject = Subject.find(params[:subject_id])
    @users = User.all
    @rating = @users.sort_by{|obj| obj.task_counter(@subject) }.reverse
    @progresses = @subject.progresses
    respond_to  do |format|
      format.html 
      format.json {render :json => @progresses.to_json} 
    end
  end

end
