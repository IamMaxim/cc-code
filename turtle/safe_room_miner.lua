

width = 32
height = 10
depth = 32

digDir = "right"

-- Refuel
turtle.select(1)
turtle.refuel()
turtle.select(2)

-- Layout for the turtle inventory:
--   1st slot is a fuel slot.
--   Starting from the 2nd block goes blocks that are used to build walls.
--   Starting from the end goes resource slots. Put at least one item to these slots, so the turtle will fill the rest.


function selectSlot()
    if turtle.getItemCount() == 0 then
        for i=2,16 do
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

function doStep(x, y, z)
    dig()
    forward()

    if x == 1 then
        if digDir == "right" then
            turnLeft()
            if not detect() then
                place()
            end
            turnRight()
        else
            turnRight()
            if not detect() then
                place()
            end
            turnLeft()
        end
    end

    if x == width then
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

    if y == height then
        if not detectUp() then
            placeUp()
        end
    end
end

-- Enter the dig zone
doStep(1, 1, 0)

-- Mine the room
for y=1,height do
    for x=1,width do
        for z=1,depth-1 do
            doStep(x, y, z)
        end
        
        -- If last block reached, check that wall exists
        if not detect() then
            place()
        end
        
        -- If this is not the last row, move to the next one
        if x ~= width then
            if digDir == "right" then
                turnRight()
                dig()
                forward()
                
                turnLeft()
                if not detect() then
                    place()
                end
                turnRight()
                
                turnRight()
                digDir = "left"
            else
                turnLeft()
                dig()
                forward()
                
                turnRight()
                if not detect() then
                    place()
                end
                turnLeft()
                
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
            turtle.select(2)
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