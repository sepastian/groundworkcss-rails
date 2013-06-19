# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "groundworkcss/version"

Gem::Specification.new do |s|
  s.name        = "groundworkcss"
  s.version     = GroundworkCSS::VERSION
  s.authors     = ["ghepting", "BananaNeil", "nicknovitski", "ldewald"]
  s.email       = ["groundwork@sidereel.com"]
  s.homepage    = "http://groundwork.sidereel.com"
  s.summary     = %q{Setup GroundworkCSS on your rails projects in seconds.}
  s.description = %q{GroundworkCSS is a fully responsive HTML5, CSS and Javascript toolkit created by @ghepting.}

  s.rubyforge_project = "groundworkcss"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
  s.add_runtime_dependency "railties", ">= 3.1.0", "< 4.0"
  s.add_runtime_dependency "compass-rails"
  s.add_runtime_dependency "jquery-rails", "~> 1"
end
