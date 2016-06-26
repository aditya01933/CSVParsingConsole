class CompanyDecorator 
  attr_reader :company

  def initialize(company)
  	@company = company
  end

  def number_of_operations
  	company.operations.count
  end

  def average_of_amount
  	company.operations.average(:amount).try(:round) || 0
  end

  def highest_of_month
  	company.operations.where("created_at >= ?", Time.zone.now.beginning_of_month).maximum("amount") || 0
	end

	def accepted_operations
		@company.operations.where(status: "accepted").count || 0
	end

end
