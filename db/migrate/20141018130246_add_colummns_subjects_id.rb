class AddColummnsSubjectsId < ActiveRecord::Migration
  def change
    add_reference :progresses, :subject, index: true
    add_reference :no_progresses, :subject, index: true
  end
end
