/**
 *	Neon Calendar Script (FullCalendar 2)
 *
 *	Developed by Arlind Nushi - www.laborator.co
 */

var neonCalendar2 = neonCalendar2 || {};

;(function($, window, undefined)
{
    "use strict";

    $(document).ready(function()
    {
        neonCalendar2.$container = $(".calendar-env");

        $.extend(neonCalendar2, {
            isPresent: neonCalendar2.$container.length > 0
        });

        // Mail Container Height fit with the document
        if(neonCalendar2.isPresent)
        {
            neonCalendar2.$sidebar = neonCalendar2.$container.find('.calendar-sidebar');
            neonCalendar2.$body = neonCalendar2.$container.find('.calendar-body');


            // Checkboxes
            var $cb = neonCalendar2.$body.find('table thead input[type="checkbox"], table tfoot input[type="checkbox"]');

            $cb.on('click', function()
            {
                $cb.attr('checked', this.checked).trigger('change');

                calendar_toggle_checkbox_status(this.checked);
            });

            // Highlight
            neonCalendar2.$body.find('table tbody input[type="checkbox"]').on('change', function()
            {
                $(this).closest('tr')[this.checked ? 'addClass' : 'removeClass']('highlight');
            });


            // Setup Calendar
            if($.isFunction($.fn.fullCalendar))
            {
                var calendar = $('#calendar');

                calendar.fullCalendar({
                    header: {
                        left: 'title',
                        right: 'month,agendaWeek,agendaDay today prev,next'
                    },

                    //defaultView: 'basicWeek',
                    selectable: true,
                    selectHelper: true,
                    editable: true,
                    eventLimit: true,
                    events: '/employee/events.json',

                    // eventClick: function(event, jsEvent, view) {
                    //     $.getScript(event.edit_url, function() {});
                    // },
                    // select: function(start, end) {
                    //     $.getScript('/admin/events/new', function() {
                    //         $('#event_date_range').val(moment(start).format("MM/DD/YYYY HH:mm") + ' - ' + moment(end).format("MM/DD/YYYY HH:mm"))
                    //         date_range_picker();
                    //         $('.start_hidden').val(moment(start).format('YYYY-MM-DD HH:mm'));
                    //         $('.end_hidden').val(moment(end).format('YYYY-MM-DD HH:mm'));
                    //     });
                    //
                    //     calendar.fullCalendar('unselect');
                    // },
                    eventClick: function (calEvent, jsEvent, view) {
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
                            '<center>' +calEvent.title+
                            '</center>' +
                            '<button type="button" class="cl"><i class="entypo-cancel"></i></button>' +
                            '</div>' +

                            '<div class="fc-body">' +
                            '<p class="color-blue-grey"> Time:  ' + '<strong>' +  moment(calEvent.start).format('dddd, D YYYY, hh:mma')  + '</strong>' + '</p>' +
                            '<p class="color-blue-grey"> Customer:  ' + '<strong>' + calEvent.customer_name + '</strong>' + '</p>' +
                            '<p class="color-blue-grey"> Employee:  ' + '<strong>' + calEvent.employee_name + '</strong>' + '</p>' +
                            '&nbsp;'

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
                    firstDay: 1,
                    height: 600,
                    droppable: true,
                    drop: function(date, allDay) {

                        var $this = $(this),
                            eventObject = {
                                title: $this.text(),
                                start: date,
                                allDay: allDay,
                                className: $this.data('event-class')
                            };

                        calendar.fullCalendar('renderEvent', eventObject, true);

                        $this.remove();
                    }
                });

                // $("#draggable_events li a").draggable({
                //     zIndex: 999,
                //     revert: true,
                //     revertDuration: 0
                // }).on('click', function()
                // {
                //     return false;
                // });
            }
            else
            {
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


function fit_calendar_container_height()
{
    if(neonCalendar2.isPresent)
    {
        if(neonCalendar2.$sidebar.height() < neonCalendar2.$body.height())
        {
            neonCalendar2.$sidebar.height( neonCalendar2.$body.height() );
        }
        else
        {
            var old_height = neonCalendar2.$sidebar.height();

            neonCalendar2.$sidebar.height('');

            if(neonCalendar2.$sidebar.height() < neonCalendar2.$body.height())
            {
                neonCalendar2.$sidebar.height(old_height);
            }
        }
    }
}

function reset_calendar_container_height()
{
    if(neonCalendar2.isPresent)
    {
        neonCalendar2.$sidebar.height('auto');
    }
}

function calendar_toggle_checkbox_status(checked)
{
    neonCalendar2.$body.find('table tbody input[type="checkbox"]' + (checked ? '' : ':checked')).attr('checked',  ! checked).click();
}