class OperationsController < ApplicationController
	
	def index
	  @operations = Operation.new	  
	end

	def create		
	 	# @job_id = OperationWorker.perform_async(operation_params["file"].path, operation_params["file"].original_filename )	  
	  upload_file = FileUpload.new(operation_params["file"].path, operation_params["file"].original_filename )
	    upload_file.parse_operation
	  redirect_to upload_progress_path	  
	end

	def operation_csv		
		@operations = Operation.where(company_id: params[:company_id] )
		respond_to do |format|
	    format.html
	    format.csv { send_data @operations.to_csv }
	  end
	end

	def upload_progress
		
	end

	private

	def operation_params
		params.require(:operation).permit(:file)
	end
end