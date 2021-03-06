
require 'bsod'
require 'bsod/windowsnt'

module BSOD

  # As seen on Window$ XP.
  #
  # This is the same as WindowsNT, the only thing that
  # changes is the default message.
  class WindowsXP

    # The default white text that will appear over the
    # blue background.
    BSODTEXT = <<END_OF_TEXT
A problem has been detected and windows has been shut down to prvent damage
to your computer.

The problem seems to be caused by the following file: SPCMDCON.SYS

PAGE_FAULT_IN_NONPAGED_AREA

If this is the first time you've seen this stop error screen,
restart your computer. If this screen appears again, follow
these steps:

Check to make sure any new hardware or software is properly installed.
If this is a new installation, ask your hardware or software manufacturer
for any windows updates you might need.

If problems continue, disable or remove any newly installed hardware
or software. Disable BIOS memory options such as caching or shadowing.
If you need to use Safe Mode to remove or disable components, restart
your computer, press F8 to select Advanced Startup Options, and then
select Safe Mode.

Technical information:

*** STOP: 0x00000050 (0xFD3094C2,0x00000001,0xFBFE7617,0x00000000)


*** SPCMDCON.SYS - Address FBFE7617 base at FBFE5000, DateStamp 3d6dd67c
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

