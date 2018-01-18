function flash(color , msg , icon){
    // Welcome notification

    setTimeout(function () {
        var opts = {
            "closeButton": true,
            "debug": false,
            //"positionClass": rtl() || public_vars.$pageContainer.hasClass('right-sidebar') ? "toast-top-left" : "toast-top-right",
            "positionClass": "toast-top-right",
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

        toastr[color](msg, opts);
    }, 1000);
}
function flash_error(msg)
{
    $error    = 'error';
    flash($error,msg , 'Error');
}
function flash_success(msg)
{
    var $success  = 'success';
    flash($success,msg , 'Success');
}
function flash_info(msg)
{
    var $info     = 'info';
    flash($info,msg , 'Info');
}
function flash_notice(msg)
{
    var $notice   = 'warning';
    flash($notice,msg , 'Notice');
}
function flash_alert(msg) {
    var $alert = 'warning';
    flash($alert, msg, 'Warning');
}