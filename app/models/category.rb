class Category < ActiveRecord::Base
	has_many :lists
  belongs_to :subject
end
