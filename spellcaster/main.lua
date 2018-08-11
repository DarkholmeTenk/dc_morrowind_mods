local config = require("darkcraft/spellcaster/config")
local configUI = require("darkcraft/spellcaster/config_ui")


local function spellcast(e)
    darkcraft.debug(e, "spellcast event")
    mwse.log("" .. e.source.magickaCost)
    local skillID = tes3.magicSchoolSkill[e.expGainSchool]
    local skillIncrease = config.getSkillIncrease(skillID, e.source.magickaCost)
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