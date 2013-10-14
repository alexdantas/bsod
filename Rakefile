# Adding lib directory to load path
lib = File.expand_path('../lib', __FILE__)
$:.unshift lib unless $:.include? lib

require 'bsod/version'

task :build do
  system 'gem build bsod.gemspec'
end

task :release => :build do
  system "gem push bsod-#{BSOD::VERSION}.gem"
end

