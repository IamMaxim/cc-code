

function newFuelInfo(max, current)
	FuelInfo = {
		fuelLevel = current,
		maxLevel = max
	}

	FuelInfo.add = function(value)
		FuelInfo.fuelLevel += value
	end
	
	FuelInfo.currentLevel = function()
		return FuelInfo.fuelLevel
	end
	
	FuelInfo.percentage = function()
		return FuelInfo.luelLevel * 100 / FuelInfo.maxLevel
	end
end 