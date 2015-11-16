# Encoding: UTF-8

Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-multisites'
  s.version           = '1.0'
  s.description       = %q{Apartment based multisites extension for Refinery CMS}
  s.date              = '2015-11-14'
  s.summary           = %q{An Apartment based multisites extension for Refinery CMS}
  s.homepage          = %q{http://www.brice-sanchez.com}
  s.authors           = ['Brice Sanchez']
  s.license           = %q{MIT}
  s.require_paths     = %w(lib)

  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files -- spec/*`.split("\n")

  # Runtime dependencies
  s.add_dependency 'refinerycms-core', '~> 3.0.0'
  s.add_dependency 'refinerycms-authentication-devise', '~> 1.0.4'
  s.add_dependency 'acts_as_indexed', '~> 0.8.0'
  s.add_dependency 'apartment', '~> 1.0.2'

  # Development dependencies (usually used for testing)
  s.add_development_dependency 'refinerycms-testing', '~> 3.0.0'

  s.required_ruby_version = '>= 2.0.0'
end