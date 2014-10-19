source 'https://rubygems.org'

ruby '2.1.2'

gem 'rails', '4.1.6'

gem 'sass-rails', '~> 4.0.3'
gem 'haml-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'

gem 'bootstrap-sass'
gem 'autoprefixer-rails'
gem 'compass-rails'

gem 'redis'
gem 'hiredis'

group :production do
  gem 'newrelic_rpm'
  gem 'rails_12factor'
end

group :development do
  gem 'heroku'
  gem 'spring'
  gem 'powder'
  gem 'guard'
  # gem 'guard-bundler'
  gem 'guard-livereload', require: false
  gem 'guard-pow',        require: false
  gem 'guard-rspec',      require: false
  gem 'foreman'
  gem 'fakeweb'
  gem "better_errors"
  gem "binding_of_caller"
end

group :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'shoulda'
  gem 'pry-nav'
end

gem 'unicorn'
