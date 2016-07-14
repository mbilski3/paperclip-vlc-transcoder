# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'paperclip/vlc/transcoder/version'

Gem::Specification.new do |spec|
  spec.name          = 'paperclip-vlc-transcoder'
  spec.version       = Paperclip::Vlc::Transcoder::VERSION
  spec.authors       = ['Mateusz Bilski']
  spec.email         = ['mbilski3@gmail.com']
  spec.summary       = %q{Audio/Video Transcoder for Paperclip using VLC}
  spec.description   = %q{Audio/Video Transcoder for Paperclip using VLC}
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rails', '>= 4.0.0'

  spec.add_dependency 'paperclip', '>=2.5.2'
end
