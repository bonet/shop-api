require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ShopApi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    config.before_configuration do
      REDIS_CONFIG = YAML.load_file("#{Rails.root}/config/redis.yml").with_indifferent_access[Rails.env]
      port_format = REDIS_CONFIG['port'] == 6379 ? "" : ":#{REDIS_CONFIG['port']}"
      redis_config_url_format = "redis://#{REDIS_CONFIG['host']}#{port_format}/#{REDIS_CONFIG['namespace']}"
      config.cache_store = :redis_store, redis_config_url_format
    end

    config.middleware.use Rack::Cors do
      allow do
        origins 'localhost:8080'
        resource '*',
        :headers => :any, :methods => [:get, :post, :delete, :put, :options, :patch],
        :expose => ["Links", "X-Total", "X-Api-Cache-Key" ]
      end
    end
  end
end
