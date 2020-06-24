# frozen_string_literal: true

class IcsLinkGenerator < ApplicationService
  attr_reader :appointment

  HOST = 'www.addevent.com'

  def initialize(appointment)
    @appointment = appointment
  end

  def call
    URI::HTTP.build(host: HOST, path: '/create', query: params.to_query).to_s
  end

  def params
    {
      service: 'appleical',
      dstart: appointment.started_at.strftime('%m/%d/%Y %I:%M %p'),
      dend: appointment.ended_at.strftime('%m/%d/%Y %I:%M %p'),
      dsum: appointment.summary,
      ddesc: appointment.description,
      reference: 'https://www.addevent.com/'
    }
  end
end
