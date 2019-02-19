-- Enemy Spawn System
local maths = require("libraries/math")
local entity = require("entity")
local enemy = entity.enemy

enemySpawnSystem = tiny.processingSystem()
enemySpawnSystem.filter = tiny.requireAll("spawner")
enemySpawnSystem.interval = 1
function enemySpawnSystem:process(entity)
    local power = PLAYER.power.amount
    local minimumTime = 0.1
    local maximumTime = math.max(3 - power * 0.1, 0.15)
    self.interval = maths.prandom(minimumTime, maximumTime)
    local x, y = maths.prandom(20, 1180), -15
    self.world:add(enemy(x, y, 0, 100))
end

return enemySpawnSystem