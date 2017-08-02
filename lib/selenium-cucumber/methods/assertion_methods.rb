require 'net/https'
require_relative 'required_files'

# This file contains assertion methods which are called from assertion_steps.rb

# Method to get element text
# param 1 : String : Locator type (id, name, class, xpath, css)
# param 2 : String : Locator value
def get_element_text(access_type, access_name)
  find(:"#{access_type}", access_name).text
end

# Method to check element text
# param 1 : String : Locator type (id, name, class, xpath, css)
# param 2 : String : Expected element text
# param 3 : String : Locator value
# param 4 : Boolean : test case [true or flase]
def check_element_text(access_type, expected_value, access_name, test_case)
  element_text = get_element_text(access_type, access_name)

  if test_case
    if element_text != expected_value
      raise TestCaseFailed, "Text Not Matched, Actual Text : #{element_text}, Expected Text : #{expected_value}"
    end
  else
    if element_text == expected_value
      raise TestCaseFailed, "Text Matched, Actual Text : #{element_text}"
    end
  end
end

# Method to check partial element text
# param 1 : String : Locator type (id, name, class, xpath, css)
# param 2 : String : Expected element partial text
# param 3 : String : Locator value
# param 4 : Boolean : test case [true or flase]
def check_element_partial_text(access_type, expected_value, access_name, test_case)
  element_text = get_element_text(access_type, access_name)

  if test_case
    if not element_text.include? "#{expected_value}"
      raise TestCaseFailed, "Element text : #{element_text}, does not contains partial text as : #{expected_value}"
    end
  else
    if element_text.include? "#{expected_value}"
      raise TestCaseFailed, "Element text : #{element_text}, contains partial text as : #{expected_value}"
    end
  end
end

# Method to return element status - enabled?
# param 1 : String : Locator type (id, name, class, xpath, css)
# param 2 : String : Locator value
def is_element_enabled(access_type, access_name)
  WAIT.until{ $driver.find_element(:"#{access_type}" => "#{access_name}") }.enabled?
end

# Element enabled checking
# param 1 : String : Locator type (id, name, class, xpath, css)
# param 2 : String : Expected element text
# param 4 : Boolean : test case [true or flase]
def check_element_enable(access_type, access_name, test_case)
  result = is_element_enabled(access_type, access_name)

  if test_case
    raise TestCaseFailed, 'Element Not Enabled' unless result
  else
    raise TestCaseFailed, 'Element Enabled' unless !result
  end
end

# method to get attribute value
# param 1 : String : Locator type (id, name, class, xpath, css)
# param 2 : String : Expected element text
# param 3 : String : atrribute name
def get_element_attribute(access_type, access_name, attribute_name)
  find(:"#{access_type}", access_name)[:"#{attribute_name}"]
end

# method to check attribute value
# param 1 : String : Locator type (id, name, class, xpath, css)
# param 2 : String : atrribute name
# param 3 : String : atrribute value
# param 4 : String : Locator value
# param 5 : Boolean : test case [true or flase]
def check_element_attribute(access_type, attribute_name, attribute_value, access_name, test_case)

  attr_val = get_element_attribute(access_type, access_name, attribute_name)

  if test_case
    if attr_val != attribute_value
      raise TestCaseFailed, "Attribute Value Not Matched, Actual Value : #{attr_val}, Expected Value : #{attribute_value}"
    end
  else
    if attr_val == attribute_value
      raise TestCaseFailed, "Attribute Value Matched, Actual Value : #{attr_val}"
    end
  end
end

# method to check element presence
def check_element_presence(access_name, present)
    if present.empty?
      using_wait_time 15 do
        expect(page).to have_xpath("#{access_name}")
      end
    else
        expect(page).not_to have_xpath("#{access_name}")
    end
end

# method to assert checkbox check/uncheck
# param 1 : String : Locator type (id, name, class, xpath, css)
# param 2 : String : Locator value
# param 3 : Boolean : test case [true or flase]
def is_checkbox_checked(access_type, access_name, should_be_checked = true)
  checkbox = WAIT.until{ $driver.find_element(:"#{access_type}" => "#{access_name}") }

  if !checkbox.selected? && should_be_checked
    raise TestCaseFailed, 'Checkbox is not checked'
  elsif checkbox.selected? && !should_be_checked
    raise TestCaseFailed, 'Checkbox is checked'
  end
end

# method to assert radio button selected/unselected
# param 1 : String : Locator type (id, name, class, xpath, css)
# param 2 : String : Locator value
# param 3 : Boolean : test case [true or flase]
def is_radio_button_selected(access_type, access_name, should_be_selected = true)
  radio_button = WAIT.until{ $driver.find_element(:"#{access_type}" => "#{access_name}") }

  if !radio_button.selected? && should_be_selected
    raise TestCaseFailed, 'Radio Button not selected'
  elsif radio_button.selected? && !should_be_selected
    raise TestCaseFailed, 'Radio Button is selected'
  end
end

# method to assert option from radio button group is selected/unselected
def is_option_from_radio_button_group_selected(access_type, by, option, access_name, should_be_selected = true)
  radio_button_group = WAIT.until{ $driver.find_elements(:"#{access_type}" => "#{access_name}") }

  getter = ->(rb, by) { by == 'value' ? rb.attribute('value') : rb.text }

  ele = radio_button_group.find { |rb| getter.call(rb, by) == option }

  if !ele.selected? && should_be_selected
    raise TestCaseFailed, 'Radio button is not selected'
  elsif ele.selected? && !should_be_selected
    raise TestCaseFailed, 'Radio button is selected'
  end
end

# method to get javascript pop-up alert text
def get_alert_text
  $driver.switch_to.alert.text
end

# method to check javascript pop-up alert text
def check_alert_text(text)
  if get_alert_text != text
    raise TestCaseFailed,  "Text on alert pop up not matched, Actual Text : #{get_alert_text}, Expected Text : #{text}"
  end
end

def is_option_from_dropdown_selected(access_type, by, option, access_name, should_be_selected=true)
  dropdown = WAIT.until { $driver.find_element(:"#{access_type}" => "#{access_name}") }
  select_list = Selenium::WebDriver::Support::Select.new(dropdown)

  if by == 'text'
    actual_value = select_list.first_selected_option.text
  else
    actual_value = select_list.first_selected_option.attribute('value')
  end

  if !actual_value == option && should_be_selected
    raise TestCaseFailed, 'Option Not Selected From Dropwdown'
  elsif actual_value == option && !should_be_selected
    raise TestCaseFailed, 'Option Selected From Dropwdown'
  end
end

# Method to find difference between images
def does_images_similar?(actual_img_access_type, actual_img_access_name, excp_img_access_type, excp_img_access_name)
  if !compare_image(actual_img_access_type, actual_img_access_name, excp_img_access_type, excp_img_access_name)
    raise TestCaseFailed, 'Actual image is different from expected image'
  end
end

# Method to compare two images
# param 1 : String : Locator type (id, name, class, xpath, css, url)
# param 2 : String : Locator value
# param 3 : String : Locator type (id, name, class, xpath, css, url, image_name)
# param 4 : String : Locator value
def compare_image(actual_img_access_type, actual_img_access_name, excp_img_access_type, excp_img_access_name)
  if actual_img_access_type == 'url'
    actual_img_url = actual_img_access_name
  else
    actual_img_url = get_element_attribute(actual_img_access_type, actual_img_access_name, 'src')
  end

  if excp_img_access_type == 'url'
    expected_img_url = excp_img_access_name
  elsif excp_img_access_type == 'image_name'
    expected_img_url = './features/expected_images/' + excp_img_access_name
  else
    expected_img_url = get_element_attribute(excp_img_access_type, excp_img_access_name, 'src')
  end

  # replace 'https' with 'http' from actual image url
  if actual_img_url.include? 'https'
    actual_img_url['https'] = 'http'
  end

  # replace 'https' with 'http' from expected image url
  if expected_img_url.include? 'https'
    expected_img_url['https'] = 'http'
  end

  if expected_img_url.include? '.png'
    image_type = 'png'
  else
    image_type = 'jpg'
  end

  # Storing actual image locally
  open('./features/actual_images/actual_image.' + image_type, 'wb') do |file|
    file << open(actual_img_url).read
  end
  
  actual_img_url = './features/actual_images/actual_image.' + image_type

  # Storing Expected image locally
  if excp_img_access_type != 'image_name'
    open('./features/expected_images/expected_image.' + image_type, 'wb') do |file|
      file << open(expected_img_url).read
    end
    expected_img_url = './features/expected_images/expected_image.' + image_type
  end

  # Verify image extension and call respective compare function
  if image_type == 'png'
    return compare_png_images(expected_img_url, actual_img_url)
  end

  compare_jpeg_images(expected_img_url, actual_img_url)
end

# Comparing jpg images
def compare_jpeg_images(expected_img_url, actual_img_url)
  if open(expected_img_url).read == open(actual_img_url).read
    return true
  else
    puts 'Difference in images'
    return false
  end
end

# Comparing png images
def compare_png_images(expected_img_url, actual_img_url)
  images = [
    ChunkyPNG::Image.from_file(expected_img_url),
    ChunkyPNG::Image.from_file(actual_img_url)
  ]

  diff = []

  images.first.height.times do |y|
    images.first.row(y).each_with_index do |pixel, x|
      diff << [x, y] unless pixel == images.last[x, y]
    end
  end

  if diff.length != 0
    puts "\npixels (total):     #{images.first.pixels.length}"
    puts "pixels changed:     #{diff.length}"
    puts "pixels changed (%): #{(diff.length.to_f / images.first.pixels.length) * 100}%"

    x, y = diff.map { |xy| xy[0] }, diff.map { |xy| xy[1] }
    images.last.rect(x.min, y.min, x.max, y.max, ChunkyPNG::Color.rgb(0, 255, 0))
    cur_time = Time.now.strftime('%Y%m%d%H%M%S%L')
    images.last.save("./features/image_difference/difference_#{cur_time}.png")

    puts "\nDifference between images saved as : difference_#{cur_time}.png\n"
    return false
  end
  true
end

# Check if currently on the Trestray page by checking the title. Returns 'true'|'false'.
def on_page_testray?
  Capybara.using_wait_time 360 do
    page.should have_content("Results")
  end
end