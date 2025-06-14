local stencilShader

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    backgroundImage = love.graphics.newImage("bunker.jpg")
    love.window.setMode(backgroundImage:getWidth(), backgroundImage:getHeight())
    circleRadius = 100
    overlayColor = {0, 0, 0, 0.7}
    stencilShader = love.graphics.newShader [[
        extern vec2 mousePos;
        extern float radius;

        vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
            float dist = distance(screen_coords, mousePos);
            if (dist > radius) {
                discard;
            }
            return Texel(texture, texture_coords);
        }
    ]]
end

function love.update(dt)

end

function love.draw()
    local mouseX, mouseY = love.mouse.getPosition()
    love.graphics.draw(backgroundImage, 0, 0)
    love.graphics.setColor(overlayColor)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.setShader(stencilShader)
    stencilShader:send("mousePos", {mouseX, mouseY})
    stencilShader:send("radius", circleRadius)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(backgroundImage, 0, 0)
    love.graphics.setShader()
end

function love.quit()

end
