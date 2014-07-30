lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'uri/urn/version'

Gem::Specification.new do |spec|
  spec.name          = "uri-urn"
  spec.version       = URI::URN::VERSION
  spec.authors       = ["KITAITI Makoto", "Matthew Johnston"]
  spec.email         = ["KitaitiMakoto@gmail.com", "warmwaffles@gmail.com"]
  spec.summary       = %q{Adds URN Scheme support to URI lib.}
  spec.description   = %q{This library adds URN scheme support for standard bundled URI library described in RFC 4122.}
  spec.homepage      = 'https://gitorious.org/uri-ext'
  spec.license       = "BSD"

  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.extra_rdoc_files = %w[README.markdown CHANGELOG.markdown COPYING LICENSE]
  spec.files         = `git ls-files`.split($/)

  spec.add_development_dependency 'rubygems-tasks'
end
