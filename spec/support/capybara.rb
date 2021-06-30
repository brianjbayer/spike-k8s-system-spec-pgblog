# frozen_string_literal: true

## Register the Environment-Specified Remote Browser ##
remote_url = ENV['SELENIUM_REMOTE']
browser_type = ENV['SELENIUM_BROWSER'].to_sym
Capybara.register_driver :remote_browser do |app|
  Capybara::Selenium::Driver.new(app,
                                 browser: :remote,
                                 url: remote_url,
                                 desired_capabilities: browser_type)
end

## Configure RSpec Capybara ##
app_host_port = ENV['APP_HOST_PORT']
# This is always running locally (even in container) so get local IP address
app_host = IPSocket.getaddress(Socket.gethostname)
RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :remote_browser

    Capybara.app_host = "http://#{app_host}:#{app_host_port}"
    Capybara.server_host = app_host
    Capybara.server_port = app_host_port
  end
end
