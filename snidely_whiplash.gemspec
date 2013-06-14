# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'snidely_whiplash/version'

Gem::Specification.new do |gem|
  gem.name          = "snidely_whiplash"
  gem.version       = SnidelyWhiplash::VERSION
  gem.authors       = ["Bob Matcuk"]
  gem.email         = ["snidelywhiplash@squeg.net"]
  gem.description   = %q{Convert simple partial views into a mustache template.}
  gem.summary       = %q{Convert simple partial views into a mustache template.}
  gem.homepage      = "https://github.com/bmatcuk/snidely_whiplash"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_development_dependency('rspec-core')
  gem.add_development_dependency('rspec-expectations')
end
