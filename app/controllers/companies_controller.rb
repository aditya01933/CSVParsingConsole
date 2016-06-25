class CompaniesController < ApplicationController
	

	def index
		@operations = Operation.new	 
		@companies = Company.all
		if params[:filter].present?
			@filter = params[:filter]
		end
	end

	def show
		@company = Company.find(params[:id])
		@operations = @company.operations.page(params[:page]).per(5)
		@company_decorator = CompanyDecorator.new(@company)
		 respond_to do |format|
		 	format.js
		 end
	end
	
end
