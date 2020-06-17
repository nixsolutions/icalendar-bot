# frozen_string_literal: true

class User
  module States
    STATES_ENUM = [
      START = :start,
      SELECT_TIME = :select_time,
      SELECT_DAY = :select_day,
      CONFIRM_DAY_TIME = :confirm_day_time,
      SELECT_TIME_END = :select_time_end,
      WRITE_SUMMARY = :write_summary,
      WRITE_DESCRIPTION = :write_description
    ].freeze

    def self.included(base)
      base.extend(ClassMethods)
    end

    def update_state(status)
      User.update(id, bot_status: status)
    end

    module ClassMethods
      def update_state(user, status)
        user = User.find_or_create(user)
        user.update_state(status)
      end
    end
  end
end
