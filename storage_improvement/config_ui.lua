local config = require("darkcraft.storage_improvement.config")

local function getPackage()
    local package = {}
    local slider = nil

    package.onCreate = function(container)
        container:createLabel({text = "Container Capacity Multiplier"})
        slider = darkcraft.ui.createSlider(container, {current=config.getCapacityIncrease(), min=0,max=20, step=0.1,jump=1})
        slider.layoutWidthFraction = 1
    end

    package.onClose = function(container)
        config.setCapacityIncrease(slider.getValue())
    end
    return package
end

local function registerModConfig(e)
    mwse.registerModConfig("DC - Storage Improvement", getPackage())
end
event.register("modConfigReady", registerModConfig)