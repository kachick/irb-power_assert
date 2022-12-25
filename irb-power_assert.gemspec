# coding: us-ascii
# frozen_string_literal: true

lib_name = 'irb-power_assert'

require_relative './lib/irb/power_assert/version'
repository_url = "https://github.com/kachick/#{lib_name}"

Gem::Specification.new do |gem|
  gem.summary       = %q{power_assert in irb}
  gem.description   = gem.summary
  gem.homepage      = repository_url
  gem.license       = 'MIT'
  gem.name          = lib_name
  gem.version       = IRB::PowerAssert::VERSION

  gem.metadata = {
    'documentation_uri'     => 'https://kachick.github.io/irb-power_assert/',
    'homepage_uri'          => repository_url,
    'source_code_uri'       => repository_url,
    'bug_tracker_uri'       => "#{repository_url}/issues",
    'rubygems_mfa_required' => 'true',
  }

  gem.add_runtime_dependency 'irb', '>= 1.4.1', '< 2.0'
  gem.add_runtime_dependency 'power_assert', '>= 2.0.1', '< 3.0'

  gem.required_ruby_version = '>= 2.7'

  # common

  gem.authors       = ['Kenichi Kamiya']
  gem.email         = ['kachick1+ruby@gmail.com']
  might_be_parsing_by_tool_as_dependabot = `git ls-files`.lines.empty?
  files = Dir['README*', '*LICENSE*',  'lib/**/*', 'sig/**/*'].uniq
  if !might_be_parsing_by_tool_as_dependabot && files.grep(%r!\A(?:lib|sig)/!).size < 4
    raise "obvious mistaken in packaging files: #{files.inspect}"
  end
  gem.files         = files
  gem.require_paths = ['lib']
end
