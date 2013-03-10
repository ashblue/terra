local Intro = {}
local dashbaord = require('scripts.controllers.dashboard')

local DEBUG = false

function Intro:new()
    o = display.newGroup()

    if DEBUG == true then
        dashbaord.new()
        return
    end

    -- Set background image (make sure it scales properly)
    local background = display.newImageRect('resources/intro/background.jpg', display.contentWidth, display.contentHeight)
    background:setReferencePoint(display.TopLeftReferencePoint);
    background.x = 0
    background.y = 0
    o:insert(background)

    -- Display Image text
    local messageBackground = display.newRect(0, 0, display.contentWidth + 400, display.contentHeight)
    messageBackground:setFillColor(0, 0, 0)
    messageBackground.alpha = 0
    o:insert(messageBackground)

    local message = display.newImageRect('resources/intro/text.png', 495, 280) -- 852, 480
    message.alpha = 0
    message:setReferencePoint(display.CenterReferencePoint);
    message.x = display.contentWidth / 2
    message.y = display.contentHeight / 2
    o:insert(message)

    local logo = display.newImageRect('resources/intro/logo.png', 495, 280) -- 852, 480
    logo.alpha = 0
    logo:setReferencePoint(display.CenterReferencePoint);
    logo.x = display.contentWidth / 2
    logo.y = display.contentHeight / 2
    o:insert(logo)

    function o:showIntro()
        transition.to( messageBackground, { alpha = 0.7, time = 3000 } )
        transition.to( message, { alpha = 1, time = 3000 } )
        transition.to( message, { alpha = 0, time = 1000, delay = 10000 } )
        transition.to( logo, { alpha = 1, time = 5000, delay = 10000 })

        messageBackground:toFront()
        message:toFront()
        logo:toFront()
        timer.performWithDelay( 20000, o.destroy)
    end

    -- Create ship offscreen and fly it into view until it shrinks and dissapears
    local ship = display.newImageRect('resources/intro/spaceship.png', 700, 394)
    ship:setReferencePoint(display.TopCenterReferencePoint)
    ship.x = display.contentWidth / 2
    ship.y = display.contentHeight
    transition.to( ship, { time = 20000, x = display.contentWidth / 2, y = -50, width = 0, height = 0, transition = easing.outExpo } )
    o:insert(ship)

    timer.performWithDelay( 5000, o.showIntro )

    -- Destroy intro and cut to dashboard controller and turn controller
    function o:destroy()
        o:removeSelf()
        o = nil
        dashbaord:new()
    end

    return o
end

return Intro