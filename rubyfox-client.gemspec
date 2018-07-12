# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rubyfox/client/version'

Gem::Specification.new do |gem|
  gem.name          = "rubyfox-client"
  gem.version       = Rubyfox::Client::VERSION
  gem.platform      = Gem::Platform::JAVA
  gem.authors       = ["Peter Leitzen", "Jakob Holderbaum"]
  gem.email         = ["pl@neopoly.de", "jh@neopoly.de"]
  gem.description   = %q{Ruby bindings for SmartFox's client.}
  gem.summary       = %q{}
  gem.homepage      = "https://github.com/neopoly/rubyfox-client"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'activesupport'
  gem.add_dependency 'rubyfox-sfsobject', '>= 0.2.2'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rdoc'
end
