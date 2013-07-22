# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "groundworkcss/version"

Gem::Specification.new do |s|
  s.name        = "groundworkcss"
  s.version     = Groundworkcss::VERSION
  s.authors     = ["ghepting", "BananaNeil", "nicknovitski", "ldewald"]
  s.email       = ["groundwork@sidereel.com"]
  s.homepage    = "http://groundworkcss.github.io"
  s.summary     = %q{Setup GroundworkCSS on your rails projects in seconds.}
  s.description = %q{The official GroundworkCSS rails gem. Created by @ghepting and @ldewald. GroundworkCSS is a fully responsive HTML5, CSS and Javascript toolkit created by @ghepting.}
  s.license = "MIT"

  s.rubyforge_project = "groundworkcss"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "compass-rails", "~> 1"
  s.add_runtime_dependency "railties", ">= 3.1.0", "< 5.0"
  s.add_runtime_dependency "jquery-rails", "~> 3"
end
