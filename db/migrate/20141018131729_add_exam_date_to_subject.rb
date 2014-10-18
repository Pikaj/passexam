class AddExamDateToSubject < ActiveRecord::Migration
  def change
    add_column :subjects, :first_exam, :datetime
    add_column :subjects, :secound_exam, :datetime
  end
end
