class SubjectsController < ApplicationController

  def index
    @subjects = Subject.all
    render :layout => "no_subject"
  end

  def show
    @subject = Subject.find(params[:id])
  end
end
