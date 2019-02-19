-- local tiny = require("libraries/tiny")
local component = require("component")
local utils = require("libraries/utils")
local math = require("libraries/math")

-- Get some entities
local entity = require("entity")
local laser = entity.laser
local enemy = entity.enemy
local powerup = entity.powerup
local explosion = entity.explosion

local system = {}

-- Player Input System
system.playerInput = tiny.processingSystem()
system.playerInput.filter = tiny.requireAll("player", "velocity")
function system.playerInput:process(entity)
    -- Get the input
    local x_input = utils.integer(love.keyboard.isDown("right"))-utils.integer(love.keyboard.isDown("left"))
    local y_input = utils.integer(love.keyboard.isDown("down"))-utils.integer(love.keyboard.isDown("up"))
    local input = math.distance(0, 0, x_input, y_input)
    local velocity, acceleration = entity.velocity, entity.velocity.acceleration

    -- Get fire input
    entity.fire = love.keyboard.isDown("space")

    -- Set the friction
    entity.velocity.friction = entity.FRICTION*utils.integer(input == 0)

    -- Add the input to the velocity
    velocity.x = velocity.x+x_input*acceleration
    velocity.y = velocity.y+y_input*acceleration
end

-- Friction System
system.friction = tiny.processingSystem()
system.friction.filter = tiny.requireAll("position", "velocity")
function system.friction:process(entity)
    local speed = math.distance(0, 0, entity.velocity.x, entity.velocity.y)
    if speed > entity.velocity.friction then
        local x, y = math.normalize(entity.velocity.x, entity.velocity.y)
        entity.velocity.x = entity.velocity.x - entity.velocity.friction * x
        entity.velocity.y = entity.velocity.y - entity.velocity.friction * y
    else
        entity.velocity.x = 0
        entity.velocity.y = 0
    end
end

-- Movement System
system.movement = tiny.processingSystem()
system.movement.filter = tiny.requireAll("position", "velocity")
function system.movement:process(entity, delta_time)
    -- Clamp the velocity
    local length = math.distance(0, 0, entity.velocity.x, entity.velocity.y)
    if length > entity.velocity.max_speed then
        entity.velocity.x, entity.velocity.y = math.normalize(entity.velocity.x, entity.velocity.y)
        entity.velocity.x = entity.velocity.x * entity.velocity.max_speed
        entity.velocity.y = entity.velocity.y * entity.velocity.max_speed
    end

    -- Move the entity
    local last_x, last_y = entity.position.x, entity.position.y
    entity.position.x = entity.position.x + entity.velocity.x * delta_time
    entity.position.y = entity.position.y + entity.velocity.y * delta_time

    -- Maybe I should make this its own system?
    if entity.player ~= nil then
        local x, y = entity.position.x, entity.position.y
        if x < 0 or x > 1200 then entity.position.x = last_x entity.velocity.x = -entity.velocity.x end
        if y < 0 or y > 1200 then entity.position.y = last_y entity.velocity.y = -entity.velocity.y end
    end
end

-- Projectile Collision System
system.projectileCollision = tiny.processingSystem()
system.projectileCollision.filter = tiny.requireAll("projectile", "damage", "target", "collision")
function system.projectileCollision:process(entity)
    local filter = tiny.requireAll(entity.target, "collision")
    for i=1, #self.world.entities do
        local loopEntity = self.world.entities[i]
        if filter(self.world, loopEntity) then
            local distance = math.distance(entity.position.x, entity.position.y, loopEntity.position.x, loopEntity.position.y)
            if distance <= entity.collision.radius + loopEntity.collision.radius then
                loopEntity.health.amount = loopEntity.health.amount - entity.damage
                if entity.sound and entity.sound.hit then love.audio.play(entity.sound.hit) end
                self.world:remove(entity)
            end
        end
    end
end

-- Zero Health System
system.noHealth = tiny.processingSystem()
system.noHealth.filter = tiny.requireAll("position", "health")
function system.noHealth:process(entity)
    if entity.health.amount <= 0 then
        self.world:add(explosion(entity.position.x, entity.position.y))
        self.world:remove(entity)
        if entity.sound and entity.sound.die then love.audio.play(entity.sound.die) end
    end
end

-- Timer System
system.timer = tiny.processingSystem()
system.timer.filter = tiny.requireAll("timer")
function system.timer:process(entity, delta_time)
    local timer = entity.timer
    timer.duration = timer.duration - delta_time
    -- print(timer.duration)
    if timer.duration <= 0 then
        self.world:remove(entity)
    end
end

-- Draw System
system.draw = tiny.processingSystem()
system.draw.filter = tiny.requireAll("position", "sprite")
system.draw.active = false
function system.draw:process(entity)
    if sprite.quad then 
        love.graphics.draw(entity.sprite.image, sprite.quad, entity.position.x, entity.position.y)
    end
    love.graphics.draw(entity.sprite.image, entity.position.x-entity.sprite.origin.x, entity.position.y-entity.sprite.origin.y)
end

return system