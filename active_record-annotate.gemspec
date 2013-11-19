# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_record/annotate/version'

Gem::Specification.new do |spec|
  spec.name          = 'active_record-annotate'
  spec.version       = ActiveRecord::Annotate::VERSION
  spec.authors       = ['Vsevolod Romashov']
  spec.email         = ['7@7vn.ru']
  spec.summary       = %q{ActiveRecord models annotator based on rails' schema dumper}
  spec.description   = %q{Adds a rake task which prepends each model file with an excerpt about the corresponding table from db/schema.rb}
  spec.homepage      = 'https://github.com/7even/active_record-annotate'
  spec.license       = 'MIT'
  
  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.require_paths = ['lib']
  
  spec.add_runtime_dependency 'rails', '>= 3.2'
  
  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'awesome_print'
end
