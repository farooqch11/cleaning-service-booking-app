function flash(color , msg , icon){
    // Welcome notification
    toastr.options = {
        "closeButton": true,
        "debug": false,
        "newestOnTop": false,
        "progressBar": false,
        "positionClass": "toast-top-right",
        "preventDuplicates": false,
        "onclick": null,
        "showDuration": "300",
        "hideDuration": "1000",
        "timeOut": "5000",
        "extendedTimeOut": "1000",
        "showEasing": "swing",
        "hideEasing": "linear",
        "showMethod": "fadeIn",
        "hideMethod": "fadeOut"
    }
    toastr[color](msg, icon);
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