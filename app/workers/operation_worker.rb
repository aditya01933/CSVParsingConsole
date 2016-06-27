class OperationWorker
	include Sidekiq::Worker
	sidekiq_options :retry => false

	  def perform(file_path, file_name)	 
	    upload_file = FileUpload.new(file_path, file_name, jid)
	    begin
	      upload_file.parse_operation
	    rescue RuntimeError => e	      
	      puts e
	    end
	  end

end