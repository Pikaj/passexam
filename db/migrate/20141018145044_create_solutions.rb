class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
      t.string :url
      t.references :user, index: true
      t.references :task, index: true

      t.timestamps
    end
  end
end
