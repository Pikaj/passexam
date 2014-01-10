class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :url
      t.bool :status
      t.integer :level

      t.timestamps
    end
  end
end
