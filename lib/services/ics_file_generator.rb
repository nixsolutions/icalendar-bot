# frozen_string_literal: true

class IcsFileGenerator < ApplicationService
  attr_reader :appointment

  def initialize(appointment)
    @appointment = appointment
  end

  def call
    Faraday::UploadIO.new(icalendar_file.path, 'text/calendar', "#{appointment.summary}.ics")
  end

  private

  def calendar
    cal = Icalendar::Calendar.new
    cal.event do |e|
      e.dtstart     = appointment.started_at
      e.dtend       = appointment.ended_at
      e.summary     = appointment.summary
      e.description = appointment.description
    end
    cal
  end

  def icalendar_file
    file = Tempfile.new(%w[new .ics])
    file.write(calendar.to_ical)
    file.rewind
    file.close
    file
  end
end
