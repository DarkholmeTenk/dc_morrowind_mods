local inventory = {}

inventory.getTotalWeight = function(inv)
    local weight = 0
    for stack in tes3.iterate(inv.iterator) do
		-- Store the item for later removal.
		local item = stack.object
        local c = stack.count
        if(item.weight ~= nil) then
            weight = weight + (item.weight * c)
        end
    end
    return weight
end

return inventory