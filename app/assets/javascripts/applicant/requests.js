//--- Datatables
//= require datatables/media/js/jquery.dataTables.min
//= require datatables-colvis/js/dataTables.colVis
//= require datatables/media/js/dataTables.bootstrap

(function(window, document, $, undefined){

  if ( ! $.fn.dataTable ) return;

  $(function(){


		var dtInstance2 = $('#my_cycle_table').dataTable({
    	    'paging':   true,  // Table pagination
    	    'ordering': true,  // Column ordering 
    	    'info':     true,  // Bottom left status text
    	    // Text translation options
    	    // Note the required keywords between underscores (e.g _MENU_)
    	    oLanguage: {
    	        sSearch:      'Search all columns:',
    	        sLengthMenu:  '_MENU_ records per page',
    	        info:         'Showing page _PAGE_ of _PAGES_',
    	        zeroRecords:  'Nothing found - sorry',
    	        infoEmpty:    'No records available',
    	        infoFiltered: '(filtered from _MAX_ total records)'
    	    }
    	});
    	var inputSearchClass = 'datatable_input_col_search';
    	var columnInputs = $('tfoot .'+inputSearchClass);
	
    	// On input keyup trigger filtering
    	columnInputs
    	  .keyup(function () {
    	      dtInstance2.fnFilter(this.value, columnInputs.index(this));
    	  });
	});

})(window, document, window.jQuery);