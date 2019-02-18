local tiny = require("libraries/tiny")
local system = require("system")
local entity = require("entity")
local component = require("component")

game = {
    window = {
        width = 0,
        height = 0
    },
    
    view = {
        width = 180,
        height = 320
    }
}

-- Load
function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    game.world = initializeECSWorld()
    local sound = love.audio.newSource("resources/audio/music.mp3", "stream")
    love.audio.play(sound)
end

-- Update
function love.update(delta_time)
    game.world:update(delta_time)
end

-- Draw
function love.draw()
    love.graphics.push()
    love.graphics.scale(1/.5, 1/.5)
    system.draw:update()
    love.graphics.pop()
end

-- Initialize the ECS world
function initializeECSWorld()
    return tiny.world(
        entity.player(90, 300),
        entity.enemySpawner(),

        system.enemySpawner,
        system.playerInput,
        system.playerLaser,
        system.friction,
        system.movement,
        system.projectileCollision,
        system.noHealth,
        system.timer,
        system.destroyOffscreen,
        system.draw
    )
end