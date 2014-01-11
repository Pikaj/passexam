class User::NoProgressController < UserController

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