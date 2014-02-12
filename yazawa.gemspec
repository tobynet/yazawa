# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yazawa/version'

Gem::Specification.new do |spec|
  spec.name          = "yazawa"
  spec.version       = YAZAWA::VERSION
  spec.authors       = ["toooooooby"]
  spec.email         = ["toby.net.info.mail+git@gmail.com"]
  spec.summary       = %q{『YAZAWA』 is one of text-converter, like Yazawa}
  spec.description   = %q{$ yazawa '俺達の熱意で世界が変わる'\n俺達の『NETSUI』で世界が変わる}
  spec.homepage      = "https://github.com/toooooooby/yazawa"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'mecab-light', '~> 0.2'
  spec.add_dependency 'mojinizer', '~> 0.2'

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "coveralls"
end
