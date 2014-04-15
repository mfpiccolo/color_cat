# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'color_cat/version'

Gem::Specification.new do |spec|
  spec.name          = "color_cat"
  spec.version       = ColorCat::VERSION
  spec.authors       = ["Mike Piccolo"]
  spec.email         = ["mpiccolo@newleaders.com"]
  spec.summary       = %q{Categorize images by dominant color}
  spec.description   = %q{Takes a url to an external image gives dominant color name and category}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rmagick",                "~> 2.13"

  spec.add_development_dependency "bundler",            "~> 1"
  spec.add_development_dependency "rake",               "~> 10"
  spec.add_development_dependency "vcr",                ">= 2.8"
  spec.add_development_dependency "minitest",           ">= 4.7.5"
  spec.add_development_dependency "minitest-vcr",       "~> 0.1"
  spec.add_development_dependency "mocha",              "~> 0.14"
  spec.add_development_dependency "faraday",            "~> 0.8"
  spec.add_development_dependency "webmock",            "~> 1.16"
  spec.add_development_dependency "rubygems-tasks",     "~> 0.2"
  spec.add_development_dependency "pry",                "~> 0.9"
  spec.add_development_dependency "pry-debugger",       "~> 0.2"
end
