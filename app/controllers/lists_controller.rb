class ListsController < ApplicationController
  before_action :set_list, only: [:show]

  def index
    @category = Category.find(params[:category_id])
    @lists = @category.lists
    render :json => @lists.to_json 
  end

  def show
    @list = List.find(params[:id])
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def list_params
      params.require(:list).permit(:name)
    end
end
