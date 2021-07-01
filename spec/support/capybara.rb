# frozen_string_literal: true

def capybara_remote_driver(remote_url, browser_type)
  remote_browser = :remote_browser
  Capybara.register_driver remote_browser do |app|
    Capybara::Selenium::Driver.new(app,
                                   browser: :remote,
                                   url: remote_url,
                                   desired_capabilities: browser_type)
  end
  remote_browser
end

def configure_rspec_capybara(capybara_browser, app_host_port)
# This is always running locally (even in container) so get local IP address
  app_host = IPSocket.getaddress(Socket.gethostname)
  RSpec.configure do |config|
    config.before(:each, type: :system) do
      driven_by capybara_browser

      Capybara.app_host = "http://#{app_host}:#{app_host_port}"
      Capybara.server_host = app_host
      Capybara.server_port = app_host_port
    end
  end
end

## Configure RSpec System Tests with Environment-Specified Remote Capybara Driver ##
capybara_browser = capybara_remote_driver(ENV['SELENIUM_REMOTE'], ENV['SELENIUM_BROWSER'].to_sym)
configure_rspec_capybara(capybara_browser, ENV['APP_HOST_PORT'])

