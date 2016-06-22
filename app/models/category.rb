class Category < ActiveRecord::Base
  	has_many :category_operation
  	has_many :operations, through: :category_operation

    validates_presence_of :name
end
