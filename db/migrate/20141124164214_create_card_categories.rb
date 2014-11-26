class CreateCardCategories < ActiveRecord::Migration
  def change
    create_table :card_categories do |t|
      t.string :name
      t.references :subject, index: true

      t.timestamps
    end
  end
end
