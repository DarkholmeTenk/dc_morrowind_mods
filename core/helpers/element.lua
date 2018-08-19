local element = {}

local function debugInt(e, logger)
    for i,v in pairs(e.children) do
        logger(i .. " - " .. v.name .. " - " .. v.text .. "{" .. v.width .. "," .. v.height .. "}")
        debugInt(v, function(s) logger("  " .. s) end)
    end
end

element.debug = function(e)
    debugInt(e, mwse.log)
end

return element