class AddSubjectRefToCategories < ActiveRecord::Migration
  def change
    add_reference :categories, :subject, index: true
  end
end
