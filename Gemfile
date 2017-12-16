source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'
gem 'sqlite3'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'pg'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'

# fishgender
gem 'carrierwave'
gem 'twitter'
gem 'whenever'
gem 'mina'
gem 'bootstrap'
gem 'unicorn'
gem 'jquery-rails'
gem 'mina-unicorn', require: false
gem 'mina-whenever', require: false

#faces
gem 'aws-sdk'
gem 'ruby-instagram-scraper'

group :development, :test do
  gem 'pry-rails'
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

