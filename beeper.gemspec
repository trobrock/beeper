# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'beeper/version'

Gem::Specification.new do |gem|
  gem.name          = "beeper"
  gem.version       = Beeper::VERSION
  gem.authors       = ["Trae Robrock"]
  gem.email         = ["trobrock@gmail.com"]
  gem.description   = %q{Simple api wrapper for PagerDuty}
  gem.summary       = %q{Simple api wrapper for PagerDuty}
  gem.homepage      = "https://github.com/trobrock/beeper"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "faraday", "~> 0.8.4"
  gem.add_dependency "faraday_middleware", "~> 0.9.0"
  gem.add_dependency "rash", "~> 0.3.2"
  gem.add_dependency "json", "~> 1.7", "> 1.7.5"

  gem.add_development_dependency "rake", "~> 10.0.2"
  gem.add_development_dependency "rspec", "~> 2.12.0"
  gem.add_development_dependency "mocha", "~> 0.13.1"
  gem.add_development_dependency "vcr", "~> 2.3.0"
  gem.add_development_dependency "webmock", "~> 1.8.0"
  gem.add_development_dependency "coveralls", "~> 0.6.3"
end
