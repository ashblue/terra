local BoxEvent = {}
local Box = require('scripts.templates.box')

local TEXT_WIDTH = 200

function BoxEvent:new(message, callback)
	local o = Box:new('Event')

    function o:destroy()
        Runtime:removeEventListener('touch', self)
        self:removeSelf()
        self = nil
    end

    function o:touch(e)
        if e.phase == 'began' then
            if type(callback) == 'function' then
                timer.performWithDelay(200, callback)
            end

            self:destroy()
        end
    end

    local text = display.newText(message, (display.contentWidth - o.width) / 2 + o.padding, (display.contentHeight - o.height) / 2 + o.padding + o[2].height, TEXT_WIDTH, o.height - (o.padding * 2) - o[2].height, native.systemFont, 14)
    text:setReferencePoint(display.TopRightReferencePoint);
    text:setTextColor(0, 0, 0)
    o:insert(text)

    local image = display.newRect(text.x + o.padding, text.y, o.width - text.width - (o.padding * 3), text.height)
    image:setFillColor(100, 100, 100)
    o:insert(image)

    Runtime:addEventListener('touch', o)

	return o
end

return BoxEvent