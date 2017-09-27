var g_start, g_end;
var zone = "Europe/London";

function setDuration()
{
    var d1        = new Date($('#event_start').val());
    var d2        = new Date($('#event_end').val());
    var diffMs = (d2 - d1); // milliseconds between now & Christmas
    var diffDays = Math.floor(diffMs / 86400000); // days
    var diffHrs = Math.floor((diffMs % 86400000) / 3600000); // hours
    var diffMins = Math.round(((diffMs % 86400000) % 3600000) / 60000); // minutes

    if(diffDays > 0)
    {
        var value           =  $('#event_job_duration').val(diffDays);
        var duration_type   =  $('#event_job_duration_type').val('days');
    }else if(diffHrs > 0){
        var value           =  $('#event_job_duration').val(diffHrs);
        var duration_type   =  $('#event_job_duration_type').val('hours');
    }else{
        var value           =  $('#event_job_duration').val(diffMins);
        var duration_type   =  $('#event_job_duration_type').val('minutes');
    }
}
function setDateTimepicker(strat_date , end_date){
    console.log(strat_date);
    jQuery('#event_start').datetimepicker({
        value: strat_date,
        validateOnBlur: true,
        onChangeDateTime:function(dp,$input){
            setEventEndDateTime();
            console.log($input.val())
        },
        onShow:function( ct ){
            this.setOptions({
                maxDate: jQuery('#event_end').val() ? jQuery('#event_end').val() : false
            })
        }
    });
    jQuery('#event_end').datetimepicker({
        validateOnBlur: true,
        value: end_date,
        onShow:function( ct ){
            this.setOptions({
                minDate: jQuery('#event_start').val() ? jQuery('#event_start').val() : false
            })
        },
        onChangeDateTime:function(dp,$input){
            setDuration();
            console.log($input.val())
        }
    });
    jQuery('#event_recurring_end_at').datetimepicker({
        onShow:function( ct ){
            this.setOptions({
                minDate: jQuery('#event_end').val() ? jQuery('#event_end').val() : false
            })
        }
    });
}
function addZero(temp)
{
    return (temp > 9 ? temp : '0'+temp);
}

function setEventEndDateTime(){
    var value           =  $('#event_job_duration').val();
    var duration_type   =  $('#event_job_duration_type').val();
    var d2        = moment($('#event_start').val());
    $('#event_end').val(d2.add(value,duration_type).format('YYYY/MM/DD HH:mm'));
}
function bootstrapWizard()
{
    $(".form-wizard").each(function(i, el)
    {
        var $this = $(el),
            $progress = $this.find(".steps-progress div"),
            _index = $this.find('> ul > li.active').index();

        // Validation
        var checkFormWizardValidaion = function(tab, navigation, index)
        {
            if($this.hasClass('validate'))
            {
                var $valid = $this.valid();

                if( ! $valid)
                {
                    $this.data('validator').focusInvalid();
                    return false;
                }
            }

            return true;
        };


        $this.bootstrapWizard({
            tabClass: "",
            onTabShow: function($tab, $navigation, index)
            {

                setCurrentProgressTab($this, $navigation, $tab, $progress, index);
            },

            onNext: checkFormWizardValidaion,
            onTabClick: checkFormWizardValidaion
        });

        $this.data('bootstrapWizard').show( _index );

        /*$(window).on('neon.resize', function()
         {
         $this.data('bootstrapWizard').show( _index );
         });*/
    });
}