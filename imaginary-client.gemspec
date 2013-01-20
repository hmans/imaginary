# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'imaginary/version'

Gem::Specification.new do |gem|
  gem.name          = "imaginary"
  gem.version       = Imaginary::VERSION
  gem.authors       = ["Hendrik Mans"]
  gem.email         = ["hendrik@mans.de"]
  gem.description   = %q{Client gem for Imaginary.}
  gem.summary       = %q{Client gem for Imaginary.}
  gem.homepage      = "https://github.com/hmans/imaginary"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'httmultiparty', '>= 0.3.8'
  gem.add_dependency 'httparty', '>= 0.10.0'

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'fakeweb'
end
