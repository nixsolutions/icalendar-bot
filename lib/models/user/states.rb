# frozen_string_literal: true

class User
  module States
    STATES_ENUM = {
      start: 'start',
      select_time: 'select_time',
      select_day: 'select_day',
      confirm_day_time: 'confirm_day_time',
      write_description: 'write_description'
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
