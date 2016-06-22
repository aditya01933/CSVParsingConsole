class OperationsController < ApplicationController
	
	def index
	  @operations = Operation.new	  
	end

	def create		
		upload_file = FileUpload.new(file_path: operation_params["file"].path, file_name: operation_params["file"].original_filename )
		upload_file.parse_operation
	 	# @job_id = OperationWorker.perform_async(operation_params["file"].path, operation_params["file"].original_filename )	  
	  redirect_to operations_path	  
	end

	def operation_csv		
		@operations = Operation.where(company_id: params[:company_id] )
		respond_to do |format|
	    format.html
	    format.csv { send_data @operations.to_csv }
	  end
	end

	private

	def operation_params
		params.require(:operation).permit(:file)
	end
end