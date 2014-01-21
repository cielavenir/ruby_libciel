# coding: utf-8
require './lib/libciel'

Gem::Specification.new do |spec|
  spec.name          = "libciel"
  spec.version       = LibCiel::VERSION
  spec.authors       = ["cielavenir"]
  spec.email         = ["cielartisan@gmail.com"]
  spec.description   = "ciel's useful libraries of Ruby"
  spec.summary       = "ciel's useful libraries of Ruby"
  spec.homepage      = "http://github.com/cielavenir/libciel"
  spec.license       = "Ruby License (2-clause BSDL or Artistic)"

  spec.files         = `git ls-files`.split($/) + [
    "LICENSE.txt",
    "README.md",
    "CHANGELOG.md",
  ]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})

  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 1.0"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
