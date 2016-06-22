class OperationWorker
	include Sidekiq::Worker
	sidekiq_options :retry => false

	  def perform(file_path, file_name)	 
	    upload_file = FileUpload.new(file_path, file_name)
	    upload_file.parse_operation
	  end

end