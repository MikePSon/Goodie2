// Place all the behaviors and hooks related to the matching controller here.
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
//--- Wysiwyg
//= require bootstrap-wysiwyg/bootstrap-wysiwyg
//= require bootstrap-wysiwyg/external/jquery.hotkeys
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
// --- Select2
//= require select2/dist/js/select2
//--- Sparklines
//= require sparkline/index
//--- Morris
//= require raphael/raphael
//= require morris.js/morris
//--- Datatables
//= require datatables/media/js/jquery.dataTables.min
//= require datatables-colvis/js/dataTables.colVis
//= require datatables/media/js/dataTables.bootstrap


(function(window, document, $, undefined){

  if ( ! $.fn.dataTable ) return;

  $(function(){


    var dtInstance2 = $('#to_be_reviewed_requests').dataTable({
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

// --- Datepicker styles
(function(window, document, $, undefined){

  $(function(){

    // DATETIMEPICKER
    // ----------------------------------- 

    if($.fn.datetimepicker) {

      $('#openTimePicker, #closeTimePicker').datetimepicker({
      	timeFormat: "DD/MM/YYYY HH:mm A",
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