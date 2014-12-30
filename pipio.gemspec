# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "pipio/version"

Gem::Specification.new do |spec|
  spec.name          = "pipio"
  spec.version       = Pipio::VERSION
  spec.authors       = ["Gabe Berke-Williams"]
  spec.email         = "gabebw@gabebw.com"
  spec.description   = "A fast, easy way to parse Pidgin (gaim) logs"
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/gabebw/pipio"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.require_paths = ["lib"]

  spec.required_ruby_version = Gem::Requirement.new(">= 2.0.0")

  spec.add_dependency("activesupport")

  spec.add_development_dependency("mocha")
  spec.add_development_dependency("rake")
  spec.add_development_dependency("rspec", "~> 3.0")
  spec.add_development_dependency("simplecov")
  spec.add_development_dependency("tzinfo")
end
