local Dialogue = {}

local TOP_LEFT = 20
local TOP = 20
local PROFILE_WIDTH = 80
local WIDTH = 400
local HEIGHT = 110
local PADDING = 15
local FILE_DIR = 'dialogue/'

function Dialogue:new()
    local o = display.newGroup()

    function o:nextLine()

    end

    local profile = display.newRect(TOP_LEFT, TOP, PROFILE_WIDTH, HEIGHT)
    profile:setFillColor(100, 100, 100)
    profile:setStrokeColor(52, 170, 44, 150)
    profile.strokeWidth = 1
    o:insert(profile)

    local textOutline = display.newRect(TOP_LEFT + PROFILE_WIDTH, TOP, WIDTH - PROFILE_WIDTH, HEIGHT)
    textOutline:setFillColor(0, 0, 0, 0)
    textOutline:setStrokeColor(52, 170, 44, 150)
    textOutline.strokeWidth = 1
    o:insert(textOutline)

    local text = display.newText('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nec diam nibh. Vivamus vestibulum placerat elit, lobortis pellentesque turpis malesuada non. Sed lectus ligula, commodo non hendrerit id, lacinia a eros.', TOP_LEFT + PROFILE_WIDTH + PADDING, TOP + PADDING, WIDTH - PROFILE_WIDTH - (PADDING * 2), HEIGHT - (PADDING * 2), native.systemFont, 12)

    local filePath = system.pathForFile(FILE_DIR .. 'test.txt', system.ResourcesDirectory )
    local file = io.open(filePath, 'r')
    for line in file:lines() do
       print( line )  -- display the line in the terminal
    end
    io.close(file)

--	local mech = display.newGroup()
--    mech.id = id.getId()
--    mech.type = 'a'
--
--    local mechImage = display.newRect(0, 0, 50, 50)
--    mechImage:setFillColor(0, 0, 200)
--    mech:insert(mechImage)
--
--    function mech:setPosition(x, y)
--        self.x = x
--        self.y = y
--    end
--
--    storage:addGroup(mech)
--
--	return mech
end

return Dialogue