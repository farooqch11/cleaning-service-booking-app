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
//= require  neon-api
//= require  neon-chat
//= require  neon-custom
//= require  neon-demo
//= require  neon-login
//= require  raphael-min
//= require  resizeable
//= require  rickshaw.min
//= require  toastr
//= require TweenMax.min
//= require moment.min
//= require fullcalendar-2/fullcalendar.min
//= require neon-calendar-2


jQuery(document).ready(function($) {
    setTimeout(function () {
        var opts = {
            "closeButton": true,
            "debug": false,
            "positionClass": rtl() || public_vars.$pageContainer.hasClass('right-sidebar') ? "toast-top-left" : "toast-top-right",
            "toastClass": "black",
            "onclick": null,
            "showDuration": "300",
            "hideDuration": "1000",
            "timeOut": "5000",
            "extendedTimeOut": "1000",
            "showEasing": "swing",
            "hideEasing": "linear",
            "showMethod": "fadeIn",
            "hideMethod": "fadeOut"
        };

        toastr.success("Welcome to Your Dashboard", opts);
    }, 3000);
});
