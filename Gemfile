source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem "rails", "~> 7.0.4"

gem "bcrypt", "~> 3.1"
gem "dry-validation", "~> 1.8"
gem "jsonapi-serializer", "~> 2.2"
gem "oj", "~> 3.13"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "rack-requestid", "~> 0.2"
gem "rack-timeout", "~> 0.6", require: "rack/timeout/base" # set a custom timeout in the middleware
gem "rswag-api", "~> 2.5"
gem "rswag-ui", "~> 2.5"

# gem "rack-cors" # Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible

group :development do
  # tbd
end

group :development, :test do
  gem "amazing_print", "~> 1.4"
  gem "bundler-audit", "~> 0.9"
  gem "factory_bot_rails", "~> 6.2"
  gem "faker", "~> 2.19"
  gem "rspec-rails", "~> 5.1"
  gem "rswag-specs", "~> 2.5"
end

group :test do
  gem "webmock", "~> 3.14"
end
