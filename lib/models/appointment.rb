# frozen_string_literal: true

class Appointment
  include Dynamoid::Document
  table capacity_mode: :on_demand

  field :subject
  field :description
  field :started_at, :datetime
  field :ended_end, :datetime
  field :index_number, :integer
  belongs_to :user
end
