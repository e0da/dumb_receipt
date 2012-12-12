# vim: set ft=ruby:

guard 'rspec' do
  # watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }
  watch('lib/dumb_receipt/views/data.yml')  { "spec" }
end
