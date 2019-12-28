

width = 6
height = 4
depth = 32

digDir = "right"

-- Refuel
turtle.select(1)
turtle.refuel()
turtle.select(2)

-- Layout for the turtle inventory:
--   1st slot is a fuel slot.
--   2nd slot is an ender chest slot. This chest is used to offload mined resources.
--   Starting from the 3nd block goes blocks that are used to build walls.
--  --   Starting from the end goes resource slots. Put at least one item to these slots, so the turtle will fill the rest.
-- Resource offloading goes starting from the 4th slot.


function selectSlot()
    if turtle.getItemCount() == 0 then
        for i=3,16 do
            if turtle.getItemCount(i) ~= 0 then
                turtle.select(i)
                break
            end
        end
    end
end

function dig()
    turtle.dig()
end

function digUp()
    return turtle.digUp()
end

function turnRight()
    return turtle.turnRight()
end

function turnLeft()
    return turtle.turnLeft()
end     

function forward()
    while not turtle.forward() do
        dig()
    end
    return true
end

function up()
    return turtle.up()
end

function down()
    return turtle.down()
end

function detect()
    return turtle.detect()
end

function detectUp()
    return turtle.detectUp()
end

function detectDown()
    return turtle.detectDown()
end

function place()
    selectSlot()
    return turtle.place()
end

function placeUp()
    selectSlot()
    return turtle.placeUp()
end

function placeDown()
    selectSlot()
    return turtle.placeDown()
end

function getFuelPercentage()
    return turtle.getFuelLevel() * 100 / turtle.getFuelLimit()
end

function offloadResources()
	-- Select the ender chest
	turtle.select(2)
	-- Clear up space below for the ender chest
	turtle.digDown()
	-- Place the ender chest below
	turtle.placeDown()
	for i=4,16 do
		turtle.select(i)
		turtle.dropDown()
	end
--	turtle.select(2)
	-- Dig the ender chest
	turtle.digDown()
	-- Select the first building block
	turtle.select(3)
end

function doStep(x, y, z)
    dig()
    forward()
end

-- Enter the dig zone
doStep(1, 1, 0)

-- Mine the room
for y=1,height do
    for x=1,width do
        for z=1,depth-1 do
            doStep(x, y, z)
        end
        
        -- If this is not the last row, move to the next one
        if x ~= width then
            if digDir == "right" then
                turnRight()
                dig()
                forward()
                turnRight()
                digDir = "left"
            else
                turnLeft()
                dig()
                forward()
                turnLeft()
                digDir = "right"
            end
        else
            if digDir == "right" then
                turnRight()
                if not detect() then
                    place()
                end
                turnLeft()
            else
                turnLeft()
                if not detect() then
                    place()
                end
                turnRight()
            end
        end

        if getFuelPercentage() < 50 then
            turtle.select(1)
            turtle.refuel(1)
            turtle.select(3)
        end
		
		if turtle.getItemCount(16) != 0 then
			offloadResources()
		end
    end
    
    if y ~= height then
        digUp()
        up()
        if digDir == "right" then
            turnLeft()
            digDir = "left"
        else
            turnRight()
            digDir = "right"
        end
    end
end