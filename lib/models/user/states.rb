# frozen_string_literal: true

class User
  module States
    STATES_ENUM = {
      start: 1,
      select_time: 2,
      select_day: 3,
      confirm_day_time: 4,
      write_description: 5
    }.freeze

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def set_state(user, status)
        user = User.find_or_create(user)
        User.update(user.id, bot_status: STATES_ENUM.fetch(status))
      end
    end
  end
end
