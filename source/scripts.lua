function new_animation(image, width, height, duration)
    local animation = {}
    animation.spriteSheet = image;
    animation.width = width;
    animation.height = height;
    animation.quads = {};

    for y = 0, image:getHeight() - height, height do
        for x = 0, image:getWidth() - width, width do
            table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
        end
    end

    animation.duration = duration or 1
    animation.currentTime = 0

    function animation:update(dt)
        animation.currentTime = animation.currentTime + dt
        if animation.currentTime >= animation.duration then
            animation.currentTime = animation.currentTime - animation.duration
        end
    end

    function animation:draw(x, y, sx, sy)
        local spriteNum = math.floor(animation.currentTime / animation.duration * #animation.quads) + 1
        love.graphics.draw(
            animation.spriteSheet,
            animation.quads[spriteNum],
            x,
            y,
            0,
            sx,
            sy
        )
    end

    return animation
end

return {
    new_animation = new_animation
}