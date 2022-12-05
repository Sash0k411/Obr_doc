source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.0.6'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'bootstrap',     '4.1.1'
gem 'sass-rails', '~> 5'
gem 'webpacker', '~> 4.0'
gem 'haml-rails', '~> 2.0'
gem 'carrierwave', '~> 2.0'
gem 'jquery-rails'
gem 'rabl-rails'
gem 'gon'
gem 'material-sass', '4.1.1'
gem 'config'
gem 'active_interaction'
gem 'active_model_serializers'
gem 'carrierwave-aws'
gem 'carrierwave-base64'
gem 'kaminari'
gem 'rest-client'
gem 'sitemap_generator'
gem 'mini_magick'
gem 'russian'
gem 'draper'
gem 'meta-tags'
gem 'spreadsheet_architect'
gem 'roo'
gem 'purecss'
gem "actionpack-page_caching"
gem 'docx'

group :development, :test do
  gem 'pry-byebug'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

group :production do
  gem 'unicorn', '5.4.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]