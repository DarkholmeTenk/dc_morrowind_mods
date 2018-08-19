local config = require("darkcraft.storage_improvement.config")

local upgraded = {}

local function onActivate(e)
    if(e.activator~= tes3.player) then
        return
    end
    if(e.target == nil or e.target.object == nil) then
        return
    end

    local o = e.target.object
    if(o.objectType == tes3.objectType.container) then
        local id = o.id
        if(o.baseObject ~= nil) then
            id = o.baseObject.id
        end
        if(not upgraded[id]) then
            o.capacity = o.capacity * config.getCapacityIncrease()
            upgraded[id] = true
        end
    end
end
event.register("activate", onActivate)