class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :question
      t.string :answer
      t.references :card_category, index: true

      t.timestamps
    end
  end
end
