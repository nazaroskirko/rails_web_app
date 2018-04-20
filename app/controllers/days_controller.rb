class DaysController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]
  def check
    params[:doctor_id].present? ? doctor = User.find(params[:doctor_id]) : doctor = current_user
    date = params[:date].to_datetime
    specific_date_guidelines = doctor.days.where(date: date)
    day_of_week_guidelines = doctor.days.where(day_num: date.wday)
    appointments = doctor.appointments.where("date = ? AND status= ?", date.to_date, Appointment.statuses[:confirmed].to_i) + doctor.appointments.where("date = ? AND status= ?", date.to_date, Appointment.statuses[:synced].to_i)
    if specific_date_guidelines.empty? && day_of_week_guidelines.empty?
      @start_times = {"9:00 AM": "9:00 AM","9:30 AM": "9:30 AM","10:00 AM": "10:00 AM","10:30 AM": "10:30 AM","11:00 AM": "11:00 AM","11:30 AM": "11:30 AM","12:00 PM": "12:00 PM","12:30 PM": "12:30 PM","1:00 PM ": "1:00 PM","1:30 PM": "1:30 PM","2:00 PM": "2:00 PM","2:30 PM": "2:30 PM","3:00 PM": "3:00 PM","3:30 PM": "3:30 PM","4:00 PM": "4:00 PM"}
    elsif specific_date_guidelines.empty?
      @start_times = start_times(day_of_week_guidelines, appointments).to_json
    else
      @start_times = start_times(specific_date_guidelines, appointments).to_json
    end
    print @start_times
    respond_to do |format|
      format.json {render json: @start_times}
    end
  end


  def check_end
    params[:doctor_id].present? ? doctor = User.find(params[:doctor_id]) : doctor = current_user
    date = params[:date].to_datetime
    specific_date_guidelines = doctor.days.where(date: date)
    day_of_week_guidelines = doctor.days.where(day_num: date.wday)
    appointments = doctor.appointments.where("date = ? AND status= ?", date.to_date, 1) + doctor.appointments.where("date = ? AND status= ?", date.to_date, Appointment.statuses[:synced].to_i)
    if specific_date_guidelines.empty? && day_of_week_guidelines.empty?
      @end_times = generic_ends params[:start]
    elsif specific_date_guidelines.empty?
      @end_times = end_times day_of_week_guidelines, appointments, params[:start]
    else
      @end_times = end_times specific_date_guidelines, appointments, params[:start]
    end
    respond_to do |format|
      format.json {render json: @end_times}
    end
  end

  def new
    @day = Day.new
  end

  def create
    @day = Day.new(day_params)
    @day.user_id = current_user.id
    @day_num = nil if @day.date
    @day.start = nil if !@day.open
    @day.end = nil if !@day.open
    @day.save
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @day = Day.find(params[:id])
    @day.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def start_times matching_date_records, appointments
    available_time_blocks = {}
    matching_date_records.each do |r|
      if r.open == false
        return {"No Times Available": "No Times Available"}
      else
        start = r.start
        while start <= r.end
          available_time_blocks["#{start.strftime('%I:%M%p')}"] = start.strftime('%I:%M%p')
          start = start + 30.minutes
        end
      end
    end
    appointments.each do |a|
      beginning = a.start - 30.minutes
      while beginning < a.end
        available_time_blocks.delete_if {|key, value| key == beginning.strftime('%I:%M%p') }
        beginning = beginning + 30.minutes
      end
    end
    available_time_blocks
  end

  def end_times matching_date_records, appointments, start_time
    available_time_blocks = {}
    start_times = []
    appointments.each do |a|
      start_times << a.start.strftime('%I:%M%p')
    end
    matching_date_records.each do |m|
      start_times << (m.end + 30.minutes).strftime('%I:%M%p')
    end
    answer = false
    first_hour = (start_time.to_time + 1.hour).strftime('%I:%M%p')
    hour = start_time.to_time + 1.hour
    if start_times.include? first_hour
      available_time_blocks["#{first_hour}"] = first_hour
      answer == true
    else

      until answer == true

        available_time_blocks["#{hour.strftime('%I:%M%p')}"] = hour.strftime('%I:%M%p')

        hour = hour + 30.minutes
        if start_times.include? hour.strftime('%I:%M%p')
          answer = true
        end
      end
    end
    available_time_blocks
  end

  def generic_ends start
    available_time_blocks = {}
    start = start.to_time
    beginning = start + 1.hour
    finish = start.end_of_day - 6.hours
    while beginning <= finish
      available_time_blocks["#{beginning.strftime('%I:%M%p')}"] = beginning.strftime('%I:%M%p')
      beginning = beginning + 30.minutes
    end
    available_time_blocks
  end

private

def day_params
  params.require(:day).permit(:start, :end, :open, :date, :day_num)
end

end
