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
		if params[:filter].present?
			query = params[:filter].try(:downcase)   
			@operations = @company.operations.where('lower(status) LIKE :query OR lower(kind) LIKE :query OR lower(invoice_num) LIKE :query OR lower(reporter) LIKE :query', query: "%#{query}%").page(params[:page]).per(7)			
		else
			@operations = @company.operations.page(params[:page]).per(7)
		end
		 respond_to do |format|
		 	format.js
		 end
	end

	
end
