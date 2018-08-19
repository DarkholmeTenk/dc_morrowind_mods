local InventoryHelper = require("darkcraft.core.helpers.inventory")
local ElementHelper = require("darkcraft.core.helpers.element")

local function findElement(e, name)
    if(e.name == name) then
        return e
    end
    for i,v in pairs(e.children) do
        local x = findElement(v, name)
        if(x ~= nil) then
            return x
        end
    end
    return nil
end

local c = nil

local function onGuiOpen(e)
    if(not e.newlyCreated) then
        return
    end
    if(c == nil) then
        return
    end
    mwse.log("Open")
    --ElementHelper.debug(e.element)
    local element = findElement(e.element, "MenuContents_removebutton").parent
    local fillBar = element:createFillBar({current=0, max=0})
    element:reorderChildren(1, fillBar, 1)
    fillBar.width=120
    fillBar.height=20
    fillBar.borderLeft=5
    local setFillBar = function()
        mwse.log("Updating")
        fillBar.widget.max = c.capacity
        fillBar.widget.current = InventoryHelper.getTotalWeight(c.inventory)
    end
    setFillBar()
    e.element:updateLayout()
    e.element:register("update", function(e) setFillBar() e.source:forwardEvent(e) end)
end
event.register("uiActivated", onGuiOpen, { filter = "MenuContents" })

local function onClose(e)
    c = nil
end
event.register("menuExit", onClose)

local function onActivate(e)
    if(e.activator~= tes3.player) then
        return
    end
    if(e.target == nil or e.target.object == nil) then
        return
    end

    local o = e.target.object
    if(o.objectType == tes3.objectType.container) then
        c = o
    end
end
event.register("activate", onActivate)