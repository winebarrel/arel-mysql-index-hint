# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'arel-mysql-index-hint/version'

Gem::Specification.new do |spec|
  spec.name          = "arel-mysql-index-hint"
  spec.version       = ArelMysqlIndexHint::VERSION
  spec.authors       = ["Genki Sugawara"]
  spec.email         = ["sgwr_dts@yahoo.co.jp"]
  spec.summary       = %q{Add index hint to MySQL query in Arel.}
  spec.description   = %q{Add index hint to MySQL query in Arel.}
  spec.homepage      = "https://github.com/winebarrel/arel-mysql-index-hint"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord", ">= 4.0.0"
  spec.add_dependency "arel", ">= 4.0.0"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "mysql2"
  spec.add_development_dependency "rspec", ">= 3.0.0"
  spec.add_development_dependency "factory_girl"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "appraisal"
end
