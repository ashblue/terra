local BoxList = {}
local Box = require('scripts.templates.box')
local json = require('json')
local choice = require('scripts.models.choice')

local PADDING = 3
local LEFT_COLUMN = 200

local _path = system.pathForFile('scripts/models/structures.json', system.ResourcesDirectory)
local _file = io.open(_path, 'r') --system.ResourcesDirectory
local _structures = json.decode(_file:read('*a'))
io.close(_file)

function BoxList:new(structures, callback)
    local o = Box:new('Structures')

    function o:btn(btnText, e, h, s)
        -- Draw 5 buttons with text in one column
        local btn = display.newGroup()
        btn:setReferencePoint(display.TopLeftReferencePoint)

        local text = display.newText(btnText, PADDING * 2, 0, native.systemFont, 14)
        btn:insert(text)

        local background = display.newRoundedRect(0, 0, LEFT_COLUMN, text.height + PADDING, 3)
        background:setFillColor(255, 0, 0)
        btn:insert(background)

        local textPoints = display.newText('E ' .. e .. ' - H ' .. h .. ' - S ' .. s, background.width + 10, 0, native.systemFont, 14)
        textPoints:setTextColor(0, 0, 0)
        btn:insert(textPoints)

        btn:setReferencePoint(display.TopLeftReferencePoint)
        btn.x = 20
        btn.y = 20

        text:toFront()

        -- BACKGROUND HIGHLIGHTING
        --function background:touch(e)
        --    if e.phase == 'began' then
        --        --print(self[2])
        --        self:setFillColor(0, 0, 255)
        --    end
        --end
        --
        --btn:addEventListener('touch', background)

        return btn
    end

    -- Create a function that deletes everything and fires a callback
    -- Needs to attach choice to models

    function o:destroy()
        self:removeSelf()
        self = nil
    end

    local btn
    _structures = { _structures['1'] }
    for i, j in ipairs(structures) do
        btn = o:btn(j.name, j.cost.e, j.cost.h, j.cost.s)
        btn.x = (display.contentWidth - o.width) / 2 + o.padding
        btn.y = (display.contentHeight - o.height + o[2].height) / 2 + o.padding + ((i - 1) * btn.height) + (i * 6)
        btn.structure = j

        function btn:touch(e)
            if e.phase == 'began' then
                choice:setCurrent(self.structure)
                btn:removeEventListener('touch', btn)

                if type(callback) == 'function' then
                    timer.performWithDelay(200, callback)
                end

                o:destroy()
            end
        end

        btn:addEventListener('touch', btn)

        o:insert(btn)
    end

    return o
end

return BoxList