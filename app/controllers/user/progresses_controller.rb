class User::ProgressesController < UserController

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
