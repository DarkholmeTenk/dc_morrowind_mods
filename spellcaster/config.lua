local defaultData = {
    [0] = {
        disable = false,
        sqrt = 0,
        const = 0,
        linear = 1,
        sqr = 0
    },
    {
        disable = false,
        sqrt = 0,
        const = 0,
        linear = 1,
        sqr = 0
    },
    {
        disable = false,
        sqrt = 0,
        const = 0,
        linear = 1,
        sqr = 0
    },
    {
        disable = false,
        sqrt = 0,
        const = 0,
        linear = 1,
        sqr = 0
    },
    {
        disable = false,
        sqrt = 0,
        const = 0,
        linear = 1,
        sqr = 0
    },
    {
        disable = false,
        sqrt = 0,
        const = 0,
        linear = 1,
        sqr = 0
    },
    logging = false
}

local configObj = darkcraft.getMod("spellcaster"):getConfig()
local data = configObj:load(defaultData)

local config = {}

config.getData = function()
    return data
end

config.setData = function(newData)
    configObj:save(newData)
    data = newData
end

config.shouldDisable = function(skill)
    return data[skill].disable
end

config.logging = function()
    return data[logging]
end

config.getSkillIncrease = function(skill, cost)
    local d = data[skill]
    return (math.sqrt(cost) * d.sqrt) + (d.const) + (d.linear * cost) + (d.sqr * cost * cost)
end

return config