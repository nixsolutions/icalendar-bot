# frozen_string_literal: true

class Appointment
  include Dynamoid::Document
  table capacity_mode: :on_demand
  STATUS_ENUM = [
    DRAFT = :draft,
    COMPLETE = :complete
  ].freeze

  field :summary
  field :description
  field :status, :string, default: DRAFT
  field :started_at, :datetime
  field :ended_at, :datetime
  field :index_number, :integer
  belongs_to :user

  def self.find_or_create_draft_for_user(user)
    user.appointments.where(status: 'draft').first || user.appointments.create
  end
end
