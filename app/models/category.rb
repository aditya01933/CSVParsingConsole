class Category < ActiveRecord::Base
	has_many :category_operations
	has_many :operations, through: :category_operations

  validates_presence_of :name
end
