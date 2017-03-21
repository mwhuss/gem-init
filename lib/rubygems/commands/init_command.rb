require 'rest-client'

class Gem::Commands::InitCommand < Gem::Command
  
  def initialize
    super 'init', 'Create the barebones of a rubygem'
    
    add_option('-s', '--skip-check', 'Skip check to see if gem already exists') do |value, options|
      options[:skip_check] = true
    end
          
  end
  
  def description # :nodoc:
    'Rubygems plugin to assist in creating a barebones gem'
  end
  
  def arguments # :nodoc:
    "GEMNAME          name of your new rubygem"
  end

  def usage # :nodoc:
    "#{program_name} GEMNAME"
  end
  
  def execute
    gem_name = get_new_gem_name
    
    gem_exists = options[:skip_check].nil? ? gem_exists?(gem_name) : false

    if gem_exists
      say "The #{gem_name} gem already exists on rubygems.org!\n\nChoose a new name or use the -s option to skip the check"
    else
      create_gemspec(gem_name)
      create_ruby_file(gem_name)
      create_rakefile
    end
  end
  
  def gem_exists?(gem_name)
    response = RestClient.get("https://rubygems.org/api/v1/gems/#{gem_name}.json") do |response, request, result|
      return response.code != 404
    end
  end
  
  def create_gemspec(gem_name)
    File.open("#{gem_name}.gemspec", 'w+') do |f|
      f.puts <<-GEMSPEC
Gem::Specification.new do |s|
  s.name        = "#{gem_name}"
  s.version     = '0.1.0'
  s.authors     = ["YOURNAME"]
  s.email       = "TODO YOUREMAIL"
  s.homepage    = "TODO HOMEPAGE"
  s.summary     = "TODO SUMMARY"
  s.description = "TODO DESCRIPTION"
  s.required_rubygems_version = ">= 1.3.6"
  s.files = ["lib/#{gem_name}.rb"]
  # s.add_dependency 'some-gem'
  # s.extra_rdoc_files = ['README.md', 'LICENSE']
  # s.license = 'MIT'
end
      GEMSPEC
    end
  end
  
  def create_ruby_file(gem_name)
    Dir.mkdir("lib")
    File.open("lib/#{gem_name}.rb", 'w+') do |f|
      f.puts <<-FILE
class #{gem_name.capitalize}
end
      FILE
    end
  end
  
  def create_rakefile
    Dir.mkdir("test")
    File.open("Rakefile", 'w+') do |f|
      f.puts <<-RAKEFILE
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test'
end

desc "Run tests"
task :default => :test
      RAKEFILE
    end
  end
  
  # Taken from RubyGems get_one_gem_name
  def get_new_gem_name
    args = options[:args]
    if args.nil? or args.empty?
      fail Gem::CommandLineError,
        "Please specify a gem name on the command line (e.g. gem init GEMNAME)"
    end
    if args.size > 1
      fail Gem::CommandLineError,
        "Too many gem names (#{args.join(', ')}); please specify only one"
    end
    args.first
  end
  
end