# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lockerz/version'

Gem::Specification.new do |spec|
  spec.name          = "lockerz"
  spec.version       = Lockerz::VERSION
  spec.authors       = ["Karmen Blake"]
  spec.email         = ["karmenblake@gmail.com"]
  spec.summary       = %q{Locker reservation system}
  spec.description   = %q{Locker reservation system. Hotels can manage user lockers and reservations using a confirmation ticket system.}
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest-reporters", "~> 1.0"
  spec.add_development_dependency "yard", "~> 0.8.7"
  spec.add_development_dependency "highline", "~> 1.6"
end
