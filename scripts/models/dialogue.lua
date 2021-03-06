local Dialogue = {}

local TOP_LEFT = 20
local TOP = 20
local PROFILE_WIDTH = 80
local WIDTH = 400
local HEIGHT = 110
local PADDING = 15
local FILE_DIR = 'dialogue/'

function Dialogue:new(fileTxt, callback)
    local o = display.newGroup()
    o.lineCount = 0
    o.lines = {}

    function o:nextLine()
        if type(fileTxt) == 'string' then
            self.lineCount = self.lineCount + 1
            self[3].text = self.lines[self.lineCount]
        else
            self.lineCount = self.lineCount + 1
            self[3].text = self.lines[1]
        end
    end

    local profile = display.newImageRect('resources/dashboard/terrance.jpg', PROFILE_WIDTH, HEIGHT)
    profile:setReferencePoint(display.TopLeftReferencePoint);
    profile.x = TOP_LEFT
    profile.y = TOP
    profile:setStrokeColor(52, 170, 44, 150)
    profile.strokeWidth = 1
    o:insert(profile)

    local textOutline = display.newRect(TOP_LEFT + PROFILE_WIDTH, TOP, WIDTH - PROFILE_WIDTH, HEIGHT)
    textOutline:setFillColor(0, 0, 0, 240)
    textOutline:setStrokeColor(52, 170, 44, 150)
    textOutline.strokeWidth = 1
    o:insert(textOutline)

    -- Get all the lines
    if type(fileTxt) == 'string' then
        o.filePath = system.pathForFile(FILE_DIR .. fileTxt, system.ResourcesDirectory )
        local file = io.open(o.filePath, 'r')
        for line in file:lines() do
            if line ~= '' then
                table.insert(o.lines, line)
            end
        end
        io.close(file)
    else
        table.insert(o.lines, fileTxt[1])
    end

    local text = display.newText(o.lines[1], TOP_LEFT + PROFILE_WIDTH + PADDING, TOP + PADDING, WIDTH - PROFILE_WIDTH - (PADDING * 2), HEIGHT - (PADDING * 2), native.systemFont, 12)
    -- Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nec diam nibh. Vivamus vestibulum placerat elit, lobortis pellentesque turpis malesuada non. Sed lectus ligula, commodo non hendrerit id, lacinia a eros.
    text:setTextColor(220, 220, 220)
    o:insert(text)

    function o:destroy()
        if type(callback) == 'function' then
            timer.performWithDelay( 200, callback)
        end

        Runtime:removeEventListener('touch', self)
        self:removeSelf()
        self = nil
    end

    function o:touch(e)
        if e.phase == 'ended' then
            self:nextLine()

            if type(fileTxt) == 'string' then
                if self.lineCount > table.getn(self.lines) then
                    self:destroy()
                end
            else
                print('DESTROY')
                self:destroy()
            end
        end
    end

    Runtime:addEventListener('touch', o)

    o:nextLine()
end

return Dialogue