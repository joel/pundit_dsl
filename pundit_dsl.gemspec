require_relative 'lib/pundit_dsl/version'

Gem::Specification.new do |spec|
  spec.name          = 'pundit_dsl'
  spec.version       = PunditDsl::VERSION
  spec.authors       = ['Joel AZEMAR']
  spec.email         = ['joel.azemar@gmail.com']
  spec.summary       = %q{DSL for Pundit}
  spec.description   = %q{A litte DSL for Pundit}
  spec.homepage      = 'https://github.com/joel/pundit_dsl'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'pundit', '~> 0.3.0'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'

  spec.required_ruby_version = '~> 2.1'
end
