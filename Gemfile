source 'https://rubygems.org'

gemspec

group :development, :test do
  gem 'rake', '~> 13.3.0'
end

group :development do
  # Don't relax rubocop family versions with `~> the_version`, rubocop often introduce breaking changes in patch versions. See ruby-ulid#722
  gem 'rubocop', '1.81.6', require: false
  gem 'rubocop-rake', '0.7.1', require: false
end

group :test do
  gem 'test-unit', '~> 3.7.0'
  gem 'test-unit-ruby-core', '~> 1.0'
  gem 'warning', '~> 1.5.0'

  gem 'irb', '1.15.2'
  gem 'power_assert', '2.0.5'
end
