## Introduction

This project is designed to provide a base framework for writing automated tests in Cucumber in Ruby. This implementation uses the capybara gem which makes writing tests even easier. The locator strategies are built around the [Liferay UI TagLib](https://dev.liferay.com/develop/tutorials/-/knowledge_base/7-0/using-the-liferay-ui-taglib) so I encourage the use of the Liferay UI TagLib to make testing, or at least designing generalized xpaths, a lot easiser. The [API Documentation](https://docs.liferay.com/ce/portal/7.0-latest/taglibs/util-taglib/) can be found here.

The framework is divided into multiple layers that raises in technical level as you go lower. In the top level, testers will write in Cucumber in plain english as if they were writing a manual test. 

The level below has step definitions written in ruby with a collection of convenience methods. XPaths here are designed to be generalized so that step definitions work per element. The top level stays easy so as long as you have a lean amount of clear step definitions.

In the lowest level, the capybara DSL is used to design the action methods. This is done so that testers have just the right amount of flexibility in the middle layer. When it comes to maintenance, most of the work will be done on the top and middle layers if done correctly.

Prerequisites
-------------

Google Chrome is installed

Ubuntu Installation
-------------------

Ubuntu 14 and above require additional dependencies.

What this installs is Ruby 2.3, capybara and its dependencies, capybara-screenshot which is configured to take screenshots on failure, and chromedriver-helper which is one of the simplest ways to get automating on chrome.

Install Ruby 2.3

1. `sudo apt-add-repository ppa:brightbox/ruby-ng`
1. `sudo apt-get update`
1. `sudo apt-get install ruby2.3 ruby2.3-dev`

Install Capybara

1. `sudo apt-get install libqt4-dev libqtwebkit-dev`
1. `sudo apt-get install build-essential patch`
1. `sudo apt-get install ruby-dev zlib1g-dev liblzma-dev`
1. `sudo gem install nokogiri`
1. `sudo gem install capybara -v 2.7.1`

Install the rest of the stuff

1. `sudo gem install cucumber chunky_png rspec appium_lib headless chromedriver-helper capybara-screenshot`
1. `sudo gem install selenium-webdriver -v 2.53.4`

Windows Installation
--------------------

Install Ruby 2.3

1. Download and Ruby 2.3 https://dl.bintray.com/oneclick/rubyinstaller/rubyinstaller-2.3.3-x64.exe
1. Install and make sure you check the option to "Add Ruby executables to your PATH"
1. Download and install the Ruby Development Kit using this guide https://github.com/oneclick/rubyinstaller/wiki/Development-Kit
1. Confirm that you're running ruby 2.3.3 by running `ruby -v` in a command window
1. Make sure you have gems installed by running `gem -v` on a command line

Install everything else
1. `gem install nokogiri`
1. `gem install capybara -v 2.7.1`
1. `gem install cucumber chunky_png rspec appium_lib headless chromedriver-helper capybara-screenshot`
1. `gem install selenium-webdriver -v 2.53.4`


Useful Tools
----------------
Sublime Gherkin Auto Complete Plus
https://github.com/austincrft/sublime-gherkin-auto-complete-plus

This plugin only works with Sublime Text 3 and enables Sublime to auto complete step definitions when writing a test.

YARDOC
http://yardoc.org/

This Ruby gem is used to generate the api docs for this repo. If you make change, just execute generate-docs.sh and open doc/_index.html . Navigating to doc/requirements/step_transformers.html#step_definitions will show you an index of all the step definitions.