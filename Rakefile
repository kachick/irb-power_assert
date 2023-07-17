# frozen_string_literal: true

require 'bundler/gem_tasks'

require 'rake/testtask'

begin
  require 'rubocop/rake_task'
rescue LoadError
  puts 'can not use rubocop in this environment'
else
  RuboCop::RakeTask.new
end

task default: [:test_behaviors]

task test_behaviors: [:test]

desc 'Simulate CI results in local machine as possible'
multitask simulate_ci: [:test_behaviors, :rubocop]

Rake::TestTask.new(:test) do |tt|
  tt.pattern = 'test/**/test_*.rb'
  tt.warning = true
end

desc 'Prevent miss packaging!'
task :view_packaging_files do
  sh 'rm -rf ./pkg'
  sh 'rake build'
  cd 'pkg' do
    sh 'gem unpack *.gem'
    sh 'tree -I *\.gem'
  end
  sh 'rm -rf ./pkg'
end

desc 'Print dependencies'
task :deps do
  sh('ruby --version')
  sh('dprint --version')
  sh('tree --version')
  sh('typos --version')
end

desc 'Linters except ruby'
task :linters do
  sh('dprint check')
  sh('typos . .github .vscode')
  sh('nixpkgs-fmt --check ./*.nix')
end
