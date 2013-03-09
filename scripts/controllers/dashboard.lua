local Dashboard = {}
local resources = require('scripts.models.resources')
local Dialogue = require('scripts.models.dialogue')
local BoxEvent = require('scripts.templates.box-event')

function Dashboard:new()
    local o = {
        tabs = display.newGroup(),
        text = display.newGroup()
    }
    setmetatable(o, { __index = Dashboard })

    function o:newStatBtn(text, location)
        local btn = display.newGroup()
        local background = display.newRect(location, display.contentHeight - 40, display.contentWidth / 3, 40)
        background:setFillColor(100, 100, 100)
        btn:insert(background)

        local text = display.newText(text, location, display.contentHeight - background.height, native.systemFont, 16)
        text.x = text.x + ((background.width - text.width) / 2)
        text.y = text.y + ((background.height - text.height) / 2) - 3
        o.text:insert(text)

        local divider = display.newRect(location + background.width, display.contentHeight - 40, 1, 40)

        o.tabs:insert(btn)
    end

    function o:updateStats()
        for i = 1, 3 do
                print(resources[i])
            o.text[i].text = resources[i]
        end
    end

    -- Draw three bars to represent stats
    o:newStatBtn(resources[1], 0)
    o:newStatBtn(resources[2], display.contentWidth / 3)
    o:newStatBtn(resources[3], display.contentWidth / 3 * 2)

    -- Dialogue output test
    --local conversation = Dialogue.new('test.txt')
    local event = BoxEvent.new()

    return o
end

return Dashboard