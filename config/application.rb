require_relative 'boot'
require 'rails/all'

Bundler.require(*Rails.groups)

module TaskNotify
  class Application < Rails::Application
    config.load_defaults 6.0

    config.generators do |g|
      g.template_engine     false
      g.javascripts         false
      g.stylesheets         false
      g.helper              false
      g.test_framework      :rspec,
      fixtures:             true,
      fixture_replacement:  :factory_bot,
      view_specs:           false,
      routing_specs:        false,
      helper_specs:         false,
      controller_specs:     false,
      request_specs:        true
    end
    config.api_only = true
    config.middleware.use ActionDispatch::Flash
    config.assets.initialize_on_precompile = false
    config.time_zone = 'Asia/Tokyo'

    # development環境（lib/tasksのパスを通す）
    config.autoload_paths += Dir["#{config.root}/lib/**/"]
    # production環境（lib/tasksのパスを通す）
    config.eager_load_paths += Dir["#{config.root}/lib/**/"]
  end
end
