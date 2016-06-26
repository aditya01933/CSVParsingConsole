class Counter
		attr_accessor :total_rows, :success, :failure

		def initialize(total_rows)
			@total_rows = total_rows
		end
	  def parsing_success
			@success ||= 0
			@success += 1
		end
		def parsing_failure
			@failure ||= 0
			@failure += 1
		end
		def row_count(job_id)
			{	total_rows: @total_rows || 0,
				success: @success || 0,
				failed_row: @failure || 0,
				job_id: job_id
			}.to_json
		end
end