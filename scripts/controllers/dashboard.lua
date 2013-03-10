local Dashboard = {}
local resources = require('scripts.models.resources')
local Dialogue = require('scripts.models.dialogue')
--local BoxEvent = require('scripts.templates.box-event')
--local BoxList = require('scripts.templates.box-list')
local Turn = require('scripts.controllers.turn')

local DEBUG = true

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
        table.insert(resources.src, text)
        o.text:insert(text)

        local divider = display.newRect(location + background.width, display.contentHeight - 40, 1, 40)

        o.tabs:insert(btn)
    end

    -- background
    local background = display.newImage('resources/dashboard/background-1.jpg')
    background:setReferencePoint(display.TopLeftReferencePoint);
    background.x = 0
    background.y = 0
    --o:insert(background)

    -- Draw three bars to represent stats
    o:newStatBtn(resources[1], 0)
    o:newStatBtn(resources[2], display.contentWidth / 3)
    o:newStatBtn(resources[3], display.contentWidth / 3 * 2)

    -- timer counter
    local timer = display.newGroup()

    local timerBackground = display.newRect(0, 0, 70, 70)
    timerBackground:setFillColor(0, 0, 0, 180)
    timer:insert(timerBackground)

    local timerText = display.newText(resources.year.date, 0, 10, native.systemFont, 26)
    timerText.x = timerBackground.width / 2
    resources.year.src = timerText
    timer:insert(timerText)

    local timerDetail = display.newText('year', 0, 40, native.systemFont, 11)
    timerDetail.x = timerBackground.width / 2
    timer:insert(timerDetail)

    timer:setReferencePoint(display.TopRightReferencePoint)
    timer.x = display.contentWidth

    -- Dialogue
    function startGame()
        local turn = Turn.new()
    end

    background:toBack()

    if DEBUG == true then
        local turn = Turn.new()
        return
    end

    Dialogue:new('intro.txt', startGame)

    return o
end

return Dashboard