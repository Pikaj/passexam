class AddNumberToCard < ActiveRecord::Migration
  def change
    add_column :cards, :number, :integer
  end
end
