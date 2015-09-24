source 'https://rubygems.org'
ruby '2.2.3'

gem 'rails', '4.2.4'
gem 'pg'
gem 'sass-rails', '~> 5.0'
gem 'bootstrap-sass'
gem 'haml-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'bcrypt', '~> 3.1.7'
gem 'fabrication'
gem 'faker'
# gem 'turbolinks'

group :development do
  gem 'thin' # web server
  # An IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  gem 'spring'
end

group :development, :test do
  gem 'pry-byebug'
  gem 'rspec-rails', '~> 3.0'
end

group :test do
  gem 'database_cleaner', '1.5.0'
  gem 'shoulda-matchers', require: false
  gem 'capybara'
  gem 'launchy'
end

group :production do
  gem 'rails_12factor'
end
