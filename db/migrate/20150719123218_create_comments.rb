class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :task, index: true
      t.references :user, index: true
      t.references :solution, index: true
      t.boolean :is_to_task
      t.string :content
      t.integer :stars

      t.timestamps
    end
  end
end
