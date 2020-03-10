# frozen_string_literal: true

class Appointment
  include Dynamoid::Document

  field :subject
  field :description
  belongs_to :user
end
