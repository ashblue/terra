local Turn = {}
local json = require('json')
local Dialogue = require('scripts.models.dialogue')
local BoxList = require('scripts.templates.box-list')
local BoxEvent = require('scripts.templates.box-event')
local choice = require('scripts.models.choice')
local resources = require('scripts.models.resources')

-- Process and swallow JSON for structures and
local _path = system.pathForFile('scripts/models/events.json', system.ResourcesDirectory)
local _file = io.open(_path, 'r')
local _events = json.decode(_file:read('*a'))
io.close(_file)

_path = system.pathForFile('scripts/models/structures.json', system.ResourcesDirectory)
_file = io.open(_path, 'r')
local _structures = json.decode(_file:read('*a'))

function Turn:new()
    local o = display.newGroup()

    -- Get proper event
    local currentEvent = table.remove(_events)

    -- Calculate success or fail and update values
    -- Event dialogue appeaes with Success or failure message
    function o:showEvent()
        local chance = math.random(1, 100)

        if chance > 50 then
            BoxEvent:new('Success event', o.updateCountdown)
        else
            BoxEvent:new('Fail event', o.updateCountdown)
        end
    end

    -- Creation of choice box and selection
    function o:showBoxList()
        local structures = {}

        for i, s in ipairs(currentEvent.choices) do
            table.insert(structures, _structures[tostring(s.id)])
        end

        BoxList:new(structures, o.showEvent)
    end

    -- Creation of dialogue warning from NPC
    Dialogue:new({ currentEvent.description }, o.showBoxList)

    -- Restart and do again
    function o:updateCountdown()
        resources.year.date = resources.year.date - 1
        resources.year.src.text = resources.year.date

        if resources.year.date >= 1 then
            currentEvent = table.remove(_events)
            Dialogue:new({ currentEvent.description }, o.showBoxList)
        else
            print('doomsday')
        end
    end

    return o
end

return Turn