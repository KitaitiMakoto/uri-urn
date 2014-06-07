Gem::Specification.new do |spec|
  spec.name          = "uri-urn"
  spec.version       = '0.0.1'
  spec.authors       = ["KITAITI Makoto"]
  spec.email         = ["KitaitiMakoto@gmail.com"]
  spec.summary       = %q{TODO: Write a short summary. Required.}
  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = "Ruby"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
end
