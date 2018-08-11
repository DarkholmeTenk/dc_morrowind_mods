local ui = {}

ui.buildToggleButton = function(container, data)
    local label = data.label or "BUTTON!!!"
    local trueLabel = data.trueLabel or "True"
    local falseLabel = data.falseLabel or "False"
    local current = data.current
    local onChange = data.onChange

    local c2 = container:createBlock()
    c2.flowDirection = "left_to_right"
    c2.layoutWidthFraction = 1
    c2.autoHeight = true

    local label = c2:createLabel({ text = label })
    label.layoutOriginFractionX = 0.0

    -- Button that toggles the config value.
    local button = c2:createButton({ text = "Loading" })
    button.layoutOriginFractionX = 1.0
    button.paddingTop = 3

    local refreshText = function()
        if(current) then
            button.text = trueLabel
        else
            button.text = falseLabel
        end
        if(onChange ~= nil) then
            onChange(current)
        end
    end
    refreshText()

    local onButtonClick = function()
        current = not current
        refreshText()
    end
    button:register("mouseClick", onButtonClick)

    return {
        container = c2,
        label = label,
        button = button,
        getValue = function() return current end
    }
end

ui.buildSlider = function(container, data)
    local step = data.step or 1
    local jump = data.jump or 5
    local min = data.min or 0
    local max = data.max or 100
    local current = data.current or 0
    local format = data.format or "Current: %.1f"
    local onChange = data.onChange

    local c2 = container:createBlock()
    c2.flowDirection = "left_to_right"
    c2.layoutWidthFraction = 1
    c2.autoHeight = true

    local function numToSlider(num)
        return (num - min) / step
    end

    local function sliderToNum(slider)
        return (slider * step) + min
    end
    
    local slider = c2:createSlider({current=numToSlider(current), max=numToSlider(max), step=1, jump = jump/step})
    slider.layoutWidthFraction = 1
    local label = c2:createLabel({text="Loading"})
    label.minWidth = 140

    local function handleOnChange()
        local v = sliderToNum(slider.widget.current)
        label.text = string.format(format, v)
        if(onChange ~= nil) then
            onChange(v)
        end
    end
    slider:register("PartScrollBar_changed", handleOnChange)
    handleOnChange()
    local ret = {
        container=c2,
        slider=slider,
        label=label
    }
    ret.getValue = function()
        return sliderToNum(slider.widget.current)
    end
    return ret
end

return ui