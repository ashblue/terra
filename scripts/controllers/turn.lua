local Turn = {}
local json = require('json')
local Dialogue = require('scripts.models.dialogue')

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

    -- Creation of dialogue warning from NPC
    print(currentEvent.name)
    Dialogue:new({ currentEvent.name })

    -- Creation of choice box and selection

    -- Calculate success or fail and update values

    -- Event dialogue appeaes with Success or failure message

    -- Update year

    -- Restart and do again

    return o
end

return Turn