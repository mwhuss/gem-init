Gem::Specification.new do |s|
  s.name        = "gem-init"
  # s.version     = GemGrep::VERSION
  s.version     = '0.0.1'
  s.authors     = ["Marshall Huss"]
  s.email       = "mwhuss@gmail.com"
  s.homepage    = "http://github.com/mwhuss/git-init"
  s.summary     = "summary"
  s.description = 'description'
  s.required_rubygems_version = ">= 1.3.6"
  s.add_dependency 'rest-client'
  s.files = [
      'lib/rubygems_plugin.rb', 
      'lib/rubygems/commands/init_command.rb']
  # s.extra_rdoc_files = ["README.rdoc", "LICENSE.txt"]
  s.license = 'MIT'
end