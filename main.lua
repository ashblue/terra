-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

display.setStatusBar(display.HiddenStatusBar)

backgroundMusic = audio.loadStream( 'resources/intro/audio/music_bgm.mp3' )
audio.play( backgroundMusic, { channel = 1, loops = -1, fadein = 10000, volume = 0.1 } )

require('scripts.helpers.shuffle')
local intro = require('scripts.controllers.intro').new()