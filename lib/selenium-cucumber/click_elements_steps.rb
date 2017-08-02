require_relative 'methods/click_elements_methods'

# click the link by label
When(/^I click the "(.*?)" link$/) do |access_name|
  click('xpath', "//a[normalize-space(text())='#{access_name}']|//a/span[normalize-space(text())='#{access_name}']")
end

# click the actions drop down on a table row when it contains partial text
When(/^I click the drop down on the table row containing "(.*?)"$/) do |access_name|
  click('xpath', "//tr[contains(.,'#{access_name}')]/td//a[contains(@class,'dropdown-toggle')]")
end

# click the button
When(/^I click the "(.*?)" button$/) do |access_name|
    click('xpath', "//*[contains(@class,'btn')]/*[normalize-space(text())='#{access_name}']")
end

# click the button
When(/^I click the filter button$/) do
    click('xpath', "//*[@id='priorityFilterToggle']") # Click filter button
end

# click the checkbox in a table
When(/^I click the checkbox on the table row containing "([^\"]*)"$/) do |access_name|
  click('xpath', "//td[contains(., '#{access_name}')]/preceding-sibling::*//input[@type='checkbox']", visible_flag = false)
end

# click the drop down button
When(/^I click the "(.*?)" drop down button$/) do |access_name|
  sleep(1)
  click('xpath', "//a[contains(@class,'dropdown-toggle')]/span[normalize-space(text())='#{access_name}']|//a[contains(@class,'dropdown-toggle') and text()=' #{access_name} ']")
  
  using_wait_time 4 do
    expect(page).to have_xpath("//div[contains(@class,'open')]")
  end
end

# click the first item in a row that contains partial text
When(/^I click "(.*?)" in a table$/) do |access_name|
    using_wait_time 4 do
      click('xpath', "(//tr//*[normalize-space(text())='#{access_name}'])[1]")
    end
end

# click the item in context menu
When(/^I click the "(.*?)" context menu option$/) do |access_name|
    using_wait_time 4 do
        click('xpath', "//li[@class='testray-menu-item']/a[normalize-space(text())='#{access_name}']")
    end
end

# click the left or right button for multi selections
When(/^I click the "(.*?)" arrow button$/) do |arrow_button|
    if arrow_button == 'left'
      click('xpath', "//button[contains(@class,'move-right')]")
    elsif arrow_button == 'right'
      click('xpath', "//button[contains(@class,'move-left')]")
    end
end

# click the node in the breadcrumb navigation
When(/^I click "([^\"]*)" in the breadcrumb$/) do |access_name|
  click('xpath', "//div[@class='breadcrumb-container']/a[normalize-space(text())='#{access_name}']")
end

# click the option in the actions drop down when it contains partial text
When(/^I click the "(.*?)" option$/) do |access_name|
    click('xpath', "//li/a[contains(.,'#{access_name}')]")
end

# click the tab
When(/^I click the "(.*?)" tab$/) do |access_name|
  click('xpath', "//li[@class='tab']/a[normalize-space(text())='#{access_name}']")
end

# click the x to close the focused modal
When(/^I close the focused modal$/) do
    switch_to_main_content
    click('xpath', "//button[contains(.,'×')]")
end

# click an item in the sidebar
When(/^I click "(.*?)" in the sidebar$/) do |access_name|
    click('xpath', "//*[@id='sidebar']/descendant::a[@title='#{access_name}']")
    # click("xpath", "//div[@class='testray-sidebar-content']//span[@class='testray-sidebar-text' and text()='#{access_name}']/preceding-sibling::span[@class='testray-sidebar-icon']")
end

# click an item in the manage menu
When(/^I click the "(.*?)" option in the manage menu$/) do |access_name|
    click('xpath', "//li[@class='testray-menu-item']//span[normalize-space(text())='#{access_name}']|//li[@class='testray-menu-item']//span[normalize-space(text())='#{access_name}']")
end

# right click the first item in a row that contains partial text
When(/^I right click "(.*?)" in a table$/) do |access_name|
    using_wait_time 4 do
        context_click('xpath', "//tr//a[normalize-space(text())='#{access_name}']|//td[normalize-space(text())='#{access_name}']")
    end
end

# Click the page specific options dropdown
When(/^I click the manage page drop down/) do
    click('xpath', "//div[@class='dropdown manage-page-dropdown']/a")
end

# Click an option in the page specific options menu
When(/^I click the "([^"]*)" option in the manage page menu$/) do |access_name|
    click('xpath', "//div[@class='dropdown manage-page-dropdown open']/descendant::span[normalize-space(text())='#{access_name}']")
end

# Click a checkbox
When(/^I (un)?check the "([^"]*)" checkbox$/) do |uncheck, access_name|
    e = find(:xpath, "//input[@type='checkbox']/following-sibling::text()[contains(.,'#{access_name}')]/preceding-sibling::input")
    uncheck == 'un' ? e.set(false) : e.set(true)
end

# Table format:  | Filter Param |
# One option per table row
When(/^I (un)?select the following from the "([^"]*)" multiselect$/) do |unselect, access_name, table|
    table.rows.each do |row|
        unselect == 'un' ? unselect_from_multiselect(access_name, row[0]) : select_from_multiselect(access_name, row[0])
    end
end
