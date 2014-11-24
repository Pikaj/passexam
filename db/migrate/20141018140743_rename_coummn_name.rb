class RenameCoummnName < ActiveRecord::Migration
  def change
    rename_column :subjects, :secound_exam, :second_exam
  end
end
