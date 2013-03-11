local resources = {
    10,
    10,
    10,
    1
}

local BAR_WIDTH = 86
local BAR_PADDING = 10

resources.year = {
    src = nil,
    date = 10
}

resources.src = {}
resources.bar = {}

local resourceNames = {
    environment = 1,
    human = 2,
    science = 3,
    year = 4
}

function resources:getTotal()
    return self[1] + self[2] + self[3]
end

function resources:drawResources(name)
    for i = 1, 3 do
        local total = resources[i] + BAR_PADDING
        if (total < 1) then
            total = 1
        end

        resources.bar[i].x = resources.bar[i].x + ((total - resources.bar[i].width) / 2)
        resources.bar[i].width = total
    end
end

return resources