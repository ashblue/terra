-- TODO Units for a level should come from a file
-- TODO Background data for a level should come from a file
-- TODO Each entity should be added to the map as its loaded
-- TODO Destroy method to cleanup the entire level
-- TODO Must be a better way to add images to the camera than manually adding them

local Dashboard = {}

function Dashboard.new()
    local o = {}
    setmetatable(o, { __index = Dashboard })

    -- Draw three bars to represent stats
    o.tabs = display.newGroup()
    local one = display.newGroup()
    local background = display.newRect(0, display.contentHeight - 40, display.contentWidth / 3, 40)
    local text = display.newEmbossedText("Hello World!", 0, 0, native.systemFont, 16, { 255, 255, 255 } )
    background:setFillColor(100, 100, 100)
    one:insert(background)
    o.tabs:insert(one)

    --local two = display.newRect(display.contentWidth / 3, display.contentHeight - 40, display.contentWidth / 3, 40)
    --two:setFillColor(100, 100, 100)
    --o.tabs:insert(two)
    --
    --local three = display.newRect(display.contentWidth / 3 * 2, display.contentHeight - 40, display.contentWidth / 3, 40)
    --three:setFillColor(100, 100, 100)
    --o.tabs:insert(three)

    return o
end

return Dashboard