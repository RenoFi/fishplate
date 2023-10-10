lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fishplate/version'

Gem::Specification.new do |spec|
  spec.name = 'fishplate'
  spec.version = Fishplate::VERSION
  spec.authors = ['Krzysztof Knapik']
  spec.email = ['knapo@knapo.net']

  spec.summary = 'Fishplate is a library allowing running ActiveRecord without Railties.'
  spec.homepage = 'https://github.com/RenoFi/fishplate'
  spec.license = 'MIT'

  spec.metadata['homepage_uri'] = 'https://github.com/RenoFi/fishplate'
  spec.metadata['source_code_uri'] = 'https://github.com/RenoFi/fishplate'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(bin/|spec/|\.rub)}) }
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 3.2'

  spec.add_dependency 'a9n', '~> 1.0'
  spec.add_dependency 'activemodel', '~> 7.1'
  spec.add_dependency 'activerecord', '~> 7.1'
  spec.add_dependency 'activesupport', '~> 7.1'
  spec.add_dependency 'rake', '~> 13'
  spec.add_dependency 'tzinfo-data'
end
