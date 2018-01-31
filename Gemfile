source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'
gem 'pg', '~> 0.21'
gem 'puma', '~> 3.7'
gem 'kaminari', '~> 0.16.3'
gem 'will_paginate', '3.1.5'
gem 'rack-cors', :require => 'rack/cors'
gem 'jbuilder'
gem 'slim'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'pry-rails'
  gem 'factory_bot_rails', '~> 4.0'
  gem 'awesome_print'
end

group :test do
  gem 'minitest'
  gem 'database_cleaner'
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '2.8.0'
  gem 'rails-controller-testing'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
