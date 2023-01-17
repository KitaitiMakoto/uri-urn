Gem::Specification.new do |spec|
  spec.name          = "uri-urn"
  spec.version       = '0.0.3'
  spec.authors       = ["KITAITI Makoto"]
  spec.email         = ["KitaitiMakoto@gmail.com"]
  spec.summary       = %q{Adds URN Scheme support to URI lib.}
  spec.description   = %q{This library adds URN scheme support for standard bundled URI library described in RFC 4122.}
  spec.homepage      = 'https://gitorious.org/uri-ext'
  spec.license       = "Ruby"

  spec.test_files    = Dir.glob('test/**/test_*.rb')
  spec.require_paths = ["lib"]
  spec.extra_rdoc_files = %w[README.markdown CHANGELOG.markdown COPYING BSDL]
  spec.files = spec.require_paths.inject([]) {|files, dir|
                 files + Dir.glob("#{dir}/**/*.rb")
               } +
               spec.test_files +
               spec.extra_rdoc_files +
               %w[uri-urn.gemspec Rakefile]

  spec.add_development_dependency 'rubygems-tasks'
end
