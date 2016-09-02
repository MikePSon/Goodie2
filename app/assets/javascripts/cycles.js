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

// --- Bullshti Morris Chart

var donutdata = [
  {label: "Created", value: 12},
  {label: "Submitted",value: 30},
  {label: "Incomplete", value: 45},
  {label: "Under Review", value: 5},
  {label: "Closed", value: 2},
];
// ----------------------------------- 
if( document.getElementById('status-donut') )
  new Morris.Donut({
    element: 'status-donut',
    data: donutdata,
    colors: [ '#5d9cec', '#27c24c', '#f05050', '#ff902b', '#000' ],
    resize: true
  });

