require_relative 'required_files'

# target the testray modal
def switch_to_focused_iframe
    switch_to_main_content
    using_wait_time 4 do
        attr_id = get_element_attribute("xpath", "//iframe[contains(@class,'dialog-iframe-node')]", "id")
        page.driver.browser.switch_to.frame "#{attr_id}"
    end
end

# method to switch to main window
def switch_to_main_content
    page.driver.browser.switch_to.window(page.driver.browser.window_handles.first)
end
