#***************************
# Configuration
#***************************
source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
gem 'rails', '~> 5.0.3'
gem 'pg'
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
gem "paranoia", github: "rubysherpas/paranoia", branch: "rails5"
gem 'pry-rails', :group => :development
gem 'jquery-datetimepicker-rails'
gem 'draper'

#------------------------------------------
# For Mails
#------------------------------------------
gem 'mailgun-ruby', '~>1.1.6'

#------------------------------------------
# For Searching
#------------------------------------------
gem 'ransack'
gem 'acts_as_tree'

#------------------------------------------
# Invoices & PDF
#------------------------------------------
gem 'invoicing'
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'
#------------------------------------------
# Validations
#------------------------------------------
gem 'validates_timeliness', '~> 4.0'

gem 'time_difference'

gem 'puma', '~> 3.0'
gem 'active_model_serializers', '0.9.3'

group :development do
  gem 'happy_seed'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :development, :test do
  gem 'byebug', platform: :mri
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
  gem 'webmock'
  gem 'fakeredis', require: 'fakeredis/rspec'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
  gem 'lograge'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'nokogiri'
gem 'devise', '~> 4.2'
gem 'cancancan'
gem 'devise_invitable', github: 'scambra/devise_invitable'
gem 'data-confirm-modal'
gem 'will_paginate'
gem 'will_paginate-bootstrap'
gem 'recurring_select',  git: 'https://github.com/sahild/recurring_select.git', branch: 'master'
gem 'ice_cube'


gem 'capistrano', '~> 3.7', '>= 3.7.1'
gem 'capistrano-rails', '~> 1.2'
gem 'capistrano-passenger', '~> 0.2.0'
gem 'capistrano-rvm'

