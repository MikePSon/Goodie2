//--- Filestyle
//= require bootstrap-filestyle/src/bootstrap-filestyle
//--- Tags input
//= require bootstrap-tagsinput/dist/bootstrap-tagsinput.min
//--- Chosen
//= require chosen_v1.2.0/chosen.jquery.min
//--- Slider ctrl
//= require seiyria-bootstrap-slider/dist/bootstrap-slider.min
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
// --- ColorPicker
//= require mjolnic-bootstrap-colorpicker/dist/js/bootstrap-colorpicker.js
// --- Cropper
//= require cropper/dist/cropper.js
// --- Select2
//= require select2/dist/js/select2


(function(window, document, $, undefined){
  $(function(){
    // DATETIMEPICKER
    // ----------------------------------- 
    if($.fn.datetimepicker) {
      $('#openTimePicker, #closeTimePicker').datetimepicker({
      	format: "HH:mm A",
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


    // FORM
    // ----------------------------------- 
  $(function(){
    if ( ! $.fn.steps ) return;

    var regForm = $("#new_user");
    regForm.validate({
        errorPlacement: function errorPlacement(error, element) { element.before(error); },
        rules: {
            confirm: {
                equalTo: "#password"
            }
        }
    });
    regForm.steps({
        headerTag: "h4",
        bodyTag: "section",
        transitionEffect: "slideLeft",
        stepsOrientation: "vertical",
        onStepChanging: function (event, currentIndex, newIndex)
        {
            regForm.validate().settings.ignore = ":disabled,:hidden";
            return regForm.valid();
        },
        onStepChanged: function (event, currentIndex, newIndex)
        {
            checkFinalBtn(currentIndex);
        },
        onFinishing: function (event, currentIndex)
        {
            regForm.validate().settings.ignore = ":disabled";
            return regForm.valid();
        },
        onFinished: function (event, currentIndex)
        {
            alert("Submitted!");

            // Submit form
            $(this).submit();
        }
    });
    var editForm = $('#edit_user');
    editForm.validate({
        errorPlacement: function errorPlacement(error, element) { element.before(error); },
        rules: {
            confirm: {
                equalTo: "#password"
            }
        }
    });
    editForm.steps({
        headerTag: "h4",
        bodyTag: "section",
        transitionEffect: "slideLeft",
        stepsOrientation: "vertical",
        onStepChanging: function (event, currentIndex, newIndex)
        {
            editForm.validate().settings.ignore = ":disabled,:hidden";
            return editForm.valid();
        },
        onStepChanged: function (event, currentIndex, newIndex)
        {
            checkFinalBtn(currentIndex);
        },
        onFinishing: function (event, currentIndex)
        {
            editForm.validate().settings.ignore = ":disabled";
            return editForm.valid();
        },
        onFinished: function (event, currentIndex)
        {
            alert("Submitted!");

            // Submit form
            $(this).submit();
        }
    });
    function checkFinalBtn(param){
        var submitBtn = $('#submit_button')
        if(param == 3){
            //Hide old Btn
            $('[role="menu"]').children().eq(2).hide();
            //Show submit Btn
            submitBtn.appendTo($('[role="menu"]'));
            submitBtn.css("margin-left", "1em");
            submitBtn.show();
        } else {
            submitBtn.hide();
        }
    };
    $(document).ready(function(){
        $('#submit_button').hide();
        $('[role="menu"]').children().eq(0).children().addClass("btn btn-primary");
        $('[role="menu"]').children().eq(1).children().addClass("btn btn-default");
    });

    
    $(document).ready(function(){
        console.log("HELLO");
        $('#new_user').attr('data-validate', 'parsley');
        $('.parsley-validate').parsley();
        $('#user_email').attr('data-parsley-type', 'email');
        $('#user_phone').inputmask("(999)999-9999");
        $('#user_phone').inputmask("(999)999-9999");
        $('#user_age').attr('data-parsley-min', "0");
        $('#user_age').attr('data-parsley-max', "125");
        $('#user_phone').inputmask("99999");
    });

    if($.fn.datetimepicker) {
		$('#user_office_open, #user_office_close').datetimepicker({
			format: 'LT'
		});
    }

    
});

})(window, document, window.jQuery);