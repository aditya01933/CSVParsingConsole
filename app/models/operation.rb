class Operation < ActiveRecord::Base
  belongs_to :company

  has_many :category_operations
  has_many :categories, through: :category_operations


  validates_presence_of :invoice_num, :company_id, :invoice_date, :amount, :operation_date, :kind, :status
  validates_numericality_of :amount, greater_than: 0
  validates_uniqueness_of :invoice_num
  scope :filter, -> (query) { where('lower(status) LIKE :query OR lower(kind) LIKE :query OR lower(invoice_num) LIKE :query OR lower(reporter) LIKE :query', query: "%#{query}%") }

  before_save :squish_columns

  def create_category
		category_array = self.kind.downcase.split(";")
    category_array.each do |name|
      category = Category.find_or_create_by(name: name) 
      self.categories << category      
    end  	
  end

  def self.to_csv
    CSV.generate do |csv|     
      column_names.insert(0,"company") unless column_names.include?("company")
      new_column = column_names - ["id", "created_at", "updated_at", "company_id"]
      csv << new_column
      all.each do |result|        
        csv << result.attributes.values_at(*column_names - ["company","id", "created_at", "updated_at", "company_id"] ).insert(0, result.company.name)
      end

    end
  end


    def squish_columns
      Operation.columns_hash.each do |key, value|
        if value.type == :string || value.type == :text         
          self[key] = self[key].try(:squish)
        end
      end
    end

    

end
