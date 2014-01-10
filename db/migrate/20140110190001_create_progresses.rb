class CreateProgresses < ActiveRecord::Migration
  def change
    create_table :progresses do |t|
      t.references :task, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
