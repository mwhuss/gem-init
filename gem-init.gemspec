Gem::Specification.new do |s|
  s.name        = 'gem-init'
  s.version     = '0.1.2'
  s.authors     = ['Marshall Huss']
  s.email       = 'mwhuss@gmail.com'
  s.homepage    = 'http://github.com/mwhuss/gem-init'
  s.summary     = 'Rubygems plugin to assist in creating a barebones gem'
  s.description = 'Rubygems plugin to assist in creating a barebones gem'
  s.required_rubygems_version = '>= 1.3.6'
  s.add_dependency 'rest-client'
  s.files = [
    'lib/rubygems_plugin.rb', 
    'lib/rubygems/commands/init_command.rb'
  ]
  s.extra_rdoc_files = ['README.md', 'LICENSE']
  s.license = 'MIT'
end