class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.references :user, index: true
      t.references :subject, index: true
      t.boolean :accepted
      t.boolean :is_access
      t.boolean :is_manage

      t.timestamps
    end
  end
end
