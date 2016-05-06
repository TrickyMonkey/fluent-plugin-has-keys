# -*- encoding: utf-8 -*-
# -*- mode:ruby -*-

Gem::Specification.new do |gem|
  gem.authors       = ["Trickey"]
  gem.email         = ["cafegentle@gmail.com"]
  gem.description   = %q{Fluentd plugin to filter records without essential keys}
  gem.summary       = %q{Fluentd plugin to filter records without essential keys}
  gem.homepage      = "https://github.com/TrickyMonkey/fluent-plugin-has-keys"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "fluent-plugin-has-keys"
  gem.require_paths = ["lib"]
  gem.version       = "0.0.1"

  gem.add_runtime_dependency "fluentd", ">= 0.12.0"
  gem.add_development_dependency "rake", ">= 0.9.2"
end
