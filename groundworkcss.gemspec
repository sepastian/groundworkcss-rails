# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "groundworkcss/version"

Gem::Specification.new do |gw|
  gw.name           = "groundworkcss"
  gw.version        = Groundworkcss::VERSION
  gw.authors        = ["ghepting", "ldewald"]
  gw.email          = ["groundwork@sidereel.com"]
  gw.homepage       = "http://groundworkcss.github.io"
  gw.summary        = %q{Setup GroundworkCSS on your rails projects in seconds.}
  gw.description    = %q{The official GroundworkCSS rails gem. Created by @ghepting and @ldewald. GroundworkCSS is a fully responsive HTML5, CSS and Javascript toolkit created by @ghepting. Note: If your app is still using GroundworkCSS 1.13.1, specify version "~0.4.3" of the `groundworkcss` gem in your Gemfile!}
  gw.license        = "MIT"

  gw.rubyforge_project = "groundworkcss"

  gw.files          = `git ls-files`.split("\n")
  gw.test_files     = `git ls-files -- {test,spec,features}/*`.split("\n")
  gw.executables    = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gw.require_paths  = ["lib"]

  gw.add_dependency "colorize"
  gw.add_dependency "sass-rails", [">= 3.2.3"]
  gw.add_dependency "coffee-rails", [">= 3.2.1"]
  gw.add_dependency "compass-rails", ["~> 1"]
  gw.add_dependency "autoprefixer-rails"
  gw.add_dependency "jquery-rails"
  gw.add_development_dependency "rake"
  gw.add_development_dependency "rspec"
  gw.add_development_dependency "jasmine"
end
