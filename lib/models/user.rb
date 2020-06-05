# frozen_string_literal: true

class User
  include Dynamoid::Document
  include States
  table capacity_mode: :on_demand

  field :first_name
  field :last_name
  field :username
  field :subscribers
  field :bot_status, :string
  has_many :appointments

  def self.find_or_create(user)
    find(user.id.to_s)
  rescue Dynamoid::Errors::RecordNotFound
    create(user.to_h)
  end
end
