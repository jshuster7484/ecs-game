-- Player Laser System
local entity = require("entity")
local laser = entity.laser

laserSystem = tiny.processingSystem()
laserSystem.filter = tiny.requireAll("player", "position")
laserSystem.interval = 0.25

function laserSystem:process(entity)
    if entity.fire then
        distributedShot(entity, laser)
        -- scatterShot(entity, laser)
    end
end

function flatDistribution(max, i)
    local d = 20 -- distance b/w lasers
    return -(d/2)*(max-1) + (i-1)*d
end

function distributedShot(player, laser)
    local maxPower = player.power.amount
    for i=1, maxPower do
        local laser = laser(player.position.x + flatDistribution(maxPower, i), player.position.y-8, 0, -400, "enemy")
        world:add(laser)
    end
end

function scatterVelocity(max, i)
    local v = 20 -- horizontal velocity increments
    return -(v/2)*(max-1) + (i-1)*v
end

function scatterShot(player, laser)
    local maxPower = player.power.amount
    lasers = {}
    for i=1, maxPower do
        table.insert(lasers ,laser(player.position.x + flatDistribution(maxPower, i), player.position.y-8, scatterVelocity(maxPower, i), -400, "enemy"))
    end
        world:add(unpack(lasers))
end


return laserSystem