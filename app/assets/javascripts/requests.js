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


//--- jQuery UI
//= require jquery-ui/ui/core
//= require jquery-ui/ui/widget
//= require jquery-ui/ui/mouse
//= require jquery-ui/ui/draggable
//= require jquery-ui/ui/droppable
//= require jquery-ui/ui/sortable
//= require jqueryui-touch-punch/jquery.ui.touch-punch.min
//--- Skycons
//= require skycons/skycons
//--- Sortable
//= require html.sortable/dist/html.sortable.js
//--- Nestable
//= require nestable/jquery.nestable.js
// --- Bootstrap Tour
//= require bootstrap-tour/build/js/bootstrap-tour-standalone.js
// --- Sweet Alert
//= require sweetalert/dist/sweetalert.min.js

//--- Filestyle
//= require bootstrap-filestyle/src/bootstrap-filestyle
//--- Tags input
//= require bootstrap-tagsinput/dist/bootstrap-tagsinput.min
//--- Chosen
//= require chosen_v1.2.0/chosen.jquery.min
//--- Slider ctrl
//= require seiyria-bootstrap-slider/dist/bootstrap-slider.min
//--- Input Mask
//= require jquery.inputmask/dist/jquery.inputmask.bundle
//--- Parsley
//= require parsleyjs/dist/parsley.min
//--- Moment
//= require moment/min/moment-with-locales.min
//--- DatetimePicker
//= require eonasdan-bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min
//--- Upload
//= require jquery-ui/ui/widget
//= require blueimp-tmpl/js/tmpl
//= require blueimp-load-image/js/load-image.all.min
//= require blueimp-canvas-to-blob/js/canvas-to-blob
//= require blueimp-file-upload/js/jquery.iframe-transport
//= require blueimp-file-upload/js/jquery.fileupload
//= require blueimp-file-upload/js/jquery.fileupload-process
//= require blueimp-file-upload/js/jquery.fileupload-image
//= require blueimp-file-upload/js/jquery.fileupload-audio
//= require blueimp-file-upload/js/jquery.fileupload-video
//= require blueimp-file-upload/js/jquery.fileupload-validate
//= require blueimp-file-upload/js/jquery.fileupload-ui
//--- Validate
//= require jquery-validation/dist/jquery.validate
//--- Steps
//= require jquery.steps/build/jquery.steps

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

  $(function(){

    // DATETIMEPICKER
    // ----------------------------------- 

    if($.fn.datetimepicker) {

      $('#project_start_picker, #project_end_picker').datetimepicker({
        //FIXME: This is a bug that needs fixin, something with DateTime formatting
        format: "DD/MM/YYYY",
        icons: {
            time: 'fa fa-clock-o',
            date: 'fa fa-calendar',
            up: 'fa fa-chevron-up',
            down: 'fa fa-chevron-down',
            previous: 'fa fa-chevron-left',
            next: 'fa fa-chevron-right',
            today: 'fa fa-crosshairs',
            clear: 'fa fa-trash'
          }
      });
      
    }

  });

})(window, document, window.jQuery);