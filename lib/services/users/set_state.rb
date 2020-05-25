# frozen_string_literal: true

module Users
  class SetState < ApplicationService
    attr_reader :user_id, :state

    def initialize(user_id, state)
      @user_id = user_id
      @state = state
    end

    def call
      User.update(user_id, state: state)
    end
  end
end
