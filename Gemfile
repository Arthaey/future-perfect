ruby '2.3.3'

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'dotenv-rails', require: 'dotenv/rails-now'

gem 'rails', '~> 5.1.2'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'

gem 'font-awesome-sass', '~> 4.7.0'

group :production do
  gem 'pg', '~> 0.18'
  gem 'uglifier', '>= 1.3.0'
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara'
  gem 'simplecov', require: false
  gem 'coveralls', require: false
  gem 'jasmine', '~> 2.8'
  gem 'rspec-rails', '~> 3.6'
  gem 'rails-controller-testing'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0' # <%= console %>
  gem 'pry'
end

group :test do
  gem 'activerecord-nulldb-adapter'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
#gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
