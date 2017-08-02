require_relative 'required_files'

# Screenshot and save html page

def screenshot_and_save_page
    Capybara::Screenshot.screenshot_and_save_page
end