require_relative 'methods/input_methods'

# input text into an alloy editor
Then(/^I enter "([^\"]*)" into the rich text editor$/) do |text|
    enter_text("xpath", text, "//div[@title='Rich Text Editor']")
end

# select many options from a multi select by the drop down label
Then(/^I select the following options from the "([^\"]*)" multiselect$/) do |access_name, table|
    data = table.raw
    data.each do |rowdata|
        rowdata.each do |entry|
            option = entry
            select_option_from_dropdown("//label[text()=' #{access_name} ']/following-sibling::select", "#{option}")
        end
    end
end

# select a full environment stack using the drop down label
Then(/^I select the following options$/) do |table|
    table.raw.each do |access_name, access_option|
        select_option_from_dropdown("//label[text()=' #{access_name} ']/following-sibling::select", "#{access_option}")
    end
end

# select options from drop down by label
Then(/^I select the "([^\"]*)" option from the "([^\"]*)" drop down$/) do |option, access_name|
    select_option_from_dropdown("//label[text()=' #{access_name} ']/following-sibling::select | //select[@title='#{access_name}'] | //input[@value='#{access_name}']/following-sibling::*//select | //optgroup[@label='Project']", "#{option}")
end

# enter text into the search bar steps
Then(/^I enter "([^\"]*)" in the search bar$/) do |text|
    clear_text("xpath", "//input[contains(@title, 'Search')]")
    enter_text("xpath", text, "//input[contains(@title, 'Search')]")
end

# enter text into input field steps
Then(/^I enter "([^\"]*)" into the "([^\"]*)" input field$/) do |text, access_name|
    clear_text("xpath", "//dt[contains(.,'#{access_name}')]/following-sibling::dd/div/input|//label[contains(.,'#{access_name}')]/following-sibling::input|//input[@title='#{access_name}' or @name='#{access_name}']|//*[@class='testray-data-header' and text()=' #{access_name} ']/following-sibling::div/div/*")
    enter_text("xpath", text, "//dt[contains(.,'#{access_name}')]/following-sibling::dd/div/input|//label[contains(.,'#{access_name}')]/following-sibling::input|//input[@title='#{access_name}' or @name='#{access_name}']|//*[@class='testray-data-header' and text()=' #{access_name} ']/following-sibling::div/div/*")
end

# enter text into date field steps
Then(/^I enter "([^\"]*)" into the "([^\"]*)" date field$/) do |text, access_name|
    clear_text("xpath", "//span[text()=' #{access_name} ']/following-sibling::*//input|//label[contains(.,'#{access_name}')]/following-sibling::input")
    enter_text("xpath", text, "//span[text()=' #{access_name} ']/following-sibling::*//input|//label[contains(.,'#{access_name}')]/following-sibling::input")
end

# enter text into text area steps
Then(/^I enter "([^\"]*)" into the "([^\"]*)" text area$/) do |text, access_name|
    clear_text("xpath", "//label[contains(.,'#{access_name}')]/following-sibling::textarea|//textarea[@title='#{access_name}']")
    enter_text("xpath", text, "//label[contains(.,'#{access_name}')]/following-sibling::textarea|//textarea[@title='#{access_name}']")
end