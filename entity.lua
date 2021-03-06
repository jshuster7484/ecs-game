local component = require("component")

local entity = {}

-- Player Entity
function entity.player(x, y)
    return {
        player = true,
        position = component.position(x, y),
        collision = component.collision(16),
        velocity = component.velocity(0, 0, 20, 0, 300),
        health = component.health(4),
        power = component.power(1),
        sound = {
            die = component.sound("resources/audio/explode.wav")
        },
        sprite = component.sprite("resources/sprites/ship.png", 16, 16),
        FRICTION = 4
    }
end

function entity.enemy(x, y, x_speed, y_speed)
    return {
        enemy = true,
        projectile = true,
        drop = true,
        position = component.position(x, y),
        collision = component.collision(10),
        velocity = component.velocity(x_speed, y_speed, 0, 0, 1000),
        target = "player",
        damage = 4,
        sound = {
            die = component.sound("resources/audio/explode.wav")
        },
        health = component.health(2),
        sprite = component.sprite("resources/sprites/enemy one.png", 16, 16)
    }
end

function entity.enemySpawner()
    return {
        spawner = true,
    }
end

function entity.laser(x, y, x_speed, y_speed, target)
    return {
        projectile = true,
        position = component.position(x, y),
        collision = component.collision(4),
        velocity = component.velocity(x_speed, y_speed, 0, 0, 1000),
        target = target,
        damage = 1,
        sound = {
            fire = component.sound("resources/audio/laser.wav"),
            hit = component.sound("resources/audio/hit.wav")
        },
        sprite = component.sprite("resources/sprites/laser.png", 4, 8)
    }
end

function entity.enemyLaser(x, y, x_speed, y_speed, target)
    return {
        projectile = true,
        position = component.position(x, y),
        collision = component.collision(4),
        velocity = component.velocity(x_speed, y_speed, 0, 0, 1000),
        target = target,
        damage = 1,
        sound = {
            fire = component.sound("resources/audio/enemy laser.wav"),
            hit = component.sound("resources/audio/hit.wav")
        },
        sprite = component.sprite("resources/sprites/enemy laser.png", 4, 8)
    }
end

function entity.explosion(x, y)
    return {
        position = component.position(x, y),
        sprite = component.sprite("resources/sprites/explosion center.png", 32, 32),
        timer = component.timer(0.25)
    }
end

function entity.powerup(x, y)
    return {
        collision = component.collision(4),
        position = component.position(x, y),
        powerup = true,
        sound = {
            pickup = component.sound("resources/audio/powerup.wav")
        },
        sprite = component.sprite("resources/sprites/laser powerup.png", 14, 14),
        target = "player",
        velocity = component.velocity(0, 100, 0, 0, 1000),
    }
end

return entity