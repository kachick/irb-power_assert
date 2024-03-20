source 'https://rubygems.org'

gemspec

group :development, :test do
  gem 'rake', '~> 13.1.0'

  # Avoid ruby default prettyprint gem even if same version
  # Keeping in gem path can be easily ignore warnings `literal string will be frozen in the future` in warning gem
  # https://github.com/ruby/ruby/blob/e5b585ba908d371c67d97988795a5e40ec2f9e93/lib/prettyprint.rb#L184
  gem 'prettyprint', '~> 0.2.0'
end

group :development do
  gem 'debug', '~> 1.9.1', require: false
  gem 'rubocop', '~> 1.62.1', require: false
  gem 'rubocop-rake', '~> 0.6.0', require: false
end

group :test do
  gem 'test-unit', '~> 3.6.2'
  gem 'warning', '~> 1.3.0'
end
