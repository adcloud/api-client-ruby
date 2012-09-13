# -*- encoding: utf-8 -*-
require File.expand_path('../lib/adcloud/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Jan Kus', 'Max Schulz']
  gem.email         = ['jan@railslove.com', 'm.schulz@kulturfluss.de']
  gem.summary       = %Q{Wrapper for adcloud API}
  gem.description   = %Q{This is the official adcloud API gem. If you have any problems or requests please contact api@adcloud.com.}
  gem.homepage      = 'http://adcloud.com/'
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = 'adcloud'
  gem.require_paths = ['lib']
  gem.version       = Adcloud::VERSION

  gem.add_development_dependency 'minitest', '~> 3.4.0'
  gem.add_development_dependency 'mocha', '~> 0.12.4'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'webmock'

  gem.add_dependency 'virtus'
  gem.add_dependency 'activesupport', "~>3.2.6"
  gem.add_dependency 'faraday'
  gem.add_dependency 'faraday_middleware'
end
