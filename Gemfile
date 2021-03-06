source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

#Figaro for environment variables
gem 'figaro'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

# Mongo DB
gem 'mongoid', '~> 5.1', '>= 5.1.3'
gem 'bson_ext'

# User Authentication
gem 'devise'

# Bootstrap 3: https://github.com/twbs/bootstrap-sass
gem 'bootstrap-sass', '3.3.4.1'

# Font-awesome: https://github.com/FortAwesome/font-awesome-sass
gem 'font-awesome-sass', '4.3.2.1'

# Cocoon for nested forms
gem 'cocoon'

# Sadstory for Date Selects
gem 'mongoid-sadstory'

# Bower, for Angle Theme
gem "bower-rails", "~> 0.9.2"

# Wheneverise for CronJobs
gem 'whenever', require: false

# WYSIWYG Editor
gem 'ckeditor'

# Cucumber Testing
group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'cucumber-rails'
  gem 'selenium-webdriver'
end
group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'launchy'
  gem 'mongoid-rspec'
end

# Heroku hosting
group :production do
	gem 'rails_12factor'
end

#Stripe Subscriptions
gem 'stripe'


# File Uploads
gem "mongoid-paperclip"
gem 'aws-sdk', '~> 1'
gem 'aws-sdk-resources', '~> 2'

# Rebrandly URL Shortening
gem 'rebrandly'
