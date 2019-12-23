lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fishplate/version'

Gem::Specification.new do |spec|
  spec.name     = 'fishplate'
  spec.version  = Fishplate::VERSION
  spec.authors  = ['Krzysztof Knapik']
  spec.email    = ['knapo@knapo.net']

  spec.summary  = 'Fishplate is a library allowing running ActiveRecord without Railties.'
  spec.homepage = 'https://github.com/RenoFi/fishplate'
  spec.license  = 'MIT'

  spec.metadata['homepage_uri'] = 'https://github.com/RenoFi/fishplate'
  spec.metadata['source_code_uri'] = 'https://github.com/RenoFi/fishplate'

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(bin/|spec/|\.rub)}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.6'

  spec.add_dependency 'a9n', '~> 1.0'
  spec.add_dependency 'activemodel', '~> 6.0'
  spec.add_dependency 'activerecord', '~> 6.0'
  spec.add_dependency 'activesupport', '~> 6.0'
  spec.add_dependency 'rake', '~> 13.0'
  spec.add_dependency 'tzinfo-data'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-performance'
end
