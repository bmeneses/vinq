source 'https://rubygems.org'

gem 'rails', '3.2.9'
gem 'bootstrap-sass', '2.0.0'
gem 'bcrypt-ruby', '3.0.1'
gem 'faker', '1.0.1'
gem 'will_paginate', '~> 3.0.3'
gem 'bootstrap-will_paginate', '0.0.5'
gem 'hashie', '1.2'
gem 'httparty'
gem 'fakeweb'
gem 'pg', '0.12.2'

group :development do
#  gem 'sqlite3', '1.3.5'
  gem 'annotate', '~> 2.4.1.beta'
  gem 'pry'
  gem 'foreman'
  gem 'bullet'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '3.2.4'
  gem 'coffee-rails', '3.2.2'
  gem 'uglifier', '1.2.3'
end

gem 'jquery-rails', '~> 2.0.0'

group :test, :development do
  gem 'rspec-rails', '~> 2.8.rc'
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'spork'
  gem 'railroady'
  gem 'vcr'
  gem 'rails_best_practices'
  gem 'hirb'
end

group :test do
  gem 'capybara', '1.1.2'
  gem 'rb-fsevent', '~> 0.9.1'
  gem 'growl', '1.0.3'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'cucumber-rails', '1.2.1', require: false
  gem 'database_cleaner', '0.7.0'
  gem 'guard-cucumber'
end

group :production do
  gem 'thin'
end