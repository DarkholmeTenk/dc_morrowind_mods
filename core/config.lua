local config = {}

local function copyInto(original, new)
    if(type(original) == "table" and type(new) == "table") then
        for i,v in pairs(original) do
            local newV = new[i]
            if(type(v) == "table") then
                mwse.log("Copying in to " .. i)
                copyInto(v, newV)
            else
                if(type(v) == type(newV)) then
                    if(v ~= newV) then
                        mwse.log("Updating " .. i)
                        original[i] = newV
                    end
                else
                    mwse.log(i .. " wrong type " .. type(v) .. " != " .. type(newV))
                end
            end
        end
    else
        mwse.log("Can't copy into " .. type(original) .. " from " .. type(new))
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
        mwse.log("Loaded " .. json.encode(newConfig))
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