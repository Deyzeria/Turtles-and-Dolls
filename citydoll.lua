-- Inspired by that one r/Minecraft post about a person making cities out of just random towers of blocks, with torch on top. 
-- Exists to do just that- Place down a tower of blocks, move forward, down, and repeat another tower. 

function refuel()
    local currentSlot = turtle.getSelectedSlot()
    if turtle.getFuelLevel() < 20 then
        turtle.select(16)
        turtle.refuel()
        turtle.select(currentSlot)
    end
end

function selectSlot()
    local currentSlot = turtle.getSelectedSlot()
    if turtle.getItemCount(currentSlot) > 0 then
        return true
    end
    if (currentSlot = 14) then
        return false
    else
        turtle.select(currentSlot + 1)
        return true
    end
end

function selectAndPlaceTorch()
    local currentSlot = turtle.getSelectedSlot()
    if turtle.getItemCount(15) > 0 then
        turtle.select(15)
        turtle.up()
        turtle.placeDown()
        turtle.select(currentSlot)
        return true
    else
        return false
    end
end

function moveAndPlace(height)
    for i = 1,height,1
    do
        turtle.up()
        if not selectSlot() then
            return false
        end
        turtle.placeDown()
    end
    refuel()
    return selectAndPlaceTorch()
end

setComputerLabel("City Doll")

while true do
    local height = math.random(1, 10)
    local status = moveAndPlace(height)
    if not status then
        break
    end

    -- Return back to starting position- Move forward, move down X + 1 steps.
    turtle.forward()
    for i = height,0,-1
    do
        turtle.down()
    end
    local ok, blockBelow = turtle.inspectDown()
    if not ok then
        break
    else
        if blockBelow.name == "minecraft:stone" then
            turtle.forward()
        elseif blockBelow.name == "" -- Check for the limit of the area
            -- We turn right, move forward, turn right again, and then either restart from there, or if we want a better restart of resources, we return to the starting x
            -- If we want refuelling of all stuff, we should also have incremental y position, so we can place a check with all the resources there.
        end
    end
end

setComputerLabel("Sleeping Doll")
