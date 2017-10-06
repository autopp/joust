source 'https://rubygems.org'

ruby '~> 2.4.2'

gem 'rake'
gem 'hanami',       '~> 1.0'
gem 'hanami-model', '~> 1.0'

gem 'sqlite3'

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/projects/code-reloading
  gem 'shotgun'
  gem 'pry'
end

group :test, :development do
  gem 'dotenv', '~> 2.0'
end

group :test do
  gem 'rspec', '~> 3.6.0'
  gem 'capybara'
end

group :production do
  # gem 'puma'
end
