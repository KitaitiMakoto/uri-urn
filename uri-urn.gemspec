Gem::Specification.new do |spec|
  spec.name          = "uri-urn"
  spec.version       = '0.0.1'
  spec.authors       = ["KITAITI Makoto"]
  spec.email         = ["KitaitiMakoto@gmail.com"]
  spec.summary       = %q{TODO: Write a short summary. Required.}
  spec.description   = %q{TODO: Write a longer description. Optional.}
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
