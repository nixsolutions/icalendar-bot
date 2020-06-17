# frozen_string_literal: true

class IcsFileGenerator < ApplicationService
  attr_reader :appointment

  def initialize(appointment)
    @appointment = appointment
  end

  def call
    Faraday::UploadIO.new(icalendar_file,
                          'text/calendar;charset=UTF-8',
                          "#{appointment.subject}.ics",
                          'Content-Disposition': 'inline')
  end

  private

  def calendar
    Icalendar::Calendar.new.event do |e|
      e.dtstart     = appointment.started_at
      e.dtend       = appointment.ended_at
      e.summary     = appointment.subject
      e.description = appointment.description
    end
  end

  def icalendar_file
    file = Tempfile.new(%w[new .ics])
    file.write(calendar.to_ical)
    file.rewind
    file.close
    file
  end
end
