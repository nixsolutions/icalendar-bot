# frozen_string_literal: true

class User
  include Dynamoid::Document
  table capacity_mode: :on_demand

  field :first_name
  field :last_name
  field :username
  field :subscribers
  field :bot_command_data
  has_many :appointments
end
