source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.5'

gem 'rails', '~> 6.0.2', '>= 6.0.2.2'
gem 'mysql2', '>= 0.4.4'
gem 'puma', '~> 4.3'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 4.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'active_model_serializers'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'line-bot-api'
gem 'dotenv-rails'
gem 'whenever', require: false
gem 'devise'
gem 'devise_token_auth'
gem 'rack-cors', require: 'rack/cors'
gem 'omniauth'
gem 'pry-rails'


group :development, :test do
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'foreman'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

# group :production, :staging do
#   gem 'unicorn', '5.4.1'
# end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
