local component = {}

-- Position
function component.position(x, y)
    return {x = x, y = y}
end

-- Collision
function component.collision(radius)
    return {radius = radius}
end

-- Velocity
function component.velocity(x, y, acceleration, friction, max_speed)
    return {
        x = x,
        y = y,
        acceleration = acceleration,
        friction = friction,
        max_speed = max_speed
    }
end

-- Health
function component.health(amount)
    return {
        amount = amount,
        max = amount
    }
end

-- Image
function component.sprite(string, origin_x, origin_y)
    return {
        image = love.graphics.newImage(string),
        origin = {x = origin_x, y = origin_y}
    }
end

-- Timer
function component.timer(duration)
    return {duration = duration}
end

-- Sound
function component.sound(string)
    return love.audio.newSource(string, "static")
end

-- Return the component object
return component