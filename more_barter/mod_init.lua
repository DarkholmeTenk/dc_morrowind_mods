mwse.log("More_Barter Loading")
local darkcraft = require("darkcraft/darkcraft_core")
local config = require("darkcraft/more_barter/config")
local configUI = require("darkcraft/more_barter/config_ui")

config.load()

local function increaseGold(o, ref)
    local moreBarterMul = config.getBarterMul()
    if(o.barterGold == nil) then
        return
    end
    if(ref.data["moreBarter"] ~= nil and ref.data["moreBarter"]["mul"] == moreBarterMul) then
        return
    end
    local base = 0
    if(ref.data["moreBarter"] == nil) then
        base = o.barterGold
    else
        base = ref.data["moreBarter"]["base"]
    end
    if(base == 0) then
        return
    end

    ref.data["moreBarter"] = {mul=moreBarterMul, base=base}
    local newBarter = math.floor(base * moreBarterMul)
    mwse.log("Increasing Barter Gold: " .. o.id .. " - " .. base .. " - " .. newBarter)
    o.barterGold = newBarter
end

local function setServices(instance, baseObject)
    local addiction = tes3.getObject("emb_memitem_addicted")
    if(addiction == nil) then
        return
    end

    local inventory = instance.inventory
    for stack in tes3.iterate(inventory.iterator) do
        local item = stack.object
        if(item.id == "emb_memitem_addicted" or item.id == "emb_memitem_mychilde" or item.id == "emb_memitem_myvictim" or item.id == "emb_memitem_mythrall") then
            mwse.log("THRALL!")
            if(baseObject.aiConfig ~= nil) then
                if(baseObject.aiConfig.merchantFlags ~= nil and baseObject.aiConfig.merchantFlags > 0) then
                    baseObject.aiConfig.merchantFlags = 262143
                end
            end
        end
    end
end

local function onActivate(e)
    if(e.activator~= tes3.player) then
        return
    end
    if(e.target == nil or e.target.object == nil) then
        return
    end

    local o = e.target.object
    if(o.objectType == tes3.objectType.npc) then
        if(o.baseObject ~= nil) then
            increaseGold(o.baseObject, e.target) 
            --setServices(o, o.baseObject)
        end
    end
end
event.register("activate", onActivate)

local function registerModConfig(e)
    mwse.registerModConfig("DC - More Barter", configUI.getPackage(config))
end
event.register("modConfigReady", registerModConfig)

mwse.log("More_Barter Loaded")
