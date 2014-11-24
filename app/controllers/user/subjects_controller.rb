class User::SubjectsController < UserController

  layout "no_subject"

  def index
    @subjects = Subject.all
    @subject = Subject.new
  end

  def edit
    @subject = Subject.find(params[:id])
  end

  def create
    @subject = Subject.new(subject_params)
    @subject.save
    redirect_to user_subjects_path
  end

  def update
    @subject = Subject.find(params[:id])
    if @subject.update(subject_params)
      redirect_to user_subjects_path
    else
      render 'edit'
    end
  end

  def destroy
    @subject = Subject.find(params[:id])
    @subject.destroy
    redirect_to user_subjects_path
  end

  private

  def subject_params
    params.require(:subject).permit(:name, :first_exam, :second_exam)
  end

end