/**
 *	Neon Calendar Script (FullCalendar 2)
 *
 *	Developed by Arlind Nushi - www.laborator.co
 */
var calendar = $('#calendar');
function loadEvents(start, end, timezone, callback) {
    $.ajax({
        url: '/admin/events.json',
        dataType: 'json',
        data: {
            start: moment(start).format("YYYY-MM-DD"),
            end: moment(end).format("YYYY-MM-DD")
        },
        success: function(doc) {
            console.log(doc['events']);
            var events = doc || [];
            callback(events);
        }
    });
}

function removeEvent(event){
    console.log("Remove Event:");
    calendar.fullCalendar('removeEvents', [event.id]);
}
function appendEvent(event){
    console.log("Append Event:");
    calendar.fullCalendar('renderEvent',  event);
}
function updateEvent(event){
    calendar.fullCalendar('removeEvents', [event.id]);
    calendar.fullCalendar('renderEvent',  event);
}
function new_event(start){
    var st = moment(start).format("YYYY-MM-DD HH:mm");
    console.log("Start:" + st);
    $.getScript('/admin/events/new?start='+st, function() {});
}
function edit_event(calEvent){
    $.get(calEvent.edit_url , function () {
        //$('#event_date_range').val(moment(calEvent.start).format("MM/DD/YYYY HH:mm") + ' - ' + moment(calEvent.end).format("MM/DD/YYYY HH:mm"));
        //date_range_picker();
        //$('.start_hidden').val(moment(calEvent.start).format('YYYY-MM-DD HH:mm'));
        //$('.end_hidden').val(moment(calEvent.end).format('YYYY-MM-DD HH:mm'));
    });
}

function update_event(event , revertFunc){
    //dataConfirmModal.confirm({
    //    backdrop: 'static',
    //    keyboard: false,
    //    title: 'Change Job date?',
    //    text: 'Change the date and time to only this job, or this and all future jobs?',
    //    commit: 'Only This Job',
    //    cancel: 'Cancel',
    //    zIindex: 10099,
    //
    //    onConfirm: function() {
    //            var event_data = {
    //                event: {
    //                    id: event.id,
    //                    start: moment(event.start).format("DD-MM-YYYY HH:mm"),
    //                    end: moment(event.end).format("DD-MM-YYYY HH:mm")
    //                }
    //            };
    //        $.post(event.update_url , event_data).
    //            success(function(data) {
    //                $('#joke').html(data.value.joke);
    //            }).
    //            error(function() {
    //                revertFunc();
    //            })
    //    },
    //    onCancel: function() {
    //        revertFunc();
    //    }
    //});
    //if (!confirm("Do you really want to update this event?")) {
    //    revertFunc();
    //}else {

        var event_data = {
            event: {
                id: event.id,
                start: moment(event.start).format("DD-MM-YYYY HH:mm"),
                end: moment(event.end).format("DD-MM-YYYY HH:mm")
            }
        };
        $.ajax({
            url: event.update_url,
            dataType: 'json',
            data: event_data,
            type: 'PATCH',
            success: function(doc) {
                console.log(JSON.stringify(doc , null ,2 ));
                console.log(doc['success']);
                if(doc.success){
                    $("#modal-4").modal('hide');
                    flash_success(doc.message);
                    updateEvent(doc.data);
                }else{
                    revertFunc();
                    $.each(doc.errors, function (i, error) {
                        flash_error(error);
                    });
                }
            },
            error: function() {
                    revertFunc();
                }
        });
    //}
}
var neonCalendar2 = neonCalendar2 || {};

;
(function ($, window, undefined) {
    "use strict";

    $(document).ready(function () {
        neonCalendar2.$container = $(".calendar-env");

        $.extend(neonCalendar2, {
            isPresent: neonCalendar2.$container.length > 0
        });

        // Mail Container Height fit with the document
        if (neonCalendar2.isPresent) {
            neonCalendar2.$sidebar = neonCalendar2.$container.find('.calendar-sidebar');
            neonCalendar2.$body = neonCalendar2.$container.find('.calendar-body');


            // Checkboxes
            var $cb = neonCalendar2.$body.find('table thead input[type="checkbox"], table tfoot input[type="checkbox"]');

            $cb.on('click', function () {
                $cb.attr('checked', this.checked).trigger('change');

                calendar_toggle_checkbox_status(this.checked);
            });

            // Highlight
            neonCalendar2.$body.find('table tbody input[+="checkbox"]').on('change', function () {
                $(this).closest('tr')[this.checked ? 'addClass' : 'removeClass']('highlight');
            });


            // Setup Calendar
            if ($.isFunction($.fn.fullCalendar)) {


                calendar.fullCalendar({
                    buttonText: {
                        today: 'Today',
                        month: 'Month',
                        week: 'Week',
                        day: 'Day',
                        list: 'List'
                    },
                    header: {
                        left: 'title',
                        right: 'month,agendaWeek,agendaDay,listWeek today prev,next'
                },

                    //defaultView: 'basicWeek',
                    default: 'h(:mm)a',
                    firstDay: 1,
                    height: 600,
                    droppable: true,
                    selectable: true,
                    selectHelper: true,
                    editable: true,
                    resizable: true,
                    eventLimit: true,
                    slotLabelFormat:"HH:mm",
                    events: loadEvents,
                    eventRender: function (event, element) {
                        if (!event.description == "") {
                            element.find('.fc-title').append("<br/><span class='ultra-light'>" + event.description +
                                "</span>");
                        }
                    },
                    eventResize: function (event, dayDelta, minuteDelta, revertFunc) {
                        console.log("Event Resize: ");
                        update_event(event , revertFunc);
                    },
                    eventDrop: function(event, delta, revertFunc) {
                        console.log("Event Drop: " + event.end);
                        $("#modal-4").modal('show');
                        $("#cancelEvent").click(function(){
                            revertFunc();
                            $("#modal-4").modal('hide');
                        });
                        $('#updateThisAndFutureChildern').click(function (){
                            console.log("Update this Event and future only.");
                            var event_data = {
                                event: {
                                    id: event.id,
                                    start: moment(event.start).format("DD-MM-YYYY HH:mm"),
                                    end: moment(event.end).format("DD-MM-YYYY HH:mm")
                                }
                            };
                            $.ajax({
                                url: " /admin/events/"+ event.id +"/update_all_future_events",
                                dataType: 'json',
                                data: event_data,
                                type: 'POST',
                                success: function(doc) {
                                    console.log(JSON.stringify(doc , null ,2 ));
                                    console.log(doc['success']);
                                    if(doc.success){
                                        $("#modal-4").modal('hide');
                                        flash_success(doc.message);
                                        updateEvent(doc.data);
                                    }else{
                                        revertFunc();
                                        $.each(doc.errors, function (i, error) {
                                            flash_error(error);
                                        });
                                    }
                                },
                                error: function() {
                                    revertFunc();
                                }
                            });
                        });

                        $('#updateOnlyThisJob').click(function (){
                            console.log("Update this Event only.");
                            update_event(event , revertFunc);
                        });
                    },

                    eventClick: function (calEvent, jsEvent, view) {
                        console.log("Event Click: ");
                        var eventEl = $(this);

                        // Add and remove event border class
                        if (!$(this).hasClass('event-clicked')) {
                            $('.fc-event').removeClass('event-clicked');

                            $(this).addClass('event-clicked');
                        }

                        // Add popover
                        $('body').append(

                            '<button type="button" class="close">'+'<span aria-hidden="true">'+'×'+'</span>'+'<span class="sr-only">'+'Close'+'</span></button>'+
                            '<div class="fc-popover click">' +
                            '<div class="fc-header">' +
                            '<center>' +calEvent.customer_name+
                            '</center>' +
                            '<button type="button" class="cl"><i class="entypo-cancel"></i></button>' +
                            '</div>' +

                            '<div class="fc-body">' +
                            '<p class="color-blue-grey"> Time:  ' + '<strong>' +  moment(calEvent.start).format('dddd, D YYYY, hh:mma')  + '</strong>' + '</p>' +
                            '<p class="color-blue-grey"> Customer:  ' + '<strong>' + calEvent.customer_name + '</strong>' + '</p>' +
                            '<p class="color-blue-grey"> Employee:  ' + '<strong>' + calEvent.employee_name + '</strong>' + '</p>' +
                            '&nbsp;'+
                            '<a href= "#" class="fc-event-action-edit btn btn-primary event-edit">Edit event</a>'+
                            '<a href= "#" class="fc-event-action-delete btn btn-primary">Delete event</a>'

                        );

                        $('.fc-event-action-delete').click(function () {
                            $.ajax({
                                url: "/admin/events/"+calEvent.id,
                                type: "DELETE",
                                data: { _method:'DELETE' }
                            });
                        });

                        // Datepicker init
                        $('.fc-popover.click .datetimepicker').datetimepicker({
                            widgetPositioning: {
                                horizontal: 'right'
                            }
                        });

                        $('.fc-popover.click .datetimepicker-2').datetimepicker({
                            widgetPositioning: {
                                horizontal: 'right'
                            },
                            format: 'LT',
                            debug: true
                        });


                            // Position popover
                            function posPopover() {
                                $('.fc-popover.click').css({
                                    left: eventEl.offset().left + eventEl.outerWidth() / 2,
                                    top: eventEl.offset().top + eventEl.outerHeight()
                                });
                            }

                            posPopover();

                            $('.fc-scroller, .calendar-page-content, body').scroll(function () {
                                posPopover();
                            });

                            $(window).resize(function () {
                                posPopover();
                            });


                            // Remove old popover
                            if ($('.fc-popover.click').length > 1) {
                                for (var i = 0; i < ($('.fc-popover.click').length - 1); i++) {
                                    $('.fc-popover.click').eq(i).remove();
                                }
                            }

                            // Close buttons
                            $('.fc-popover.click .cl, .fc-popover.click .remove-popover').click(function () {
                                $('.fc-popover.click').remove();
                                $('.fc-event').removeClass('event-clicked');
                            });

                            // Actions link
                            $('.fc-event-action-edit').click(function (e) {
                                e.preventDefault();

                                $('.fc-popover.click .main-screen').hide();
                                edit_event(calEvent);

                            });

                            $('.fc-event-action-remove').click(function (e) {
                                e.preventDefault();

                                $('.fc-popover.click .main-screen').hide();
                                $('.fc-popover.click .remove-confirm').show();
                            });
                        },

                    select: function (start, end) {

                        new_event(start);
                        calendar.fullCalendar('unselect');
                    },
                    drop: function(date, allDay) {
                        console.log("Event Drop Trigger.");
                        new_event();
                        //$this.remove();
                    }
                });

                $("#draggable_events").find("li a").draggable({
                    zIndex: 999,
                    revert: true,
                    revertDuration: 0
                }).on('click', function () {
                    return false;
                });
            } else {
                alert("Please include full-calendar script!");
            }


            $("body").on('submit', '#add_event_form', function(ev)
            {
                ev.preventDefault();

                var text = $("#add_event_form input");

                if(text.val().length == 0)
                    return false;

                var classes = ['', 'color-green', 'color-blue', 'color-orange', 'color-primary', ''],
                    _class = classes[ Math.floor(classes.length * Math.random()) ],
                    $event = $('<li><a href="#"></a></li>');

                $event.find('a').text(text.val()).addClass(_class).attr('data-event-class', _class);

                $event.appendTo($("#draggable_events"));

                $("#draggable_events li a").draggable({
                    zIndex: 999,
                    revert: true,
                    revertDuration: 0
                }).on('click', function()
                {
                    return false;
                });

                fit_calendar_container_height();

                $event.hide().slideDown('fast');
                text.val('');

                return false;
            });
        }
    });

})(jQuery, window);


function fit_calendar_container_height() {
    if (neonCalendar2.isPresent) {
        if (neonCalendar2.$sidebar.height() < neonCalendar2.$body.height()) {
            neonCalendar2.$sidebar.height(neonCalendar2.$body.height());
        }
        else {
            var old_height = neonCalendar2.$sidebar.height();

            neonCalendar2.$sidebar.height('');

            if (neonCalendar2.$sidebar.height() < neonCalendar2.$body.height()) {
                neonCalendar2.$sidebar.height(old_height);
            }
        }
    }
}

function reset_calendar_container_height() {
    if (neonCalendar2.isPresent) {
        neonCalendar2.$sidebar.height('auto');
    }
}

function calendar_toggle_checkbox_status(checked) {
    neonCalendar2.$body.find('table tbody input[type="checkbox"]' + (checked ? '' : ':checked')).attr('checked', !checked).click();
}