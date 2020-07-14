-- inherits from BaseState
TitleScreenState = Class {
    __includes = BaseState
}

function TitleScreenState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function TitleScreenState:render()
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Flappy Boys', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Press the Spacebar or click to jump', 0, 130, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press P to pause', 0, 150, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press Enter to begin', 0, 192, VIRTUAL_WIDTH, 'center')
end
