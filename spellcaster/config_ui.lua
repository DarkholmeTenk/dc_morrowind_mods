local skills = { [0] = "Alteration", "Conjuration", "Destruction", "Illusion", "Mysticism", "Restoration" }

local ui = {}

local function buildSkillStack(container, config, label)
    local c2 = container:createThinBorder()
    c2.layoutWidthFraction = 1
    c2.autoHeight = true
    c2.borderBottom = 2
    c2.flowDirection = "top_to_bottom"
    c2:createLabel({text="Skill: " .. label})
    local disable = darkcraft.ui.buildToggleButton(c2, {label="Disable vanilla skill gain?", current=config.disable})
    c2:createLabel({text="Magicka Cost Sqrt Contribution"})
    local sqrt = darkcraft.ui.buildSlider(c2, {current=config.sqrt, min=0,max=5, step=0.05,jump=0.5})
    c2:createLabel({text="Magicka Cost Linear Contribution"})
    local lin = darkcraft.ui.buildSlider(c2, {current=config.linear, min=0,max=5, step=0.05,jump=0.5})
    c2:createLabel({text="Magicka Cost Square Contribution"})
    local sqr = darkcraft.ui.buildSlider(c2, {current=config.sqr, min=0,max=5, step=0.05,jump=0.5})
    c2:createLabel({text="Constant Contribution"})
    local const = darkcraft.ui.buildSlider(c2, {current=config.const, min=0,max=5, step=0.05,jump=0.5})
    return function()
        return {
            disable = disable.getValue(),
            sqrt = disable.getValue(),
            const = const.getValue(),
            linear = lin.getValue(),
            sqr = sqr.getValue()
        }
    end
end

local function buildTotalStack(container, config)
    local data = config.getData()
    local uiArr = {}
    for i,v in pairs(skills) do
        uiArr[i] = buildSkillStack(container, data[i], v)
    end
    return function()
        local newData = {}
        for i,v in pairs(uiArr) do
            newData[i] = v()
        end
        config.setData(newData)
    end
end

ui.getPackage = function(config)
    local p = {}
    local save = nil
    p.onCreate = function(container)
        mwse.log("Creating UI")
        local scroller = container:createVerticalScrollPane()
        scroller.layoutWidthFraction=1
        scroller.layoutHeightFraction=1
        save = buildTotalStack(scroller, config)
    end
    p.onClose = function(container)
        save()
    end
    return p
end

return ui