
require 'optparse'
require 'bsod/version'

# Global configurations of the program, along with a commandline
# argument parser.
#
# Contains the program's specific configuration rules.
class Settings

  # Creates a configuration, with default values.
  def initialize
    @settings = {}

    # Makes possible to sleep for a while before BSODing
    @settings[:sleep_time] = nil

    # Which BSOD we'll show by default?
    @settings[:bsod_type] = "windowsnt"

    # This doesn't matter because it will go fullscreen anyways.
    # Just change it if looks ugly
    @settings[:width]  = 800
    @settings[:height] = 600
    @settings[:fullscreen] = true

    # SDL-specific key to exit BSOD
    @settings[:exit_key] = SDL::Key::F8

    # This is the default font, distributed with the gem.
    # It's `../../fonts/droidsansmono.ttf` based on `settings.rb` path.
    fontname = File.expand_path("../../", __FILE__)
    fontname = File.dirname fontname
    fontname += "/fonts/droidsansmono.ttf"
    @settings[:font_filename] = fontname
    @settings[:font_size] = 14
    @settings[:font_bold] = false
  end

  # Sets options based on commandline arguments `args`.
  # It should be `ARGV`.
  def parse args

    opts = OptionParser.new do |parser|
      parser.banner = "Usage: bsod [options]"

      # Make output beautiful
      parser.separator ""
      parser.separator "Note: Default key to exit BSOD is `F8`"
      parser.separator ""
      parser.separator "Options:"

      parser.on("-w", "--wait N", "Waits N (float) seconds before BSODing") do |n|
        @settings[:sleep_time] = n.to_f
      end

      parser.on("-s", "--style STYLE", "Select the BSOD style to show. To see all options use `--list`. ") do |type|
        @settings[:bsod_type] = type.to_s
      end

      parser.on("--[no-]fullscreen", "Runs on fullscreen mode (default on)") do |f|
        @settings[:fullscreen] = f
      end

      # parser.on("-r", "--random", "Select a random BSOD") do
      # DO SOMETHING ABOUT IT
      # end

      parser.on("-l", "--list", "Show all possible BSODs") do
        puts "Usage: bsod -t [type]"
        puts "       where [type] can be:"
        puts
        puts "windowsnt [default]"
        puts "windows2000"
        puts "windowsxp"
        puts "linux-sparc"
        exit
      end

      # These options appear if no other is given.
      parser.on("-h", "--help", "Show this message") do
        puts parser
        exit
      end

      parser.on("--version", "Show version and license info") do
        puts <<END_OF_VERSION
 _   __  _   _
|_) (_  / \\ | \\
|_) __) \\_/ |_/ #{BSOD::VERSION}  (http://alexdantas.net/projects/bsod)

Copyright (C) 2011-2012  Alexandre Dantas <eu@alexdantas.net>

bsod is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

The Droid Sans font family is licensed under the Apache license.
END_OF_VERSION
        exit
      end

    end
    opts.parse! args

    return @settings
  end

  # Returns a specific setting previously set.
  def [] name
    return @settings[name]
  end
end

