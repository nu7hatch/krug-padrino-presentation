This is presentation about Redis made for Kraków Ruby User Group meeting (28 september 2010).
It's strongly based on [Josh's presentation](http://github.com/joshbuddy/padrino-presentation). 
Want to watch it?

Pygments on BSD:
    $ cd /usr/ports/textproc/py-pygments
    $ make install clean

Pygments on Debian:
    $ sudo aptitude install python-pygments

Compile presentation:
    $ sudo gem install bluecloth albino liquid
    $ ruby generate.rb > slides.html
    $ firefox slides.html
