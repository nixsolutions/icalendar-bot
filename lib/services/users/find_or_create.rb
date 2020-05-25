# frozen_string_literal: true

module Users
  class FindOrCreate < ApplicationService
    attr_reader :user

    def initialize(user)
      @user = user
    end

    def call
      User.find(user.id.to_s)
    rescue Dynamoid::Errors::RecordNotFound
      User.create(user.to_h)
    end
  end
end
