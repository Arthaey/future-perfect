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
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

def fake_http_response(url, filename)
  http_response = File.read("spec/http_responses/#{filename}")
  FakeWeb.register_uri(:get, url, body: http_response, content_type: "text/html")
end

module FuturePerfect
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Don't generate system test files.
    config.generators.system_tests = nil

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    FakeWeb.allow_net_connect = %r(https://coveralls.io)
    fake_http_response(%r(https://www.goodreads.com/), "goodreads.html")
    fake_http_response(%r(https://www.amazon.com/), "amazon.html")
  end
end
