PauseState = Class {
    __includes = BaseState
}

function PauseState:update(dt)
    if love.keyboard.wasPressed('p') then
        gStateMachine:change('play')
    end
end