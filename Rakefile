#!/usr/bin/env rake
require 'bundler/gem_tasks'

require 'rake/testtask'

begin
  require 'rubocop/rake_task'
rescue LoadError
  puts 'can not use rubocop in this environment'
else
  RuboCop::RakeTask.new
end


task default: [:test]

Rake::TestTask.new(:test) do |tt|
  tt.pattern = 'test/**/test_*.rb'
  tt.verbose = true
  tt.warning = true
end
