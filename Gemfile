source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.2'
# Use MySQL as the database for Active Record
gem 'mysql2'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Turbolinks makes navigating your web application faster.
# Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

gem 'clearance'
gem 'godmin'
gem 'jwt'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'exception_notification'
gem 'lograge'

# Gem for serializing in JSON API standard
gem 'jsonapi-serializers'

# Gem for attaching files
gem 'paperclip', '~> 5.0.0'

# Gem for handling money values
gem 'money-rails', '~>1'

gem 'error_handling_protocol', '~> 0.0.1'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop  and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'shoulda-matchers',
      git: 'https://github.com/thoughtbot/shoulda-matchers.git',
      branch: 'rails-5'

  gem 'awesome_print', require: 'ap'
end

gem 'simplecov', require: false, group: :test

gem 'rubocop', require: false, group: :test

group :development do
  # Access an IRB console on exception pages or by using <%= console %>
  # anywhere in the code.
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'brakeman', require: false
  gem 'letter_opener'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the
  # background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
