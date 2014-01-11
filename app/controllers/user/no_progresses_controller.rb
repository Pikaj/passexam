class User::NoProgressesController < UserController

  def index
    @noprogresses = NoProgress.all
  end

  def new
    @noprogress = NoProgress.new
  end
  
  def create
    @noprogress = NoProgress.new(list_params)
  end

  def destroy
    @noprogres.destroy
  end

  private
    def set_noprogress
      @noprogress = NoProgress.find(params[:id])
    end

    def noprogress_params
      params.require(:noprogress).permit()
    end
end