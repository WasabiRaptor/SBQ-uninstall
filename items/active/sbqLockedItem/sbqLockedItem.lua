function init()
	activeItem.setHoldingItem(false)
end

local clean
function update(dt)
	while clean ~= true do

		world.sendEntityMessage(entity.id(), "primaryItemLock", false)
		world.sendEntityMessage(entity.id(), "altItemLock", false)

		clean = true
		local lockedItemList = player.getProperty("sbqLockedItems")
		for i, lockedItemData in pairs(lockedItemList or {}) do
			player.giveItem(lockedItemData)
			table.remove(lockedItemList, i)
			clean = false
		end

		player.setProperty("sbqLockedItems", lockedItemList)

		if clean then
			for slotname, itemDescriptor in pairs(storage.lockedEssentialItems or {}) do
				player.giveEssentialItem(slotname, itemDescriptor)
			end
		end
	end
end
