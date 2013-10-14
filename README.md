# bsdod

Simulates a Blue Screen of Death, as seen on Micro$oftWindow$.

As an executable, has optional flag to sleep before BSODing so you can surprise
your friends!

As a library, you can integrate a BSOD on any SDL surface.

## Usage

### Executable

    $ bsod
    $ bsod --sleep 3.1415        # sleep before BSODing
    $ bsod --no-fullscreen

For more see `bsod --help`.

### Library

    require 'bsod'
    screen = SDL::Screen.get
    BSOD::run(screen, screen.w, screen.h)

## Install

    $ gem install bsod

## Contact

Hi, I'm Alexandre Dantas! Thanks for having interest in this project. Please
take the time to visit any of the links below.

* `bsod` homepage: http://www.alexdantas.net/projects/bsod
* Contact: `eu @ alexdantas.net`
* My homepage: http://www.alexdantas.net

