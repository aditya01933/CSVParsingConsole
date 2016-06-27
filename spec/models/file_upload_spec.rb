require 'rails_helper'

RSpec.describe FileUpload, type: :model do

  def file(file_name)
    test_file =ActionDispatch::Http::UploadedFile.new({
	    :filename => file_name,
	    :type => 'file/csv',
	    :tempfile => File.new("#{Rails.root}/spec/fixtures/files/#{file_name}")
	  })
	  upload_file = FileUpload.new(test_file.path, test_file.original_filename, jid = 0)
  	upload_file.parse_operation
  end
 
  let(:operation_count){ Operation.count }

	it "should create record from csv file" do		
		count = operation_count
		upload_file = file("valid_file.csv")
		expect(Operation.count).to eq(count+1)
	end
	
	it "should create record from csv file" do		 
		count = operation_count
		upload_file = file("invalid_company.csv")
		expect(Operation.count).to eq(count)
	end

	context "Date Format" do
		it "should be valid with input date MM/DD/YYYY" do
			upload_file = file("date1.csv")
			operation = Operation.last
			expect(operation.invoice_date).to eq(Date.parse("Fri, 25 Dec 2015"))
		end
		it "should be valid with input date YYYY-MM-DD" do
			upload_file = file("date2.csv")
			operation = Operation.last
			expect(operation.invoice_date).to eq(Date.parse("Fri, 25 Dec 2015"))
		end
		it "should be valid with input date DD-MM-YYYY" do
			upload_file = file("date3.csv")
			operation = Operation.last
			expect(operation.invoice_date).to eq(Date.parse("Fri, 25 Dec 2015"))
		end
	end

end
