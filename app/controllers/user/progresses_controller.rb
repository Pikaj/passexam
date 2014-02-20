class User::ProgressesController < UserController

  def index
    @progresses = Progress.all
    respond_to  do |format|
      format.html 
      format.json {render :json => @progresses.to_json} 
    end
  end

  def new
    @progress = Progress.new
  end

  def create
    @progress = Progress.new(list_params)
  end

  def destroy
    @progres.destroy
  end

  private
    def set_progress
      @progress = Progress.find(params[:id])
    end

    def progress_params
      params.require(:progress).permit()
    end
end
