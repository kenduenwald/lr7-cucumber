require_relative 'required_files'

# method to enter text into textfield
def enter_text(access_type, text, access_name)
  find(:"#{access_type}", "#{access_name}").set("#{text}")
end

# method to clear text from textfield
def clear_text(access_type, access_name)
  find(:"#{access_type}", "#{access_name}").set("")
end

# method to select option from dropdwon list
def select_option_from_dropdown(access_name, option)
	find(:xpath, "#{access_name}")
	within(:xpath, "#{access_name}") do
    	select("#{option}")
  	end
end

def select_from_multiselect(access_name, option)
	e = find(:xpath, "//label[contains(text(),'#{access_name}')]/following-sibling::select") # Get Node::Element from xpath
	e.select(option)
end

def unselect_from_multiselect(access_name, option)
	e = find(:xpath, "//label[contains(text(),'#{access_name}')]/following-sibling::select") # Get Node::Element from xpath
	e.unselect(option)
end