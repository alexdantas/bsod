# Adding ./lib directory to load path
lib = File.expand_path('../lib', __FILE__)
$:.unshift lib unless $:.include? lib

require 'bsod/version'
require 'date'

Gem::Specification.new do |s|
  s.name        = 'bsod'
  s.version     = BSOD::VERSION
  s.summary     = "Simulates a Blue Screen Of Death"
  s.date        = "#{Date.today.year}-#{Date.today.month}-#{Date.today.day}"
  s.description = <<END_OF_DESCRIPTION
Simulates a Blue Screen Of Death, as seen on Micro$oftWindow$.
As an executable, has optional flag to sleep before BSODing so you can surprise your friends!
As a library, you can integrate a BSOD on any SDL surface.
END_OF_DESCRIPTION
  s.authors     = ["Alexandre Dantas"]
  s.email       = ["eu@alexdantas.net"]
  s.homepage    = 'http://www.alexdantas.net/projects/bsod'
  s.license     = "GPL-3.0"

  # Including everything that's checked out on git
  s.files       = `git ls-files`.split($/)
  s.executables = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.metadata = { 'github' => 'http://www.github.com/alexdantas/bsod' }

  s.add_development_dependency "rake"
end

