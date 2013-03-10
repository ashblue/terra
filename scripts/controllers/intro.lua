local Intro = {}
local dashbaord = require('scripts.controllers.dashboard')

local DEBUG = true

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

    --local message = display.newRect(0, 0, 100, 100)
    local message = display.newImage('resources/intro/text.png')

    message.alpha = 0
    message:setReferencePoint(display.CenterReferencePoint);
    message.x = display.contentWidth / 2
    message.y = display.contentHeight / 2
    o:insert(message)

    function o:showIntro()
        --messageBackground.alpha = 0.7
        --message.alpha = 1
        transition.to( messageBackground, { alpha = 0.7, time = 3000 } )
        transition.to( message, { alpha = 1, time = 3000 } )
        messageBackground:toFront()
        message:toFront()
        timer.performWithDelay( 12000, o.destroy)
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