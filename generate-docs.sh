#!/bin/bash

echo "=================="
echo "Clean Old Files"
echo "=================="

rm -R doc/css
rm -R doc/js
rm -R doc/liferay-qa-ee
rm -R doc/requirements
rm -R doc/Selenium
rm doc/*.html

echo "=================="
echo "Generate Docs"
echo "=================="

yardoc "features/*.feature" "lib/selenium-cucumber/*.rb" "lib/selenium-cucumber/*/*.rb" "*.md"