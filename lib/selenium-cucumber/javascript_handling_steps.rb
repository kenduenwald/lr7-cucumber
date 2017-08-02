require_relative 'methods/javascript_handling_methods'

Then(/^I accept the alert$/) do
  handle_alert('accept')
end

Then(/^I dismiss the alert$/) do
  handle_alert('dismiss')
end
