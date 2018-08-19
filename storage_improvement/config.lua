local default = {
    mul = 1
}

local const = require("darkcraft.storage_improvement.const")
local config = {}
local conObj = const.mod:getConfig()

local data = conObj:load(default)

config.getCapacityIncrease = function()
    return data.mul
end

config.setCapacityIncrease = function(newVal)
    data.mul = newVal
    conObj:save(data)
end

return config