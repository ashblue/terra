local BoxEvent = {}
local Box = require('scripts.templates.box')

local TEXT_WIDTH = 200
local IMAGE_PATH = 'resources/dashboard/events/'

function BoxEvent:new(title, message, src, callback)
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

    local image = display.newImageRect(IMAGE_PATH .. src, 92, 134)
    image:setReferencePoint(display.TopLeftReferencePoint)
    image.x = text.x + o.padding
    image.y = text.y
    o:insert(image)

    Runtime:addEventListener('touch', o)

	return o
end

return BoxEvent