local function debugWL(o, logger)
    local t = type(o)
    if(t == "table") then
        for i,v in pairs(o) do
            logger(i .. " - " .. type(v))
            debugWL(v, function(s) logger("  " .. s) end)
        end
    elseif(t == "userdata") then
        for i,v in pairs(getmetatable(o)) do
            logger(i .. " - " .. type(v))
        end
    elseif(t == "string") then
        logger(o)
    elseif(t == "number" or t == "boolean") then
        logger("" .. o)
    end
end

local function debug(o, name)
    if(name ~= nil) then
        mwse.log(name .. " - " .. type(o))
    end
    return debugWL(o, function(s) mwse.log("  ".. s) end)
end

return debug