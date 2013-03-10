local Box = {}

local TOP_OFFSET = -20
local PADDING = 20
local WIDTH = 350
local HEIGHT = 200

function Box:new(titleText)
	local o = display.newGroup()
    o.padding = PADDING

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

    background:setFillColor(0, 0, 0, 200)
    background:setStrokeColor(52, 170, 44, 150)
    background.strokeWidth = 1

    o:insert(background)

    local title = display.newText(titleText, 0, (display.contentHeight - HEIGHT) / 2 + PADDING, native.systemFont, 22)
    title.x = display.contentWidth / 2
    title.y = title.y - (title.height / 2)
    title:setTextColor(220, 220, 220)
    o:insert(title)

    o.y = o.y + TOP_OFFSET

	return o
end

return Box