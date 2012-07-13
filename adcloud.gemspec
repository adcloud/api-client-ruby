# -*- encoding: utf-8 -*-
require File.expand_path('../lib/adcloud/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jan Kus"]
  gem.email         = ["jan@railslove.com"]
  gem.description   = %q{official adcloud gem}
  gem.summary       = %q{official adcloud gem}
  gem.homepage      = ""

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

  gem.add_dependency 'json'
  gem.add_dependency 'active_support'
end
