//= require jquery-1.11.3.min
//= require jquery-ui-1.10.3.minimal.min
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require d3.v3
//= require joinable
//= require jquery.sparkline.min
//= require jquery.validate.min
//= require jquery-jvectormap-1.2.2.min
//= require jquery-jvectormap-europe-merc-en
//= require morris.min
//= require neon-api
//= require neon-chat
//= require neon-custom
//= require neon-demo
//= require neon-login
//= require raphael-min
//= require resizeable
//= require rickshaw.min
//= require toastr
//= require TweenMax.min
//= require moment.min
//= require fullcalendar-2/fullcalendar.min
//= require neon-calendar-2
//= require full_calender
//= require daterangepicker
//= require flash
var date_range_picker;
date_range_picker = function() {
    $('.date-range-picker').each(function(){
        $(this).daterangepicker({
            timePicker: true,
            timePickerIncrement: 30,
            alwaysShowCalendars: true
        }, function(start, end, label) {
            $('.start_hidden').val(start.format('YYYY-MM-DD HH:mm'));
            $('.end_hidden').val(end.format('YYYY-MM-DD HH:mm'));
        });
    })
};
$(document).on('turbolinks:load', date_range_picker);
