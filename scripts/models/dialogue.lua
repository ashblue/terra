local Dialogue = {}

local TOP_LEFT = 20
local TOP = 20
local PROFILE_WIDTH = 80
local WIDTH = 400
local HEIGHT = 110
local PADDING = 15
local FILE_DIR = 'dialogue/'

function Dialogue.new(fileTxt)
    local o = display.newGroup()
    o.lineCount = 0
    o.lines = {}
    o.filePath = system.pathForFile(FILE_DIR .. fileTxt, system.ResourcesDirectory )

    function o:nextLine()
        o.lineCount = o.lineCount + 1
        o[3].text = o.lines[o.lineCount]
    end

    local profile = display.newRect(TOP_LEFT, TOP, PROFILE_WIDTH, HEIGHT)
    profile:setFillColor(100, 100, 100)
    profile:setStrokeColor(52, 170, 44, 150)
    profile.strokeWidth = 1
    o:insert(profile)

    local textOutline = display.newRect(TOP_LEFT + PROFILE_WIDTH, TOP, WIDTH - PROFILE_WIDTH, HEIGHT)
    textOutline:setFillColor(0, 0, 0, 200)
    textOutline:setStrokeColor(52, 170, 44, 150)
    textOutline.strokeWidth = 1
    o:insert(textOutline)

    -- Get all the lines
    local file = io.open(o.filePath, 'r')
    for line in file:lines() do
        if line ~= '' then
            table.insert(o.lines, line)
        end
    end
    io.close(file)

    local text = display.newText('', TOP_LEFT + PROFILE_WIDTH + PADDING, TOP + PADDING, WIDTH - PROFILE_WIDTH - (PADDING * 2), HEIGHT - (PADDING * 2), native.systemFont, 12)
    -- Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nec diam nibh. Vivamus vestibulum placerat elit, lobortis pellentesque turpis malesuada non. Sed lectus ligula, commodo non hendrerit id, lacinia a eros.
    o:insert(text)

    function o:destroy()
        Runtime:removeEventListener('touch', o)
        o:removeSelf()
        o = nil
    end

    function o:touch(e)
        if e.phase == 'began' then
            self:nextLine()

            if self.lineCount > table.getn(self.lines) then
                self:destroy()
            end
        end
    end

    Runtime:addEventListener('touch', o)

    o:nextLine()
end

return Dialogue