class AddIsVerifiedToProgresses < ActiveRecord::Migration
  def change
    add_column :progresses, :is_verified, :boolean
  end
end
