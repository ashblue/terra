local _resources = require('scripts.models.resources')

local planet = {
    graphic = nil,
    loc = 'resources/dashboard/background/'
}

local WIDTH = 495 -- 495
local HEIGHT = 280 -- 280
local X = 0
local Y = 0

local _graphics = {
    terrible = planet.loc .. 'terrible.jpg',
    bad = planet.loc .. 'bad.jpg',
    okay = planet.loc .. 'okay.jpg',
    great = planet.loc .. 'great.jpg',
    amazing = planet.loc .. 'amazing.jpg'
}

function planet:updateGraphic()
    planet.graphic:removeSelf()
    planet.graphic = nil

    local t = _resources:getTotal()
    local src = nil

    if t >= 120 then
        src = _graphics.amazing
    elseif t > 90 then
        src = _graphics.great
    elseif t > 70 then
        src = _graphics.okay
    elseif t > 40 then
        src = _graphics.bad
    else
        src = _graphics.terrible
    end

    planet.graphic = display.newImageRect(src, WIDTH, HEIGHT)
    planet.graphic:setReferencePoint(display.TopLeftReferencePoint);
    planet.graphic.x = X
    planet.graphic.y = Y
    planet.graphic:toBack()
end

planet.graphic = display.newImageRect(_graphics.terrible, WIDTH, HEIGHT)
planet.graphic:setReferencePoint(display.TopLeftReferencePoint);
planet.graphic.x = X
planet.graphic.y = Y

return planet