
require 'sdl'

# This is a great container over all Blue Screens
# of Death (BSOD).
#
# Every BSOD must implement a `draw` method, that will
# render itself over any `SDL::Surface`.
#
module BSOD


  # Tells if SDL has been initialized already, both
  # by us (`init_sdl`) or by the user.
  def self.sdl_inited?
    if (SDL::inited_system(SDL::INIT_VIDEO) == 0) or
        (not SDL::TTF::init?)
      return false
    end

    return true
  end

  # Waits for a keypress of `SDL_KEY` `key`, ignoring
  # anything else.
  #
  # Defaults to F8.
  def self.wait_for_sdl_key(key=SDL::Key::F8)
    loop = true
    while loop

      # Get events, exit when a certain key is pressed
      while event = SDL::Event2.poll

        case event
        when SDL::Event2::KeyDown
          SDL::Key.scan
          if SDL::Key.press? key
            loop = false
          end
        end
      end
      # Sleeping a little to avoid high-CPU rates.
      sleep 0.05
    end
  end

  def self.init_curses

  end
end

