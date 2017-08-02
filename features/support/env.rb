require 'rubygems'
require 'selenium-cucumber'

# Store command line arguments

screenshot_dir = "features/screenshots"

# Capybara driver registration

Capybara.register_driver :selenium_chrome do |app|
 	Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara::Screenshot.register_driver(:selenium_chrome) do |driver, path|
 driver.browser.save_screenshot(path)
end

# Capybara screenshot properties

Capybara.save_path = screenshot_dir
Capybara::Screenshot.prune_strategy = :keep_last_run
# Capybara::Screenshot.prune_strategy = { keep: 1 }
Capybara::Screenshot::RSpec.add_link_to_screenshot_for_failed_examples = true
Capybara::Screenshot.autosave_on_failure = false