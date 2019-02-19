-- Powerup System
local entity = require("entity")
local math = require("libraries/math")

powerupSystem = tiny.processingSystem()
powerupSystem.filter = tiny.requireAll("position", "collision", "powerup")

function powerupSystem:process(entity)
    local distance = math.distance(entity.position.x, entity.position.y, PLAYER.position.x, PLAYER.position.y)
    if distance <= entity.collision.radius + PLAYER.collision.radius then
        PLAYER.power.amount = PLAYER.power.amount + 1
        if entity.sound and entity.sound.pickup then love.audio.play(entity.sound.pickup) end
        self.world:remove(entity)
    end

    -- Power increases with time
    -- entity.power.time = entity.power.time + 1
    -- if entity.power.time%500 == 0 then
    --     entity.power.amount = entity.power.amount + 1
    -- end
end

return powerupSystem