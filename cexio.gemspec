# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cexio/version'

Gem::Specification.new do |spec|
  spec.name          = "cexio"
  spec.version       = Cexio::VERSION
  spec.authors       = ["t0pep0"]
  spec.email         = ["t0pep0.gentoo@gmail.com"]
  spec.description   = "Gem for acsess to api cex.io"
  spec.summary       = "Cex.io api library"
  spec.homepage      = "https://github.com/t0pep0/cex.io-api-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "redcarpet"
  spec.add_development_dependency "yard"
end
