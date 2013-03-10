local _resources = require('scripts.models.resources')

local planet = {
    graphic = nil,
    loc = 'resources/dashboard/background/'
}

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

    planet.graphic = display.newImage(src)
    planet.graphic:setReferencePoint(display.TopLeftReferencePoint);
    planet.graphic.x = 0
    planet.graphic.y = 0
    planet.graphic:toBack()
end

planet.graphic = display.newImage(_graphics.terrible)
planet.graphic:setReferencePoint(display.TopLeftReferencePoint);
planet.graphic.x = 0
planet.graphic.y = 0

return planet