

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

function place()
    return turtle.place()
end

-- Enter the dig zone
dig()
forward()

-- Mine the room
for y=1,height do
    for x=1,width do
        for z=1,depth-1 do
            dig()
            forward()

            if x == 1 then
                if digDir == "right" then
                    turnLeft()
                    if not detect() then
                        selectSlot()
                        place()
                    end
                    turnRight()
                else
                    turnRight()
                    if not detect() then
                        selectSlot()
                        place()
                    end
                    turnLeft()
                end
            end

            if x == width then
                if digDir == "right" then
                    turnRight()
                    if not detect() then
                        selectSlot()
                        place()
                    end
                    turnLeft()
                else
                    turnLeft()
                    if not detect() then
                        selectSlot()
                        place()
                    end
                    turnRight()
                end
            end
        end
        
        if not detect() then
            selectSlot()
            place()
        end
        
        if x ~= width then
            if digDir == "right" then
                turnRight()
                dig()
                forward()
                
                turnLeft()
                if not detect() then
                    selectSlot()
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
                    selectSlot()
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