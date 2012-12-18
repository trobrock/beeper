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

  gem.add_development_dependency "rake"
end
