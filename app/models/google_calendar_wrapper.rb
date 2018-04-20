class GoogleCalendarWrapper
    include AppointmentsHelper
    def initialize(user)
      configure_client(user)
    end

    def get_calendar_list
      response = @client.execute(api_method: @service.calendar_list.list)
      calendars = JSON.parse(response.body)
      calendar_list = calendars["items"].map {|cal| [cal["id"].downcase,cal["summary"]]}
      calendar_list
    end

    def send_event_to_google user, appointment
      bt = appointment.start
      et = appointment.end
      d = appointment.date
      goog_start = DateTime.new(d.year, d.month, d.day, bt.hour, bt.min, bt.sec, bt.zone).to_s
      goog_end = DateTime.new(d.year, d.month, d.day, et.hour, et.min, et.sec, et.zone).to_s
      event = {
          summary: "PatientNotes Appointment",
          start: {dateTime: goog_start},
          end: {dateTime: goog_end},
          description: get_title(appointment),
        }
      response = @client.execute(:api_method => @service.events.insert,
      :parameters => {'calendarId' => user.google_calendar_id,
      'sendNotifications' => true},
      :body => JSON.dump(event),
      :headers => {'Content-Type' => 'application/json'})
      body = JSON.parse(response.body)
      appointment.doctor_goog_event_id = body["id"]
      appointment.status = :synced
      appointment.save
      response.success?
    end

    def send_calendar_events_to_google user
      user.appointments.each do |a|
        if a.status == "confirmed"
          send_event_to_google user, a
        end
      end
    end
    def get_calendar_events user, next_sync_token=nil, next_page_token=nil

      if next_sync_token && next_page_token
        events = @client.execute(api_method: @service.events.list,
        parameters: {calendarId: user.google_calendar_id, syncToken: next_sync_token, pageToken: next_page_token})
      elsif next_sync_token && !next_page_token
        events = @client.execute(api_method: @service.events.list,
        parameters: {calendarId: user.google_calendar_id, syncToken: next_sync_token})
      elsif !next_sync_token && next_page_token
        events = @client.execute(api_method: @service.events.list,
        parameters: {calendarId: user.google_calendar_id, pageToken: next_page_token})
      else
        events = @client.execute(api_method: @service.events.list,
        parameters: {calendarId: user.google_calendar_id, timeMin: DateTime.now.to_s, timeMax: (DateTime.now + 3.months).to_s})
      end

      events_json = JSON.parse(events.body) 

      unless events_json["nextSyncToken"].empty?
        user.update_attribute(:next_goog_cal_sync_token, events_json["nextSyncToken"])
        unless events_json["items"].empty?
          events_json["items"].each do |event|
            Appointment.update_or_create_goog_event user, event["id"], event["start"]["dateTime"], event["end"]["dateTime"], event["status"], event["summary"]
          end
        end
      else
        unless events_json["items"].empty?
          events_json["items"].each do |event|
            Appointment.update_or_create_goog_event user, event["id"], event["start"]["dateTime"], event["end"]["dateTime"], event["status"], event["summary"]
          end
        end
        if user.next_goog_cal_sync_token
          get_calendar_events user, user.next_goog_cal_sync_token, events_json["pageToken"]
        else
          get_calendar_events user, nil, events_json["pageToken"]
        end
      end
    end




    def configure_client(user)
      @client = Google::APIClient.new
      @client.authorization.access_token = user.oauth_token
      @client.authorization.refresh_token = user.refresh_token
      @client.authorization.client_id = ENV['GOOGLE_OAUTH_CLIENT']
      @client.authorization.client_secret = ENV['GOOGLE_OAUTH_SECRET']
      @client.authorization.refresh!
      @service = @client.discovered_api('calendar', 'v3')
    end
end
