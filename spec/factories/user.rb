# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: User do
    first_name { 'John' }
    last_name { 'Doe' }
    username { 'test' }
    subscribers { [] }
  end
end
