-- Inspired by that one r/Minecraft post about a person making cities out of just random towers of blocks, with torch on top. 
-- Exists to do just that- Place down a tower of blocks, move forward, down, and repeat another tower. 

local function refuel()
    local currentSlot = turtle.getSelectedSlot()
    if (turtle.getFuelLevel() < 2) then
        turtle.select(16)
        turtle.refuel()
        turtle.select(currentSlot)
    end
end

local function tForward()
    refuel()
    turtle.forward()
end

local function tUp()
    refuel()
    turtle.forward()
end

local function tDown()
    refuel()
    turtle.tDown()
end

local function selectSlot()
    local currentSlot = turtle.getSelectedSlot()
    if (turtle.getItemCount(currentSlot) > 0) then
        return true
    end
    if (currentSlot == 14) then
        return false
    else
        turtle.select(currentSlot + 1)
        return true
    end
end

local function selectAndPlaceTorch()
    local currentSlot = turtle.getSelectedSlot()
    if (turtle.getItemCount(15) > 0) then
        turtle.select(15)
        tUp()
        turtle.placeDown()
        turtle.select(currentSlot)
        return true
    else
        return false
    end
end

local function moveAndPlace(height)
    for i = 1,height,1
    do
        tUp()
        if (not selectSlot()) then
            return false
        end
        turtle.placeDown()
    end
    return selectAndPlaceTorch()
end

os.setComputerLabel("City Doll")
refuel()
turtle.forward()
lastTurtleTurnRight = false

while true do
    local height = math.random(0, 6)
    if (not moveAndPlace(height)) then
        break
    end

    -- Return back to starting position- Move forward, move down X + 1 steps.
    tForward()
    for i = height,0,-1
    do
        tDown()
    end
    
    local ok, blockBelow = turtle.inspectDown()
    if (not ok) then
        break
    else
        if (blockBelow.name == "minecraft:stone") then
            if (lastTurtleTurnRight) then
                turtle.turnLeft()
                tForward()
                turtle.turnLeft()
            else
                turtle.turnRight()
                tForward()
                turtle.turnRight()
            end
            tForward()
        end
    end
end

os.setComputerLabel("Sleeping Doll")
