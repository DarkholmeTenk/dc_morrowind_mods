local config = {}

local function copyInto(original, new)
    if(type(original) == "table" and type(new) == "table") then
        for i,v in pairs(original) do
            local newV = new[i]
            if(type(v) == "table") then
                copyInto(v, newV)
            else
                if(type(v) == type(newV)) then
                    original[i] = newV
                end
            end
        end
    end
end

local function saveConfig(filename, config)
    lfs.mkdir("Data Files/MWSE/config")
    lfs.mkdir("Data Files/MWSE/config/darkcraft")
    json.savefile("config/darkcraft/" .. filename, config, {indent = true})
end

local function loadConfig(filename)
    return json.loadfile("config/darkcraft/" .. filename)
end

config.get = function(modName)
    c = { modName=modName }

    c.save = function(rc, data)
        saveConfig(rc.modName, data)
    end

    c.load = function(rc, defaultData)
        local data = defaultData
        local newConfig = loadConfig(rc.modName)
        if(newConfig == nil) then
            rc:save()
        else
            copyInto(data, newConfig)
        end
        return data
    end

    return c
end

return config