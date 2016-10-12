require_relative 'boot'

#require 'rails/all'
require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
# require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Hyipstat2
  class Application < Rails::Application
    I18n.available_locales = [:en, :ru]

    Rails.application.configure do
      config.generators do |g|
        g.orm             :mongoid
        g.test_framework  false
        g.jbuilder        false
      end
    end
  end
end
