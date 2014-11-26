class AddLevelToPoints < ActiveRecord::Migration
  def change
    add_column :points, :level, :float, :default => 0.15
  end
end
