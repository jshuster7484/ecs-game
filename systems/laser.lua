local tiny = require("libraries/tiny")

-- Get some entities
local entity = require("entity")
local laser = entity.laser

-- Player Laser System
laserSystem = tiny.processingSystem()
laserSystem.filter = tiny.requireAll("player", "position")
laserSystem.interval = 0.25
function laserSystem:process(entity)
    local laser_one = laser(entity.position.x-12, entity.position.y-8, 0, -400, "enemy")
    self.world:add(
        laser_one,
        laser(entity.position.x+12, entity.position.y-8, 0, -400, "enemy")
    )
    love.audio.play(laser_one.sound.fire)
end

return laserSystem