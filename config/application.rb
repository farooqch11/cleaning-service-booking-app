require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module JoaanaCleaningService
  class Application < Rails::Application
    # Use the responders controller from the responders gem
    # config.app_generators.scaffold_controller :responders_controller

    # config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components')    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    # config.action_view.field_error_proc = Proc.new { |html_tag, instance| html_tag }
    # config.generators do |g|
    #   g.stylesheets = false
    #   g.scaffold_controller "scaffold_controller"
    #   g.test_framework :rspec, fixture: true, fixture_replacement: :factory_girl, helper_specs: false, view_specs: false, routing_specs: false, controller_specs: false
    # end
    config.time_zone = 'Europe/London'
    config.active_record.time_zone_aware_types = [:datetime, :time]
    config.exceptions_app = self.routes

    # config.time_zone = 'Asia/Karachi'
  end
end
