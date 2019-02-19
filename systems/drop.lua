-- Drop System
local entity = require("entity")
local math = require("libraries/math")
local powerup = entity.powerup

dropSystem = tiny.processingSystem()
dropSystem.filter = tiny.requireAll("health", "enemy", "drop")
function dropSystem:process(entity)
    if entity.health.amount <= 0 then
        if math.prandom(0,10) <= 1 then
            world:add(powerup(entity.position.x, entity.position.y))
        end
    end
end

return dropSystem