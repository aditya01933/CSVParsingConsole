class OperationsController < ApplicationController
	
	def index
	  @operations = Operation.new	  
	end

	def create
		if FileUpload.csv_file? operation_params["file"].original_filename		
	 		@job_id = OperationWorker.perform_async(operation_params["file"].path, operation_params["file"].original_filename )  
			redirect_to upload_progress_path(job_id: @job_id)	
		else
			flash[:notice] = "unsupported file format"
			redirect_to companies_path
		end	  
	end

	def operation_csv		
		if params[:filter].present?
			query = params[:filter].try(:downcase)
			@operations = Operation.where(company_id: params[:company_id] ).filter(query)
		else
			@operations = Operation.where(company_id: params[:company_id] )
		end
		respond_to do |format|
	    format.html
	    format.csv { send_data @operations.to_csv }
	  end
	end

	def upload_progress
		@job_id = params[:job_id]
	end


	private

	def operation_params
		params.require(:operation).permit(:file)
	end
end