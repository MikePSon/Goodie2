//--- Sparklines
//= require angle/custom/jquery.sparkline.min
//--- Flot
//= require Flot/jquery.flot
//= require flot.tooltip/js/jquery.flot.tooltip.min
//= require Flot/jquery.flot.resize
//= require Flot/jquery.flot.pie
//= require Flot/jquery.flot.time
//= require Flot/jquery.flot.categories
//= require flot-spline/js/jquery.flot.spline.min
//--- Classyloader
//= require angle/custom/jquery.classyloader.min
//--- Moment
//= require moment/min/moment-with-locales.min
//--- jQuery Vector map (only dashboard v3)
//= require ika.jvectormap/jquery-jvectormap-1.2.2.min
//= require ika.jvectormap/jquery-jvectormap-world-mill-en
//= require ika.jvectormap/jquery-jvectormap-us-mill-en
//--- Datatables
//= require datatables/media/js/jquery.dataTables.min
//= require datatables-colvis/js/dataTables.colVis
//= require datatables/media/js/dataTables.bootstrap

(function(window, document, $, undefined){

  if ( ! $.fn.dataTable ) return;

  $(function(){


		var dtInstance2 = $('#request_index_table').dataTable({
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