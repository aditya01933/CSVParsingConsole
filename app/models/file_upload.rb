class FileUpload
	require 'roo'
	
	attr_writer :file_path, :file_name

	def initialize(file_path, file_name)
		@file_path = file_path
		@file_name = file_name
	end	
	

	def parse_operation
		spreadsheet = open_csv
		counter = Counter.new(spreadsheet.last_row)
		header = spreadsheet.row(1)   
		(2..spreadsheet.last_row).map do |i|

		  row = Hash[[header, spreadsheet.row(i)].transpose]

		  operation = create_operation_for row
		  if operation.valid?
	  		operation.save!
	  		operation.create_category
	  		counter.parsing_success	  		
	  	else	  		
	  		counter.parsing_failure	  		
	  	end

	  	WebsocketRails[:updates].trigger(:update, counter.row_count)		
		end   	
	end

	def create_operation_for(row)
		operation = Operation.new	
		operation_attr = row.except("company", nil)
		operation.attributes = operation_attr
		company = companies_list.where(name: row["company"].strip).first		 
		if company.nil?
		  operation
		else
		  company.operations.build(operation_attr.merge(company_id: company.id))
		end
	end

	

	def companies_list
		@companies || Company.all		
	end

	def open_csv
		case File.extname(@file_name)
		when ".csv" then Roo::CSV.new(@file_path)
		else raise "Unknown file type: #{@file_name}"
    end
  end



end