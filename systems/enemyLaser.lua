-- Enemy Laser System
local entity = require("entity")
local math = require("libraries/math")
local enemyLaser = entity.enemyLaser

enemyLaserSystem = tiny.processingSystem()
enemyLaserSystem.filter = tiny.requireAll("enemy", "position")
enemyLaserSystem.interval = 1

function enemyLaserSystem:process(entity)
    if math.prandom(0,4) <= 1 then
        local enemyLaser = enemyLaser(entity.position.x, entity.position.y+8, 0, 300, "player")
        world:add(enemyLaser)
        love.audio.play(enemyLaser.sound.fire)
    end
end

return enemyLaserSystem