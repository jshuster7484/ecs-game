-- Drop System
local entity = require("entity")
local powerup = entity.powerup

dropSystem = tiny.processingSystem()
dropSystem.filter = tiny.requireAll("health", "enemy", "drop")
function dropSystem:process(entity)
    if entity.health.amount <= 0 then
        world:add(powerup(entity.position.x, entity.position.y))
    end
end

return dropSystem