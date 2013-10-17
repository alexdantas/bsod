
require 'bsod'

module BSOD

  # Remember Window$ 2000?
  #
  # This is the same as WindowsNT, the only thing that
  # changes is the default message.
  class Windows2000 < WindowsNT

    BSODTEXT = <<END_OF_TEXT
A problem has been detected and windows has been shut down to prevent damage
to your computer.

If this is the first time you've seen this stop error screen,
restart your computer. If this screen appears again, follow
these steps:

Check to be sure you have adequate disk space. If a driver is
identified in the Stop message, disable the driver or check
with the manufacturer for driver updates. Try changing video
adapters.

Check with your hardware vendor for any BIOS updates. Disable
BIOS memory options such as caching or shadowing. If you need
to use Safe Mode to remove or disable components, restart your
computer, press F8 to select Advanced Startup Options, and then
select Safe Mode.

Technical information:

*** STOP: 0x0000007E (0xC0000005,0xF88FF190,0x0xF8975BA0,0xF89758A0)


***  EPUSBDSK.sys - Address F88FF190 base at FF88FE000, datestamp 3b9f3248

Beginning dump of physical memory
Physical memory dump complete.
Contact your system administrator or technical support group for further
assistance.
END_OF_TEXT

    # No `def initialize` on purpose

    # Draws the BSOD on a SDL's `screen`, bounded by `width` and
    # `height`.
    #
    # It must be a `SDL::Surface` (consequently, a `SDL::Screen`
    # is acceptable too.
    def draw(screen, width, height)

      # Should I break the program's flow here?
      BSOD::init_sdl if not BSOD::sdl_inited?

      # Filling screen with that sweet, sweet blue tone
      blue = screen.format.map_rgb(0, 0, 255)
      screen.fill_rect(0, 0, width, height, blue)

      # Printing that bizarre text
      font = SDL::TTF.open($settings[:font_filename],
                           $settings[:font_size])

      font.style = SDL::TTF::STYLE_BOLD if $settings[:font_bold]

      i = 0
      BSODTEXT.each_line do |line|
        # This is a little hack to allow printing empty lines.
        # First I remove the '\n' at the end to avoid nasty things
        # and then I append a space, to prevent nil strings.
        line.chomp!
        line += " "

        font.draw_solid_utf8(screen, line,
                             3, (i * font.height),
                             255, 255, 255)
        i += 1
      end

      font.close

      # @note Maybe update only the bounded rectangle?
      SDL::Screen.get.update_rect(0, 0, 0, 0)
    end
  end
end

