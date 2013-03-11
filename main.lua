-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

display.setStatusBar(display.HiddenStatusBar)

backgroundMusic = audio.loadStream( 'resources/intro/audio/music_bgm.mp3' )
audio.play( backgroundMusic, { channel = 1, loops = -1, fadein = 20000 } )

require('scripts.helpers.shuffle')
local intro = require('scripts.controllers.intro').new()