# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mongoid_sessions/version'

Gem::Specification.new do |spec|
  spec.name          = "mongoid_sessions"
  spec.version       = MongoidSessions::VERSION
  spec.authors       = ["Bantik"]
  spec.email         = ["corey@idolhands.com"]
  spec.description   = %q{Mongoid alternative to ActiveRecord::SessionStore.}
  spec.summary       = %q{Mongoid alternative to ActiveRecord::SessionStore}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "mongo"
  spec.add_dependency "mongoid"
  spec.add_dependency "bson_ext"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
