source 'https://rubygems.org'

gem 'rake'
gem 'hanami',       '~> 1.3'
gem 'hanami-model', '~> 1.3'

gem 'sqlite3'

gem 'hanami-bootstrap', '~> 0.4.0'
gem 'sass'

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/projects/code-reloading
  gem 'shotgun'
  gem 'pry'
  gem 'rubocop'
end

group :test, :development do
  gem 'dotenv', '~> 2.0'
end

group :test do
  gem 'rspec', '~> 3.6.0'
  gem 'rspec-html-matchers'
  gem 'capybara'
  gem 'rspec_junit_formatter'
  gem 'database_cleaner'
end

group :production do
  # gem 'puma'
  gem 'mysql2'
end
