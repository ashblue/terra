local Turn = {}
local json = require('json')
local Dialogue = require('scripts.models.dialogue')
local BoxList = require('scripts.templates.box-list')
local BoxEvent = require('scripts.templates.box-event')
local choice = require('scripts.models.choice')
local resources = require('scripts.models.resources')
local planet = require('scripts.models.planet')

-- Process and swallow JSON for structures and
local _path = system.pathForFile('scripts/models/events.json', system.ResourcesDirectory)
local _file = io.open(_path, 'r')
local _events = json.decode(_file:read('*a'))
local _yearColor = 255
local _statusMessage
io.close(_file)
table.shuffle(_events)

_path = system.pathForFile('scripts/models/structures.json', system.ResourcesDirectory)
_file = io.open(_path, 'r')
local _structures = json.decode(_file:read('*a'))
io.close(_file)

_path = system.pathForFile('scripts/models/random.json', system.ResourcesDirectory)
_file = io.open(_path, 'r')
local _random = json.decode(_file:read('*a'))
io.close(_file)

function Turn:new()
    local o = display.newGroup()

    -- Get proper event
    local currentEvent = table.remove(_events)

    -- Calculate success or fail and update values
    function o:showEvent()
        -- TODO Get proper random value based on choice
        local chance = math.random(1, 10)
        local e = 0
        local h = 0
        local s = 0

        -- TODO Set proper succeed chance
        local benchmark
        for i, c in ipairs(currentEvent.choices) do
            if c.id == choice.current.id then
                benchmark = _random[c.random]
            end
        end

        if chance < benchmark then
            _statusMessage = currentEvent.success.message
            BoxEvent:new('O: ' .. choice.current.name .. '. ' .. currentEvent.description, o.successMessage)
            -- TODO Add success points
            e = e + currentEvent.success.points.e
            h = h + currentEvent.success.points.h
            s = s + currentEvent.success.points.s
        else
            _statusMessage = currentEvent.failure.message
            BoxEvent:new('O: ' .. choice.current.name .. '. ' .. currentEvent.description, o.successMessage)
            -- TODO Subtract fail points
            e = e + currentEvent.failure.points.e
            h = h + currentEvent.failure.points.h
            s = s + currentEvent.failure.points.s
        end

        -- TODO Update score values
        resources[1] = resources[1] + e + choice.current.cost.e
        resources[2] = resources[2] + h + choice.current.cost.h
        resources[3] = resources[3] + s + choice.current.cost.s
        resources:drawResources()
    end

    -- Creation of choice box and selection
    function o:showBoxList()
        local structures = {}

        for i, s in ipairs(currentEvent.choices) do
            _structures[tostring(s.id)].id = s.id
            table.insert(structures, _structures[tostring(s.id)])
        end

        table.shuffle(structures)

        BoxList:new(structures, o.showEvent)
    end

    -- Creation of dialogue warning from NPC
    Dialogue:new({ currentEvent.warning[1] }, o.showBoxList)

    function o:successMessage()
        Dialogue:new({ _statusMessage }, o.updateCountdown)
    end

    -- Restart and do again
    function o:updateCountdown()
        resources.year.date = resources.year.date - 1
        resources.year.src.text = resources.year.date
        _yearColor = _yearColor - 25
        resources.year.src:setTextColor(255, _yearColor, _yearColor)
        resources.year.srcDetail:setTextColor(255, _yearColor, _yearColor)

        planet:updateGraphic()

        if resources.year.date >= 1 then
            currentEvent = table.remove(_events)
            Dialogue:new({ currentEvent.warning[1] }, o.showBoxList)
        else
            print('doomsday')
            local total = resources[1] + resources[2] + resources[3]
            if total > 120 then
                Dialogue:new('good.txt')
            elseif total > 105 then
                Dialogue:new('normal.txt')
            else
                Dialogue:new('bad.txt')
            end
        end
    end

    return o
end

return Turn