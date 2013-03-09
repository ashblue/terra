local BoxEvent = {}

local TOP_OFFSET = -20
local PADDING = 20
local WIDTH = 350
local HEIGHT = 200
local TEXT_WIDTH = 200

function BoxEvent:new(eventId)
	local o = display.newGroup()
    o.titleText = 'Event'

    function o:destroy()
        Runtime:removeEventListener('touch', o)
        o:removeSelf()
        o = nil
    end

    function o:touch(e)
        if e.phase == 'began' then
            self.destroy()
        end
    end

    local background = display.newRect(0, 0, WIDTH, HEIGHT)
    background.x = display.contentWidth / 2
    background.y = display.contentHeight / 2
    o:insert(background)

    local title = display.newText(o.titleText, 0, (display.contentHeight - HEIGHT) / 2 + PADDING, native.systemFont, 22)
    title.x = display.contentWidth / 2
    title.y = title.y - (title.height / 2)
    title:setTextColor(0, 0, 0)
    o:insert(title)

    local text = display.newText('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nec diam nibh. Vivamus vestibulum placerat elit, lobortis pellentesque turpis malesuada non. Sed lectus ligula, commodo non', (display.contentWidth - WIDTH) / 2 + PADDING, (display.contentHeight - HEIGHT) / 2 + PADDING + title.height, TEXT_WIDTH, HEIGHT - (PADDING * 2) - title.height, native.systemFont, 14)
    text:setReferencePoint(display.TopRightReferencePoint);
    text:setTextColor(0, 0, 0)
    o:insert(text)

    local image = display.newRect(text.x + PADDING, text.y, WIDTH - text.width - (PADDING * 3), text.height)
    image:setFillColor(100, 100, 100)
    o:insert(image)

    o.y = o.y + TOP_OFFSET

    Runtime:addEventListener('touch', o)

    --local image = display.newRect()

    --local mechImage = display.newRect(0, 0, 50, 50)
    --mechImage:setFillColor(0, 0, 200)
    --o:insert(mechImage)
    --
    --function o:setPosition(x, y)
    --    self.x = x
    --    self.y = y
    --end
    --
    --storage:addGroup(o)

	return o
end

return BoxEvent