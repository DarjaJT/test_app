source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.5'
gem 'bootstrap-sass', '2.3.2.0'
gem 'sqlite3'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'


gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'zeus', '~> 0.15.14'
gem 'pg', '0.15.1'
gem 'rails_12factor', '0.0.2'
gem 'bcrypt-ruby', '3.1.2'


group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rspec-rails'
  gem 'rspec'
  gem 'guard-rspec'
  gem 'better_errors', '~> 2.3'
  gem 'binding_of_caller'
end

group :test do
  gem 'selenium-webdriver', '2.35.1'
  gem 'capybara', '~> 2.15', '>= 2.15.1'
  gem 'factory_girl_rails', '4.2.1'
end


group :doc do
  gem 'sdoc', '0.3.20', require: false
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'

  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
#gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
