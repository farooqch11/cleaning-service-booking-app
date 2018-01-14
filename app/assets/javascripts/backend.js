//= require jquery
//= require jquery_ujs
//= require jquery-ui.min
//= require moment.min
//= require moment-timezone
//= require bootstrap
//= require d3.v3
//= require jquery.sparkline.min
//= require jquery.bootstrap.wizard.min
//= require jquery.inputmask.bundle
//= require selectboxit/jquery.selectBoxIt.min
//= require bootstrap-datepicker
//= require bootstrap-colorpicker.min
//= require bootstrap-timepicker.min
//= require typeahead.min

//= require bootstrap-switch.min
//= require jquery.multi-select
//= require jquery-jvectormap-1.2.2.min
//= require jquery-jvectormap-europe-merc-en
//= require morris.min
//= require neon-api
//= require neon-chat



//= require neon-login
//= require raphael-min
//= require resizeable
//= require rickshaw.min
//= require toastr
//= require joinable
//= require TweenMax.min
//= require daterangepicker
//= require fullcalendar
//= require date_range_picker
//= require bootstrap-datetimepicker
//= require flash
//= require recurring_select
//= require datetimepicker
//= require jquery.validate.min

//= require neon-demo
//= require data-confirm-modal
//= require neon-custom
//= require best_in_place
//= require backend/admin/custom
$(document).ready(function() {
    /* Activating Best In Place */
    jQuery(".best_in_place").best_in_place();
});
$("form.validate").each(function(i, el)
{
    var $this = $(el),
        opts = {
            rules: {},
            messages: {},
            errorElement: 'span',
            errorClass: 'validate-has-error',
            highlight: function (element) {
                $(element).closest('.form-group').addClass('validate-has-error');
            },
            unhighlight: function (element) {
                $(element).closest('.form-group').removeClass('validate-has-error');
            },
            errorPlacement: function (error, element)
            {
                if(element.closest('.has-switch').length)
                {
                    error.insertAfter(element.closest('.has-switch'));
                }
                else
                if(element.parent('.checkbox, .radio').length || element.parent('.input-group').length)
                {
                    error.insertAfter(element.parent());
                }
                else
                {
                    error.insertAfter(element);
                }
            }
        },
        $fields = $this.find('[data-validate]');


    $fields.each(function(j, el2)
    {
        var $field = $(el2),
            name = $field.attr('name'),
            validate = attrDefault($field, 'validate', '').toString(),
            _validate = validate.split(',');

        for(var k in _validate)
        {
            var rule = _validate[k],
                params,
                message;

            if(typeof opts['rules'][name] == 'undefined')
            {
                opts['rules'][name] = {};
                opts['messages'][name] = {};
            }

            if($.inArray(rule, ['required', 'url', 'email', 'number', 'date', 'creditcard']) != -1)
            {
                opts['rules'][name][rule] = true;

                message = $field.data('message-' + rule);

                if(message)
                {
                    opts['messages'][name][rule] = message;
                }
            }
            // Parameter Value (#1 parameter)
            else
            if(params = rule.match(/(\w+)\[(.*?)\]/i))
            {
                if($.inArray(params[1], ['min', 'max', 'minlength', 'maxlength', 'equalTo']) != -1)
                {
                    opts['rules'][name][params[1]] = params[2];


                    message = $field.data('message-' + params[1]);

                    if(message)
                    {
                        opts['messages'][name][params[1]] = message;
                    }
                }
            }
        }
    });

    $this.validate(opts);
});
$(document).ready(function(){

    $(document).bind('ajaxError', 'form.ajax', function(event, jqxhr, settings, exception){

        // note: jqxhr.responseJSON undefined, parsing responseText instead
        console.log($.parseJSON(jqxhr.responseText) );
        $(event.data).render_form_errors( $.parseJSON(jqxhr.responseText) );

    });

});

(function($) {

    $.fn.modal_success = function(){
        // close modal
        this.modal('hide');

        // clear form input elements
        // todo/note: handle textarea, select, etc
        this.find('form input[type="text"]').val('');

        // clear error state
        this.clear_previous_errors();
    };

    $.fn.render_form_errors = function(errors){

        $form = this;
        this.clear_previous_errors();
        model = this.data('model');

        // show error messages in input form-group help-block
        $.each(errors, function(field, messages){
            console.log(messages);
            console.log('input[name="' + model + '[' + field + ']"]');
            $input = $('input[name="' + model + '[' + field + ']"]');
            $input.closest('.form-group').addClass('has-error').find('.help-block').html( messages.join(' & ') );
        });

    };

    $.fn.clear_previous_errors = function(){
        $('.form-group.has-error', this).each(function(){
            $('.help-block', $(this)).html('');
            $(this).removeClass('has-error');
        });
    }

}(jQuery));