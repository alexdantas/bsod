
require 'bsod/version'

# Adding lib directory to load path
lib = File.expand_path('../lib', __FILE__)
$:.unshift lib unless $:.include? lib

desc "Builds the gem"
task :build do
  system 'gem build bsod.gemspec'
end

desc "Releases the gem into `rubygems.org`"
task :release => :build do
  system "gem push bsod-#{BSOD::VERSION}.gem"
end

desc "Executes the program"
task :run do |args, a|
  system "ruby -Ilib bin/bsod"
end

