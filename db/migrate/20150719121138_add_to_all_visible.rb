class AddToAllVisible < ActiveRecord::Migration
  def change
    add_column :categories, :is_visible, :boolean, :default => true
    add_column :lists, :is_visible, :boolean, :default => true
    add_column :tasks, :is_visible, :boolean, :default => true
    add_column :subjects, :is_visible, :boolean, :default => true
    add_column :solutions, :is_visible, :boolean, :default => true
    add_column :card_categories, :is_visible, :boolean, :default => true
    add_column :cards, :is_visible, :boolean, :default => true
  end
end
