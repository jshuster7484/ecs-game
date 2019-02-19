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
    world = initializeECSWorld()
    local sound = love.audio.newSource("resources/audio/music.mp3", "stream")
    love.audio.play(sound)

    -- Profiling
    -- love.profiler = require("libraries/profile")
    -- love.profiler.hookall("Lua")
    -- love.profiler.start()
end


-- Profiling
-- love.frame = 0

-- Update
function love.update(dt)

    -- Profiling
    -- love.frame = love.frame + 1


    local dt = love.timer.getDelta()
    world:update(dt, updateFilter)

    -- Profiling
    -- if love.frame%100 == 0 then
    --     love.report = love.profiler.report('time', 20)
    --     love.profiler.reset()
    -- end
end

-- Draw
function love.draw()
    system.draw:update()

    -- Draw FPS & Entity Count
    love.graphics.print("FPS: " .. love.timer.getFPS(), 1100, 0)
    love.graphics.print("Entities: " .. tiny.getEntityCount(world), 1100, 20)
    if PLAYER then
        love.graphics.print("Power: " .. PLAYER.power.amount, 1100, 40)
    end

    -- Profiling
    -- local dt = love.timer.getDelta()
    -- love.graphics.print(love.report or "Please wait...")
end

-- Initialize the ECS world
function initializeECSWorld()
    PLAYER = entity.player(600, 1180) -- Globally available player
    return tiny.world(
        PLAYER,
        entity.enemySpawner(),

        require("systems.enemySpawn"),
        system.playerInput,
        require("systems.laser"),
        system.friction,
        system.movement,
        system.projectileCollision,
        require("systems.powerup"),
        require("systems.drop"),
        system.noHealth,
        system.timer,
        require("systems.offscreen"),
        system.draw
    )
end