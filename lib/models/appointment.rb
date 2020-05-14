# frozen_string_literal: true

class Appointment
  include Dynamoid::Document
  table capacity_mode: :on_demand

  field :subject
  field :description
  belongs_to :user
end
