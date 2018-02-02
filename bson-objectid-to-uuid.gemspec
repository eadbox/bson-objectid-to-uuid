# frozen_string_literal: true

require_relative 'lib/bson/object_id/uuid_convertable/version'

Gem::Specification.new do |spec|
  spec.name          = 'bson-objectid-to-uuid'
  spec.version       = BSON::ObjectId::UUIDConvertable::VERSION
  spec.authors       = ['Rafael Gaspar']
  spec.email         = ['rafael.gaspar@me.com']

  spec.summary       = "Converts BSON::ObjectId to and from UUIDv1's."
  spec.description   = "Converts BSON::ObjectId to and from UUIDv1's."
  spec.homepage      = 'https://github.com/eadbox/bson-objectid-to-uuid'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'bson', '~> 4.0'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rubocop', '~> 0.52'
  spec.add_development_dependency 'simple_uuid', '>= 0.4'
end
