class Operation < ActiveRecord::Base
  belongs_to :company

  has_many :category_operations
  has_many :categories, through: :category_operations


  validates_presence_of :invoice_num, :invoice_date, :amount, :operation_date, :kind, :status
  validates_numericality_of :amount, greater_than: 0
  validates_uniqueness_of :invoice_num

  def create_category
		category_array = self.kind.split(";")
    category_array.each do |name|
      category = Category.find_or_create_by(name: name) 
      self.categories << category      
    end
  	
  end
end
