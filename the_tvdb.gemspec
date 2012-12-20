# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'the_tvdb/version'

Gem::Specification.new do |gem|
  gem.name          = "the_tvdb"
  gem.version       = TheTvdb::VERSION
  gem.authors       = ["Alessandro Mencarini"]
  gem.email         = ["a.mencarini@freegoweb.it"]
  gem.description   = %q{A TheTVDB API wrapper}
  gem.summary       = %q{Allows to simplify the usage of TheTVDB API, making more RESTful oriented calls}
  gem.homepage      = "http://freego.github.com/the_tvdb"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  
  #gem.add_dependency("httparty")
  gem.add_dependency("nokogiri")
  gem.add_dependency("rubyzip")
  gem.add_dependency("activesupport")

end
