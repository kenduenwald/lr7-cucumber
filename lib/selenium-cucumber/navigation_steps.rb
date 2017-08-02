require_relative 'methods/navigate_methods'

# open a page to a given url
Given(/^I open the browser to "(.*?)"$/) do |access_name|
	Capybara.current_driver = :selenium_chrome
	Capybara.app_host = ("#{access_name}")
	
	dest_url = "#{access_name}"
	
	visit(dest_url)
	attempts = 1
	unless assert_current_path(dest_url, {url: true, wait: 3})
		if attempts >= 5
			break
		else
			visit(dest_url)
			puts "Browser failed to open. On attempt: " + attempts.to_s
			attempts += 1
		end
	end	
end


# step to switch to main content
Then(/^I switch to the main frame$/) do
  switch_to_main_content
end

# step to switch to a modal
Then(/^I switch to the focused modal$/) do
  switch_to_focused_iframe
end

# step to refresh page
Then(/^I refresh the page$/) do
  page.evaluate_script("window.location.reload()")
end