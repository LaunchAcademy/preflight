$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'preflight/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'preflight'
  s.version     = Preflight::VERSION
  s.authors     = ['Dan Pickett']
  s.email       = ['dan.pickett@launchacademy.com']
  s.homepage    = 'http://www.launchacademy.com'
  s.summary     = 'An application for prelaunching'
  s.description = 'An application for prelaunching exciting things'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['spec/**/*_spec.rb']

  s.add_dependency 'rails', '~> 4.2.0beta1'
  s.add_dependency 'omniauth-crew-check'
  s.add_dependency 'warden'
  s.add_dependency 'better_date_picker'
  s.add_dependency 'slugged'
  s.add_dependency 'simple_form'
  s.add_dependency 'responders'
  s.add_dependency 'kaminari'

  s.add_development_dependency 'pg'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'mocha'
  s.add_development_dependency 'factory_girl'
  s.add_development_dependency 'dotenv-rails'
  s.add_development_dependency 'valid_attribute'
  s.add_development_dependency 'shoulda-matchers'
end
