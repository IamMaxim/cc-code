

width = 3
height = 2
depth = 3

digDir = "right"

-- Refuel
turtle.select(1)
turtle.refuel()

function selectSlot()
    if turtle.getItemCount() == 0 then
        for i=1,16 do
            if turtle.getItemCount(i) ~= 0 then
                turtle.select(i)
                break
            end
        end
    end
end

function dig()
    while turtle.detect() do
        turtle.dig()
        os.sleep(1)
    end
    return true
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
    return turtle.forward()
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
dig()
forward()

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