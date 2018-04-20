/* ============================================================
 * Calendar
 * This is a Demo App that was created using Pages Calendar Plugin
 * We have demonstrated a few function that are useful in creating
 * a custom calendar. Please refer docs for more information
 * ============================================================ */

function startCalendar($) {
    'use strict';
    $(document).ready(function() {
        var selectedEvent;
        var eventList = [];
        $.each($('.page-content-wrapper').data('events'), function( index, value ) {
          eventList.push(JSON.parse(value));
});
        console.log(eventList);
        $('#myCalendar').pagescalendar({
            //Loading Dummy EVENTS for demo Purposes, you can feed the events attribute from
            //Web Service
            ui: {
                dateHeader: {
                    format: 'dddd, MMMM D, YYYY'
                }
            },
            events: eventList,
            view:"week",
            onViewRenderComplete: function() {
                //You can Do a Simple AJAX here and update
            },
            onEventClick: function(event) {
                //Open Pages Custom Quick View
                // $('#patientForm').modal('toggle');
                console.log(event);
                // $.ajax({type: "Get",url: "/appointments/" + event.appid + "/edit"});
                $.getJSON("/appointments/" + event.appid + "/edit", function(data) {

                  console.log(data);
                  var patientId = data;
                  if (!patientId) {
                        $('.calendar.week .options').find('.alert.alert-info').remove();
                        $('.calendar.week .options').prepend('<div class="alert alert-info" style="margin-top: 61px;">This event was synced from your Google Calendar. Please view that calendar to see this event\'s details. Thanks!</div>');
                  }else{
                    window.location = 'users/' + patientId;
                  }

                });



                // if (!$('#calendar-event').hasClass('open'))
                //     $('#calendar-event').addClass('open');
                //     $('.scroll-content').css("display", "inline");

                selectedEvent = event;
                setEventDetailsToForm(selectedEvent);
            },
            onEventDragComplete: function(event) {
                selectedEvent = event;
                setEventDetailsToForm(selectedEvent);

            },
            onEventResizeComplete: function(event) {
                selectedEvent = event;
                setEventDetailsToForm(selectedEvent);
            },
            onTimeSlotDblClick: function(timeSlot) {
                $('#calendar-event').removeClass('open');
                //Adding a new Event on Slot Double Click
                var newEvent = {
                    "title": 'my new event',
                    class: 'bg-success-lighter',
                    start: timeSlot.date,
                    end: moment(timeSlot.date).add(1, 'hour').format(),
                    allDay: false,
                    other: {
                        //You can have your custom list of attributes here
                        note: 'test'
                    }
                };
                selectedEvent = newEvent;
                $('#myCalendar').pagescalendar('addEvent', newEvent);
                setEventDetailsToForm(selectedEvent);
            }
        });

        // Some Other Public Methods That can be Use are below \
        //console.log($('body').pagescalendar('getEvents'))
        //get the value of a property
        //console.log($('body').pagescalendar('getDate','MMMM'));

        function setEventDetailsToForm(event) {
            $('#eventIndex').val();
            $('#txtEventName').val();
            $('#txtEventCode').val();
            $('#txtEventLocation').val();
            //Show Event date
            $('#event-date').html(moment(event.start).format('MMM, D dddd'));

            $('#lblfromTime').html(moment(event.start).format('h:mm A'));
            $('#lbltoTime').html(moment(event.end).format('H:mm A'));

            //Load Event Data To Text Field
            $('#eventIndex').val(event.index);

            $('#txtEventName').val(event.title);
            // $('#txtEventCode').val(event.other.code);
            // $('#txtEventLocation').val(event.other.location);
        }

        $('#eventSave').on('click', function() {
            selectedEvent.title = $('#txtEventName').val();
            selectedEvent.other.code = $('#txtEventCode').val();
            selectedEvent.other.location = $('#txtEventLocation').val();

            $('#myCalendar').pagescalendar('updateEvent',selectedEvent);

            $('#calendar-event').removeClass('open');
        });

        $('#eventDelete').on('click', function() {
            $('#myCalendar').pagescalendar('removeEvent', $('#eventIndex').val());
            $('#calendar-event').removeClass('open');
        });
    });

}
