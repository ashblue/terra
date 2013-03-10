local Dashboard = {}
local resources = require('scripts.models.resources')
local Dialogue = require('scripts.models.dialogue')
local Turn = require('scripts.controllers.turn')
local planet = require('scripts.models.planet')

local DEBUG = false

function Dashboard:new()
    local o = {
        tabs = display.newGroup(),
        text = display.newGroup()
    }
    setmetatable(o, { __index = Dashboard })

    function o:newStatBtn(text, location, imgSrc)
        local btn = display.newGroup()
        local background = display.newRect(location, display.contentHeight - 40, display.contentWidth / 3, 40)
        local g = graphics.newGradient(
            { 45, 41, 41 },
            { 95, 90, 90 },
            "up" )
        background:setFillColor(g)
        btn:insert(background)

        local icon = display.newImageRect(imgSrc, 30, 30)
        icon:setReferencePoint(display.TopLeftReferencePoint)
        icon.x = location + 5
        icon.y = display.contentHeight - 40 + 5

        local text = display.newText(text, location, display.contentHeight - background.height, native.systemFont, 16)
        text.x = text.x + ((background.width - text.width) / 2)
        text.y = text.y + ((background.height - text.height) / 2) - 3
        table.insert(resources.src, text)
        o.text:insert(text)

        local divider = display.newRect(location + background.width - 1, display.contentHeight - 40, 2, 40)
        divider:setFillColor(40, 40, 40)

        o.tabs:insert(btn)
    end

    -- Draw three bars to represent stats
    o:newStatBtn(resources[1], 0, 'resources/dashboard/icons/e.png')
    o:newStatBtn(resources[2], display.contentWidth / 3, 'resources/dashboard/icons/h.png')
    o:newStatBtn(resources[3], display.contentWidth / 3 * 2, 'resources/dashboard/icons/s.png')

    -- timer counter
    local clock = display.newGroup()

    local timerBackground = display.newRect(0, 0, 80, 80)
    timerBackground:setFillColor(0, 0, 0, 120)
    clock:insert(timerBackground)

    local timerText = display.newText(resources.year.date, 0, 17, native.systemFont, 24)
    timerText.x = timerBackground.width / 2
    resources.year.src = timerText
    clock:insert(timerText)

    local timerDetail = display.newText('years', 0, 41, native.systemFont, 11)
    timerDetail.x = timerBackground.width / 2
    resources.year.srcDetail = timerDetail
    clock:insert(timerDetail)

    local timerRing = display.newImageRect('resources/dashboard/ring.png', 60, 60)
    timerRing.x = timerBackground.width / 2
    timerRing.y = timerBackground.height / 2
    timerRing.alpha = 0.15

    function o:ringRotate()
        timerRing:rotate(0.5)
    end
    timer.performWithDelay( 60, o.ringRotate, 0 )

    clock:insert(timerRing)

    clock:setReferencePoint(display.TopRightReferencePoint)
    clock.x = display.contentWidth

    -- Dialogue
    function startGame()
        local turn = Turn.new()
    end

    --background:toBack()

    if DEBUG == true then
        local turn = Turn.new()
        return
    end

    Dialogue:new('intro.txt', startGame)

    return o
end

return Dashboard