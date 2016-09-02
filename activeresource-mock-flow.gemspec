# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name = 'activeresource-httpmock-flow'
  spec.version = '0.1.0'
  spec.authors = ['Travis Haynes']
  spec.email = ['travis@hi5dev.com']

  spec.summary = 'Adds multi-stage requests to ActiveResource::HttpMock'
  spec.homepage = 'https://github.com/hi5dev/activeresource-httpmock-flow'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = %w[lib]

  spec.add_dependency 'activeresource'

  spec.add_development_dependency 'activesupport'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'rake'
end
