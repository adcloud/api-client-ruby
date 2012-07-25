# -*- encoding: utf-8 -*-
require File.expand_path('../lib/adcloud/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jan Kus", "Max Schulz"]
  gem.email         = ["jan@railslove.com"]
  gem.summary = %Q{Adcloud API SDK}
  gem.description = %Q{This is the official Adcloud API SDK. If you have any problems or requests please contact api@adcloud.com.}
  gem.homepage      = "http://github.com/koos/adcloud_sdk"
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "adcloud"
  gem.require_paths = ["lib"]
  gem.version       = Adcloud::VERSION
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'minitest_should'
  gem.add_development_dependency 'minitest-reporters'
  gem.add_development_dependency 'webmock'
  gem.add_development_dependency 'mocha'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'debugger'

  gem.add_dependency 'virtus'    
  gem.add_dependency 'json'
  gem.add_dependency 'activesupport', "~>3.1.0"
  gem.add_dependency 'faraday'
end
