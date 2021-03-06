class FileUpload
	require 'roo'
	
	attr_writer :file_path, :file_name

	def initialize(file_path, file_name, job_id)
		@file_path = file_path
		@file_name = file_name
		@job_id = job_id
	end	
	

	def parse_operation
		spreadsheet = open_csv
		counter = Counter.new(spreadsheet.last_row-1)
		header = spreadsheet.row(1) 
		sleep 3  
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

	  	WebsocketRails[:updates].trigger(:update, counter.row_count(@job_id))		
		end 

	end

	def create_operation_for(row)
		operation = Operation.new	
		operation_attr = row.except("company", "invoice_date", "operation_date", nil)
		operation.attributes = operation_attr
		date_attributes = format_date(row["invoice_date"], row["operation_date"])
	
		company = companies_list.where(name: row["company"].try(:squish)).first		 
	
		if company.nil?
		  operation
		else
		  company.operations.build(operation_attr.merge(company_id: company.id).merge(date_attributes))
		end
	end

	

	def companies_list
		@companies || Company.all		
	end

	def open_csv		
		Roo::CSV.new(@file_path)		
  end

  def self.csv_file?(name)
  	File.extname(name) == ".csv"
  end

  def format_date(invoice_date, operation_date)
  	date_hash = {invoice_date: invoice_date, operation_date: operation_date}
    date_hash.each do |key, date|	
    	begin    
				new_date = date.to_s.include?('/') ? Date.strptime(date.to_s, '%m/%d/%Y') : Date.parse(date.to_s)	       
      	date_hash[key] = new_date
      rescue ArgumentError
        nil
      end
    end  
    date_hash          
  end


end