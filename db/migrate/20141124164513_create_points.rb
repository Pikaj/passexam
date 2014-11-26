class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.float :percent
      t.references :user, index: true
      t.references :card, index: true

      t.timestamps
    end
  end
end
