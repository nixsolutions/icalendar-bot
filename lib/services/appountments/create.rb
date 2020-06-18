# frozen_string_literal: true

module Appointments
  class Create < ApplicationService
    attr_reader :appointments
    def initialize(user)
      @appointments = user.appointments
    end

    def call
      appointments.create(index_number: appointments.count + 1)
    end
  end
end
