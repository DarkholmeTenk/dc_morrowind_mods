local config = require("darkcraft/core/config")
local mod = {}

mod.get = function(modName)
    local m = {
        modName = modName
    }
    
    m.getConfig = function(m)
        return config.get(m.modName)
    end

    return m
end

return mod.get