# -*- encoding: utf-8 -*-
require File.expand_path("../lib/screenomat/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "screenomat"
  s.version     = Screenomat::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = []
  s.email       = []
  s.homepage    = "http://johnbintz.com/"
  s.summary     = "DSL for making GNU screen obey your will"
  s.description = "DSL for making GNU screen obey your will"

  s.required_rubygems_version = ">= 1.3.6"

  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "rspec"
  s.add_development_dependency "mocha"
  s.add_development_dependency "autotest"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
