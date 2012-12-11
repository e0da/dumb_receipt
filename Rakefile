#!/usr/bin/env rake
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)
task :default => :spec

desc 'Deploy production application to Heroku'
task :deploy do
  `git push heroku master`
end
