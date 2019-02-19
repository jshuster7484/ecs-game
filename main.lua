tiny = require("libraries/tiny")
local system = require("system")
local entity = require("entity")
local component = require("component")

local drawFilter = tiny.requireAll("sprite")
local updateFilter = tiny.rejectAny("sprite")

game = {
    window = {
        width = 0,
        height = 0
    },
    
    view = {
        width = 1200,
        height = 1200
    }
}

-- Load
function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    game.world = initializeECSWorld()
    local sound = love.audio.newSource("resources/audio/music.mp3", "stream")
    love.audio.play(sound)

    -- Profiling
    -- love.profiler = require("libraries/profile")
    -- love.profiler.hookall("Lua")
    -- love.profiler.start()
end

-- Update

-- Profiling
-- love.frame = 0


function love.update(dt)

    -- Profiling
    -- love.frame = love.frame + 1


    local dt = love.timer.getDelta()
    game.world:update(dt, updateFilter)

    -- Profiling
    -- if love.frame%100 == 0 then
    --     love.report = love.profiler.report('time', 20)
    --     love.profiler.reset()
    -- end
end

-- Draw
function love.draw()
    system.draw:update()

    local dt = love.timer.getDelta()
    -- game.world:update(dt, drawFilter)
    -- love.graphics.print(love.report or "Please wait...")
end

-- Initialize the ECS world
function initializeECSWorld()
    return tiny.world(
        entity.player(600, 1180),
        entity.enemySpawner(),

        system.enemySpawner,
        system.playerInput,
        system.laserSystem,
        system.friction,
        system.movement,
        system.projectileCollision,
        system.powerupCollision,
        system.noHealth,
        system.timer,
        system.destroyOffscreen,
        system.draw
    )
end