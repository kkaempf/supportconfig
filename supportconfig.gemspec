# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "supportconfig/version"

Gem::Specification.new do |s|
  s.name        = "supportconfig"
  s.version     = Supportconfig::VERSION
  s.authors     = ["Klaus Kämpf"]
  s.email       = ["kkaempf@suse.de"]
  s.homepage    = "http://github.com/kkaempf/supportconfig"
  s.summary     = %q{Library to access SUSE supportconfig data}
  s.description = %q{Library to access SUSE supportconfig data}

  s.add_dependency("highline", ["~> 1.7.8"])

  s.rubyforge_project = "supportconfig"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
