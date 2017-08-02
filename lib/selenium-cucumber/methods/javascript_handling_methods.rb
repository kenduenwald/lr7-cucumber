require_relative 'required_files'

def handle_alert(decesion)
  if decesion == 'accept'
    sleep(0.5)
    page.driver.browser.switch_to.alert.accept
  else
    sleep(0.5)  
    page.driver.browser.switch_to.alert.dismiss
  end
end

def handle_js_confirm(accept=true)
  sleep(0.5)
  page.evaluate_script("window.confirm = function(){return true;}")
end
