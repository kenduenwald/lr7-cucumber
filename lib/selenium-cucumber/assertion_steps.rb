require_relative 'methods/assertion_methods'

#step to check if text exists on the wiki content
Then(/^I should\s*((?:not)?)\s+see "([^\"]*)" in the wiki content$/) do |present, access_name|
    check_element_presence("//div[@class='wiki-body']/p[normalize-space(text())='#{access_name}']", present)
end

#step to check if a button exists on a page
Then(/^I should\s*((?:not)?)\s+see the "([^\"]*)" button on the page$/) do |present, access_name|
    check_element_presence("//*[contains(@class,'btn')]/*[text()='#{access_name}']", present)
end

#step to check if the default portrait is the proper initials
Then(/^I should\s*((?:not)?)\s+see the default avatar displaying "([^\"]*)"$/) do |present, access_name|
  using_wait_time 4 do
    check_element_presence("//span[@class='user-avatar-image']/div/span[text()='#{access_name}']", present)
  end
end

# assert multiple terms and names on a description list <dl> <dt> <dd>
Then(/^I should\s*((?:not)?)\s+see the following in the description list$/) do |present, table|
  table.raw.each do |access_term, access_name|
      check_element_presence("//div[@class='testray-data-section']/descendant::*[text()=' #{access_term} ']/following-sibling::*/descendant-or-self::*[text()=' #{access_name} ' or text()='#{access_name}']", present)
  end
end

# assert multiple options in a multi select drop down targeted by label
Then(/^I should\s*((?:not)?)\s+see the following options in the "([^\"]*)" multiselect$/) do |present, access_name, table|
  data = table.raw
  data.each do |rowdata|
    rowdata.each do |entry|
      option = entry
        check_element_presence("//label[text()=' #{access_name} ']/following-sibling::select/option[text()=' #{option} '][1]", present)
    end
  end
end

# step to check that a table contains a certain text
Then(/^I should\s*((?:not)?)\s+see "([^\"]*)" in a table$/) do |present, access_name|
    check_element_presence("(//td[contains(.,'#{access_name}')])[1]|//td/a[contains(.,'#{access_name}')]", present)
end

#step to check that an option exists somewhere
Then(/^I should\s*((?:not)?)\s+see the "([^\"]*)" option in a drop down$/) do |present, access_name|
    check_element_presence("(//option[contains(.,'#{access_name}')])[1]", present)
end

#step to check that an option is currently selected in a drop down
Then(/^I should\s*((?:not)?)\s+see the "([^\"]*)" option selected in the "([^\"]*)" drop down$/) do |present, option, access_name|
    check_element_presence("(//label[text()=' #{access_name} ']/following-sibling::select/*/option[contains(@selected,'') and text()=' #{option} '])[1]", present)
end

#step to check that an environment is currently selected in the options drop down
Then(/^I should\s*((?:not)?)\s+see the "([^\"]*)" environment selected in the "([^\"]*)" drop down$/) do |present, option, access_name|
    check_element_presence("(//input[@value='#{access_name}']/following-sibling::*//option[contains(@selected,'') and text()=' #{option} '])[1]", present)
end

#step to check the text for the total number for pagination items
Then(/^I should\s*((?:not)?)\s+see that the pagination text contains "([^\"]*)"$/) do |present, access_name|
    check_element_presence("(//small[contains(.,'Showing 1 - 20 of')])[1]", present)
end

# step to check that the breadcrumb contains a specific text
Then(/^I should\s*((?:not)?)\s+see "([^\"]*)" in the breadcrumb$/) do |present, expected_value|
    check_element_partial_text("xpath", "#{expected_value}", "(//span[@class='breadcrumb-display-container'])[1]", present)
end

# step to check that the modal title is a specific text
Then(/^I should\s*((?:not)?)\s+see "([^\"]*)" in the modal title$/) do |present, access_name|
    switch_to_main_content
    check_element_presence("//h3[text()='#{access_name}']", present)
    switch_to_focused_iframe
end

# step to check for the presence of a success or error alert notification
Then(/^I should\s*((?:not)?)\s+see an? (success|error) alert$/) do |present, expected_response|
    within(:xpath, "//*[@class='lfr-alert-container']") do
        expected_response == 'success' ? access_name = 'success' : access_name = 'danger'
        check_element_presence("//*[contains(@class,'alert-#{access_name}')]", present)
    end
end
