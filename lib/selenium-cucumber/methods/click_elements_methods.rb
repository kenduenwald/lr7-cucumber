require_relative 'required_files'


def click(access_type, access_name, visible_flag = true)
	expect(page).not_to have_xpath("//html[@class='lfr-spa-loading']")
	using_wait_time 15 do
		expect(page).to have_xpath("#{access_name}", visible: visible_flag)
	end
	find(:"#{access_type}", "#{access_name}", visible: visible_flag).hover unless visible_flag
	find(:"#{access_type}", "#{access_name}", visible: visible_flag).click
end

def context_click(access_type, access_name)
	expect(page).not_to have_xpath("//html[@class='lfr-spa-loading']")
	using_wait_time 15 do
		expect(page).to have_xpath("#{access_name}")
	end
	find(:"#{access_type}", "#{access_name}").right_click
end