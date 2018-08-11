local darkcraft = {}

local debug = require("darkcraft/core/debug")

darkcraft.debug = function(o, name)
    debug(o, name)
end

darkcraft.saveConfig = function(filename, config)
    lfs.mkdir("Data Files/MWSE/config")
    lfs.mkdir("Data Files/MWSE/config/darkcraft")
    json.savefile("config/darkcraft/" .. filename, config, {indent = true})
end

darkcraft.loadConfig = function(filename)
    return json.loadfile("config/darkcraft/" .. filename)
end

return darkcraft