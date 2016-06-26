function startSocket(){
  $('#prog').progressbar({ value: 0});

	var dispatcher = new WebSocketRails('localhost:3000/websocket',false);

	channel = dispatcher.subscribe('updates');
	
	channel.bind('update', function(data) {
	 	var job_id = $('#job_id').text(); 
	  var jsonObject = jQuery.parseJSON(data);	
	  if(job_id == jsonObject.job_id){
		  parsingProgress(jsonObject);
		  $('#total_rows').text(jsonObject.total_rows);
		  $('#successful_rows').text(jsonObject.success);
		  $('#failed_rows').text(jsonObject.failed_row);
		}
	});

	function parsingProgress(data) {
	    	
	        var pct = ((data.failed_row + data.success) / data.total_rows) * 100;
	       	 
	        $('#prog')
	            .progressbar('option', 'value', pct)
	            .children('.ui-progressbar-value')
	            .html(pct.toPrecision(3) + '%')
	            .css('display', 'block');

	    
	}

}
