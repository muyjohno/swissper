# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'swissper/version'

Gem::Specification.new do |spec|
  spec.name          = "swissper"
  spec.version       = Swissper::VERSION
  spec.authors       = ["John O'Brien"]
  spec.email         = ["strayjohno@gmail.com"]

  spec.summary       = "A Ruby gem for pairing Swiss tournaments"
  spec.description   = "This gem allows you to create Swiss pairings for all kinds of tournaments"
  spec.homepage      = "https://github.com/muyjohno/swissper"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "graph_matching", "~> 0.0"

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0.10"
end
