-- Offscreen System
offscreenSystem = tiny.processingSystem()
offscreenSystem.filter = tiny.requireAll("position")
function offscreenSystem:process(entity)
    if entity.position.y < -32 or entity.position.y > 1200 then
        world:remove(entity)
    elseif entity.position.x < -10 or entity.position.x > 1210 then
        world:remove(entity)
    end
end

return offscreenSystem