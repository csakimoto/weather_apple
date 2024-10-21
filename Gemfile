source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'bootsnap', require: false
gem 'chartkick'
gem 'connection_pool', '~> 2.2'
gem 'faraday', '~> 2.12'
gem 'importmap-rails'
gem 'rails', '~> 7.0.8', '>= 7.0.8.4'
gem 'redis'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[ mingw mswin x64_mingw jruby ]


group :development, :test do
  gem 'debug', platforms: %i[ mri mingw x64_mingw ]
  gem 'rubocop', require: false
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'
end

group :test do
  gem 'mock_redis', '~> 0.45.0'
  gem 'rails-controller-testing'
  gem 'rspec-rails', '~> 3.0'
  gem 'webmock'
end


