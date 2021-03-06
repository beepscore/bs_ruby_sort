# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bs_ruby_sort/version'

Gem::Specification.new do |spec|
  spec.name          = "bs_ruby_sort"
  spec.version       = BsRubySort::VERSION
  spec.authors       = ["Beepscore LLC"]
  spec.email         = ["support@beepscore.com"]
  spec.description   = %q{Sorts using merge sort.}
  spec.summary       = %q{Sorts using merge sort.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest", "~>5.0"

  # Only with ruby 2.0.x
  # Reference
  # http://guides.rubygems.org/specification-reference/
  spec.required_ruby_version = '~> 2.0'

end
