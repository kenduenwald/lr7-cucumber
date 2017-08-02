[![Gem Version](https://badge.fury.io/rb/selenium-cucumber.svg)](http://badge.fury.io/rb/selenium-cucumber)

# Introduction

This project is designed to provide a base framework for writing automated tests in Cucumber in Ruby. This implementation uses the capybara gem which makes writing tests even easier. 

The framework is divided into multiple layers that raises in technical level as you go lower. In the top level, testers will write in Cucumber in plain english -- as if they were writing a manual test. 

The level below has step definitions written in ruby with a collection of convenience methods. XPaths here are designed to be generalized so that step definitions work per element. The top level stays easy so as long as you have a lean amount of clear step definitions.

In the lowest level, the capybara DSL is used to design the action methods. This is done so that testers have just the right amount of flexibility in the middle layer. When it comes to maintenance, most of the work will be done on the top and middle layers if done correctly.

Prerequisites
-------------

Google Chrome is installed

Ubuntu Installation
-------------------

Ubuntu 14 and above require additional dependencies.

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

1. `sudo gem install cucumber chunky_png rspec appium_lib headless chromedriver-helper`
1. `sudo gem install selenium-webdriver -v 2.53.4`


Useful Tools
----------------
Sublime Gherkin Auto Complete Plus
https://github.com/austincrft/sublime-gherkin-auto-complete-plus

This plugin only works with Sublime Text 3 and enables Sublime to auto complete step definitions when writing a test.