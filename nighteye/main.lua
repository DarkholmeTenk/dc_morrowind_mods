mwse.log("Darkcraft01")

local SPELL_ID = "dc_vampire_nighteye"

function getSpell()
    local nightEyeSpell = tes3.getObject(SPELL_ID)
    mwse.log("NE - " .. nightEyeSpell.id)
    return nightEyeSpell
end

function disableNighteye()
    mwse.log("Disabling")
    mwscript.removeSpell({reference=tes3.getPlayerRef(), spell=getSpell()})
end

function enableNighteye()
    mwse.log("Enabling")
    local nightEyeSpell = tes3.getObject(SPELL_ID)
    mwse.log("NE - " .. nightEyeSpell.id)
    mwscript.addSpell({reference=tes3.getPlayerRef(), spell=getSpell()})
end

function hasNighteye()
    local player = tes3.getPlayerRef().object
    return player.spells:contains(SPELL_ID)
end

function toggleNighteye()
    if(hasNighteye()) then
        disableNighteye()
    else
        enableNighteye()
    end
end

function handleKeyPress(e)
    if(e.keyCode == 110) then
        toggleNighteye()
    end
end

event.register("keyDown", handleKeyPress)