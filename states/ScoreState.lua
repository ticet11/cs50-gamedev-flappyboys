ScoreState = Class {
    __includes = BaseState
}

local goldAward = love.graphics.newImage('gold-award.png')
local silverAward = love.graphics.newImage('silver-award.png')
local woodAward = love.graphics.newImage('wood-award.png')

function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    love.graphics.setFont(flappyFont)
    if self.score > 11 then
        love.graphics.printf('Wow, gold! Excellent!', 0, 64, VIRTUAL_WIDTH, 'center')
        love.graphics.draw(goldAward, VIRTUAL_WIDTH / 2 - 36, VIRTUAL_HEIGHT / 2 - 28)
    elseif self.score > 4 then
        love.graphics.printf('Silver is pretty good!', 0, 64, VIRTUAL_WIDTH, 'center')
        love.graphics.draw(silverAward, VIRTUAL_WIDTH / 2 - 36, VIRTUAL_HEIGHT / 2 - 28)
    elseif self.score > 0 then
        love.graphics.printf('No bronze left, so this is wood!', 0, 64, VIRTUAL_WIDTH, 'center')
        love.graphics.draw(woodAward, VIRTUAL_WIDTH / 2 - 36, VIRTUAL_HEIGHT / 2 - 28)
    else
        love.graphics.printf("Oof, that's rough!", 0, 64, VIRTUAL_WIDTH, 'center')
    end

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    love.graphics.printf('Press Enter to go again!', 0, 160, VIRTUAL_WIDTH, 'center')
end
