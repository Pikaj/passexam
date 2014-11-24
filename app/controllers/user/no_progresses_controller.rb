class User::NoProgressesController < UserController

  def index
    @subject = Subject.find(params[:subject_id])
    @noprogresses = @subject.no_progresses
    respond_to  do |format|
      format.html 
      format.json {render :json => @noprogresses.to_json} 
    end
  end
end