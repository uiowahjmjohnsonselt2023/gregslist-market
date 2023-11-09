require 'capybara/cucumber'
Capybara.default_driver = :selenium # You can choose a different driver
Capybara.app_host = 'http://127.0.0.1:3000' # Adjust the host to match your application's URL
