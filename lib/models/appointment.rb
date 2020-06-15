# frozen_string_literal: true

class Appointment
  include Dynamoid::Document
  table capacity_mode: :on_demand
  STATUS_ENUM = [
    DRAFT = :draft,
    COMPLETE = :complete
  ].freeze

  field :subject
  field :description
  field :status, default: DRAFT
  field :started_at, :datetime
  field :ended_end, :datetime
  field :index_number, :integer
  belongs_to :user
end
