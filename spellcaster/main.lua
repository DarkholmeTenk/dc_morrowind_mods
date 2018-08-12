local config = require("darkcraft/spellcaster/config")
local configUI = require("darkcraft/spellcaster/config_ui")
local magicSchoolSkill = require("tes3.magicSchoolSkill")

local function spellcast(e)
    local skillID = magicSchoolSkill[e.expGainSchool]
    local skillIncrease = config.getSkillIncrease(skillID, e.source.magickaCost)
    if(config.logging()) then
        mwse.log("DC-SE:" .. e.source.magickaCost .. " to " .. skillIncrease)
    end
    if(skillIncrease > 0) then
        tes3.getMobilePlayer():exerciseSkill(skillID, skillIncrease)
    end
    if(config.shouldDisable(skillID)) then
        e.expGainSchool = nil
    end
end
event.register("spellCasted", spellcast, {filter=tes3.getPlayerRef()})

local function registerModConfig(e)
    mwse.registerModConfig("DC - Spellcaster Exp", configUI.getPackage(config))
end
event.register("modConfigReady", registerModConfig)