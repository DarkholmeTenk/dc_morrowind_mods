local config = require("darkcraft/spellcaster/config")
local configUI = require("darkcraft/spellcaster/config_ui")
local magicSchoolSkill = require("tes3.magicSchoolSkill")

local function spellcast(e)
    if(e.expGainSchool == 6) then
        return
    end
    local skillID = magicSchoolSkill[e.expGainSchool]
    local skillIncrease = config.getSkillIncrease(e.expGainSchool, e.source.magickaCost)
    if(config.logging()) then
        mwse.log("DC-SE:" .. e.source.magickaCost .. " to " .. skillIncrease)
    end
    if(skillIncrease > 0) then
        tes3.getMobilePlayer():exerciseSkill(skillID, skillIncrease)
    end
    if(config.shouldDisable(e.expGainSchool)) then
        e.expGainSchool = nil
    end
end
event.register("spellCasted", spellcast, {filter=tes3.getPlayerRef()})

local function registerModConfig(e)
    mwse.registerModConfig("DC - Spellcaster Exp", configUI.getPackage(config))
end
event.register("modConfigReady", registerModConfig)