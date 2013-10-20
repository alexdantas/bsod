
require 'bsod'

module BSOD

  # Remember Window$ 2000?
  #
  # This is the same as WindowsNT, the only thing that
  # changes is the default message.
  class LinuxSPARC

    BSODTEXT = <<END_OF_TEXT
Unable to handle kernel paging request at virtual address f0d4a000
tsk->mm->context = 00000014
tsk->mm->pgd = f26b0000
              \\|/ ____ \\|/
              "@'/ ,. \\`@"
              /_| \\__/ |_\\
                 \\__U_/
gawk(22827): Oops
PSR: 044010c1 PC: f001c2cc NPC: f001c2d0 Y: 00000000
g0: 00001000 g1: ad88208a g2: 589528c3 g3: 4c4eaf60
g4: f8e9a052 g5: a8fa48c3 g6: 93eeb38e g7: ea90911f
o0: 6814da2c o1: bcbc439b o2: fbee7b93 o3: 5c92e715
o4: f4e435d8 o5: c0d794ce sp: 187d9d04 ret_pc: 5766da46
l0: 3623c157 l1: 8dacaddb l2: e2fb0bcb l3: 61058d7c
l4: c0e26c5b l5: baf25f79 l6: 9ad3e338 l7: c80f287b
i0: a5487db7 i1: 2a510244 i2: 90803a7c i3: bfb8cf31
i4: d0157ffe i5: 54647960 i6: bac6c329 i7: 2b5b54ed
Instruction DUMP:
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

      black = screen.format.map_rgb(0, 0, 0)
      screen.fill_rect(0, 0, width, height, black)

      # Printing that bizarre text
      font = SDL::TTF.open($settings[:font_filename],
                           $settings[:font_size] - 2)

      font.style = SDL::TTF::STYLE_BOLD if $settings[:font_bold]

      # need to print at the bottom of the screen
      lines_ammount = height / font.height

      i = (lines_ammount - BSODTEXT.lines.size)
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

