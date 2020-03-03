# frozen_string_literal: true

Application.namespace(:i18n) do |container|
  load_paths = Dir["#{container.root}/config/*.yml"]

  container.finalize(:i18n) do
    require 'i18n'
    # require "dry-validation"

    I18n.load_path += load_paths
    I18n.backend.load_translations

    container.register :t, I18n.method(:t)
  end
end
