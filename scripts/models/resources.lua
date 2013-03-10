local resources = {
    0,
    0,
    0,
    1
}

resources.year = {
    src = nil,
    date = 10
}

resources.src = {}

local resourceNames = {
    environment = 1,
    human = 2,
    science = 3,
    year = 4
}

function resources:drawResources(name)
    for i = 1, 3 do
        resources.src[i].text = resources[i]
    end
end

return resources