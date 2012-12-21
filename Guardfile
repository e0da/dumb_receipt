guard 'rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')                        { 'spec' }
  watch(%r[views/.*.yml.erb])                         { 'spec' }
  watch(%r[spec/(yaml_data_spec.rb|data_schema.yml)]) { 'spec/yaml_data_spec.rb' }
end

# vim: set ft=ruby:
