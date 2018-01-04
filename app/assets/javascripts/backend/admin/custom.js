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
        allowTimes:[
            "0:00", "0:15", "0:30", "0:45", "1:00", "1:15", "1:30", "1:45", "2:00",
            "2:15", "2:30", "2:45", "3:00", "3:15", "3:30", "3:45", "4:00", "4:15", "4:30",
            "4:45", "5:00", "5:15", "5:30", "5:45", "6:00", "6:15", "6:30", "6:45", "7:00",
            "7:15", "7:30", "7:45", "8:00", "8:15", "8:30", "8:45", "9:00", "9:15", "9:30", "9:45",
            "10:00", "10:15", "10:30", "10:45", "11:00", "11:15", "11:30", "11:45", "11:60", "12:00",
            "12:15", "12:30", "12:45", "13:00", "13:15", "13:30", "13:45", "14:00", "14:15", "14:30",
            "14:45", "15:00", "15:15", "15:30", "15:45", "16:00", "16:15", "16:30", "16:45", "17:00",
            "17:15", "17:30", "17:45", "18:00", "18:15", "18:30", "18:45", "19:00", "19:15",
            "19:30", "19:45", "20:00", "20:15", "20:30", "20:45", "21:00", "21:15", "21:30", "21:45", "22:00",
            "22:15", "22:30", "22:45","23:00","23:15","23:30","23:45","24:00"
        ],
        
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
        allowTimes:[
            "0:00", "0:15", "0:30", "0:45", "1:00", "1:15", "1:30", "1:45", "2:00",
            "2:15", "2:30", "2:45", "3:00", "3:15", "3:30", "3:45", "4:00", "4:15", "4:30",
            "4:45", "5:00", "5:15", "5:30", "5:45", "6:00", "6:15", "6:30", "6:45", "7:00",
            "7:15", "7:30", "7:45", "8:00", "8:15", "8:30", "8:45", "9:00", "9:15", "9:30", "9:45",
            "10:00", "10:15", "10:30", "10:45", "11:00", "11:15", "11:30", "11:45", "11:60", "12:00",
            "12:15", "12:30", "12:45", "13:00", "13:15", "13:30", "13:45", "14:00", "14:15", "14:30",
            "14:45", "15:00", "15:15", "15:30", "15:45", "16:00", "16:15", "16:30", "16:45", "17:00",
            "17:15", "17:30", "17:45", "18:00", "18:15", "18:30", "18:45", "19:00", "19:15",
            "19:30", "19:45", "20:00", "20:15", "20:30", "20:45", "21:00", "21:15", "21:30", "21:45", "22:00",
            "22:15", "22:30", "22:45","23:00","23:15","23:30","23:45","24:00"
        ],
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