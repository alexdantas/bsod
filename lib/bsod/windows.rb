
require 'bsod'

module BSOD

  # A general BSOD for Windows.
  # (lies, I couldn't figure out which Windows version associates
  #  with this BSOD)
  class Windows

    # The default white text that will appear over the
    # blue background.
    BSODTEXT = <<END_OF_TEXT
*** STOP: 0x00000001E (0x00000003,0x00000d0e8,0x0c001201e,0x000c0ffee)
Unhandled Kernel exception c0000047 from fa8418b4 (00d4a81c0,00028492e)

Dll Base Date Stamp - Name              Dll Base Date Stamp - Name
bf7978fb be154c92 - ntoskrnl.exe        7fa3883b 11b92972 - hal.dll
a519c86a b386ca2c - ncrc710.sys         faea83e1 c47447d7 - SCSIPORT.SYS
2f983e0b 6e01a9a4 - scsidisk.sys        6a7f9869 45b277c4 - Fastfat.sys
94041089 e1a9f5d9 - Floppy.SYS          b91218c4 c037818d - Hpfs_Rec.SYS
0bb5c0c9 8ca7bd22 - Null.SYS            5496bb5f 1d60d82c - Beep.SYS
a9b37c3a f70ef21d - i8042prt.SYS        585fd0b5 1e973d5d - SERMOUSE.SYS
e4965cb7 24a6ec07 - kbdclass.SYS        2925baf7 5cb9a053 - MOUCLASS.SYS
e54f64c7 f54b26c1 - Videoprt.SYS        ad7a85bd 7d2571b9 - NCC1701E.SYS
1a119462 e9c098e9 - Vga.SYS             e3c5a4a4 f5caa34a - Msfs.SYS

Address dword dump Dll Base                                      - Name
2fc589eb b483bf92 20677c0a f254e409 5977ffa0 a082a53e : c76875ba - i8042prt.SYS
35ec96b5 1dc0af3c 406c655c 5bfbe3fe 8390119a bd653a61 : d17a5ee1 - SCSIPORT.SYS
d54704c9 c9c43be6 ece08295 e5fd350c f469f913 86a54eeb : 24ed5a16 - ntoskrnl.exe
4ade1e66 2639fc5c 4d22f159 94f99371 f9876420 71517f45 : 69048b22 - ntoskrnl.exe
e3d88756 0e0e2322 2a899667 71dd4f99 9fba9b81 12b84e81 : 23ce15e3 - ntoskrnl.exe
981f5fa4 e03f9d34 6ec6e730 31ca1ce6 f75b54b6 d5ba53f6 : a7419dad - ntoskrnl.exe
16cfcafd 67eb2c74 9152a8f3 62864c8e 148c9c29 bb4235b5 : 3e24c47e - ntoskrnl.exe

Kernel Debugger Using: COM2 (Port 0x2f8, Baud Rate 19200)
Restart and set the recovery options in the system control panel
or the /CRASHDEBUG system start option. If this message reappears,
contact your system administrator or technical support group.
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

