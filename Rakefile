#!/usr/bin/env rake
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)
task :default => :spec

desc 'Deploy production application to Heroku'
task :deploy do
  `git push heroku master`
end

desc 'Try to open the README page in a browser'
task :browse do
  `open #{url} || gnome-open #{url}`
end

private

def url
  @url ||= "http://localhost:#{port}/"
end

def port
  @port ||= `netstat -lnt | grep -oE '3000|9292|9393'`.chomp
end
