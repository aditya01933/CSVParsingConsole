require 'rails_helper'

RSpec.describe FileUpload, type: :model do
	it "should create record from csv file" do
		test_file = ActionDispatch::Http::UploadedFile.new({
		    :filename => 'valid_file.csv',
		    :type => 'file/csv',
		    :tempfile => File.new("#{Rails.root}/spec/fixtures/files/valid_file.csv")
		  })
	
		upload_file = FileUpload.new(test_file.path, test_file.original_filename, jid = 0)
		
	end
	
end
