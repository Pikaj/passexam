class CreateNoProgresses < ActiveRecord::Migration
  def change
    create_table :no_progresses do |t|
      t.references :task, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
