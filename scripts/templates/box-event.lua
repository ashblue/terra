local BoxEvent = {}
local Box = require('scripts.templates.box')

local TEXT_WIDTH = 200

function BoxEvent:new(title, message, callback)
	local o = Box:new('Event: ' .. title)

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

    local text = display.newText(message, (display.contentWidth - o.width) / 2 + o.padding, (display.contentHeight - o.height) / 2 + o.padding + o[2].height, TEXT_WIDTH, o.height - (o.padding * 2) - o[2].height, native.systemFont, 12)
    text:setReferencePoint(display.TopRightReferencePoint);
    text:setTextColor(220, 220, 220)
    o:insert(text)

    print(o.width - text.width - (o.padding * 3), text.height)
    local image = display.newRect(text.x + o.padding, text.y, o.width - text.width - (o.padding * 3), text.height)
    image:setFillColor(100, 100, 100)
    o:insert(image)

    Runtime:addEventListener('touch', o)

	return o
end

return BoxEvent