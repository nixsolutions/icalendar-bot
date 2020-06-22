# frozen_string_literal: true

FactoryBot.define do
  factory :appointment, class: Appointment do
    summary { 'John' }
    description { 'Doe' }
    status { Appointment::DRAFT }
    started_at { DateTime.now }
    ended_at { started_at + 1.hour }
    index_number { 1 }
  end
end
