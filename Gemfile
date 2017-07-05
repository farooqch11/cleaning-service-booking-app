#***************************
# Configuration
#***************************
source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
gem 'rails', '~> 5.0.3'

#***************************
# Layoutb & rendering
#***************************
gem 'turbolinks', '~> 5.x'
gem 'jbuilder', '~> 2.5'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'therubyracer', platforms: :ruby
gem 'jquery-rails'
gem 'haml-rails'
gem 'entypo-rails'
gem 'bootstrap-sass'
gem 'modernizr-rails'
gem 'meta-tags', require: 'meta_tags'
gem 'responders', '~> 2.0'
gem 'bh'
gem 'simple_form'
gem 'premailer-rails'
gem 'figaro'
gem 'momentjs-rails'
gem 'bootstrap3-datetimepicker-rails'
#------------------------------------------
# For Mails
#------------------------------------------
gem 'mailgun-ruby', '~>1.1.6'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'puma', '~> 3.0'

group :development do
  gem 'happy_seed'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'sqlite3'
  gem 'rspec', '~> 3.5.0'
  gem 'rspec-rails', '~> 3.5.0'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'cucumber-rails', require: false
  gem 'guard-rspec', '~> 4.6.4', require: false
  gem 'guard-cucumber'
  gem 'database_cleaner'
  gem 'spring-commands-rspec'
  gem 'spring-commands-cucumber'
  gem 'launchy'
  gem 'vcr'
  gem 'faker'
  gem 'dotenv-rails'
  gem 'rdiscount'
  gem 'rails-controller-testing'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem "letter_opener"
end

group :test do
  gem 'webmock'
  gem 'fakeredis', require: 'fakeredis/rspec'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
  gem 'lograge'
end
gem 'nokogiri'
gem 'devise', '~> 4.2'
gem 'cancancan'
gem 'devise_invitable', github: 'scambra/devise_invitable'
