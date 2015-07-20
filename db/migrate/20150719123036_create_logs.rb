class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.references :user, index: true
      t.integer :model_id
      t.string :model_class
      t.string :action_name

      t.timestamps
    end
  end
end
