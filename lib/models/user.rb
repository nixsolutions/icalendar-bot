# frozen_string_literal: true

class User
  include Dynamoid::Document
  table capacity_mode: :on_demand

  field :first_name
  field :last_name
  field :username
  field :subscribers
  field :state
  has_many :appointments
end
