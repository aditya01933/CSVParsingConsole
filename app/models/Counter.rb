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
		def row_count
			{	total_rows: @total_rows,
				success: @success,
				failed_row: @failure
			}.to_json
		end
end