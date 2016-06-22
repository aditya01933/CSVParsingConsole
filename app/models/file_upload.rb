class FileUpload
	require 'roo'
	include ActiveModel::Model

	attr_accessor :file_path, :file_name

	def parse_operation
		spreadsheet = open_csv
		header = spreadsheet.row(1)   
		(2..spreadsheet.last_row).map do |i|
		  row = Hash[[header, spreadsheet.row(i)].transpose]
		  operation = create_operation_for row
		  if operation.valid?
	  		operation.save!
	  		operation.create_category	  		
	  	else	  		
	  		operation.errors.full_messages
	  	end	
		end   	
	end

	def create_operation_for(row)
		operation = Operation.new	
		company_attr = row.except("company", nil)
		operation.attributes = company_attr
		company_name = row["company"]  
		if company_present_for? company_name
		  operation
		else
		  company.operations.build(company_attr.merge(company_id: company.id))
		end
	end

	
	def company_present_for?(company_name)
		company = comapanies_list.where(name: company_name)
		company.present?
	end

	def comapanies_list
		@companies || Company.all		
	end

	def open_csv
		case File.extname(file_name)
		when ".csv" then Roo::CSV.new(file_path)
		else raise "Unknown file type: #{file_name}"
    end
  end

end