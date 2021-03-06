PlayState = Class {
    __includes = BaseState
}

local woodPlaque = love.graphics.newImage('wood-plaque.png')

PIPE_SPEED = 60
PIPE_HEIGHT = 288
PIPE_WIDTH = 46

BIRD_WIDTH = 26
BIRD_HEIGHT = 26

function PlayState:init()
    self.bird = Bird()
    self.pipePairs = {}
    self.timer = 0
    self.spawnTime = math.random(1, 3)
    self.paused = false

    self.score = 0

    -- initialize last recorded Y value for gap placement
    self.lastY = -PIPE_HEIGHT + math.random(80) + 20
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('p') then
        if self.paused == true then
            self.paused = false
            sounds['music']:play()
        else
            self.paused = true
            sounds['music']:pause()
            sounds['pause']:play()
        end
    end
    if self.paused then
        scrolling = false
    else
        scrolling = true
        self.timer = self.timer + dt

        if self.timer > self.spawnTime then
            local y = math.max(-PIPE_HEIGHT + 10,
                               math.min(self.lastY + math.random(-20, 20), VIRTUAL_HEIGHT - 90 - PIPE_HEIGHT))
            self.lastY = y

            table.insert(self.pipePairs, PipePair(y))

            self.timer = 0
            self.spawnTime = math.random(1, 3)
        end

        for key, pair in pairs(self.pipePairs) do
            if not pair.scored then
                if pair.x + PIPE_WIDTH < self.bird.x then
                    self.score = self.score + 1
                    pair.scored = true
                    sounds['score']:play()
                end
            end

            pair:update(dt)
        end

        for key, pair in pairs(self.pipePairs) do
            if pair.remove then
                table.remove(self.pipePairs, key)
            end
        end

        self.bird:update(dt)

        for k, pair in pairs(self.pipePairs) do
            for l, pipe in pairs(pair.pipes) do
                if self.bird:collides(pipe) then
                    sounds['explosion']:play()
                    sounds['hurt']:play()

                    gStateMachine:change('score', {
                        score = self.score
                    })
                end
            end
        end
        if self.bird.y > VIRTUAL_HEIGHT - 15 then
            sounds['explosion']:play()
            sounds['hurt']:play()

            gStateMachine:change('score', {
                score = self.score
            })
        end
    end
end

function PlayState:render()
    for key, pair in pairs(self.pipePairs) do
        pair:render()
    end

    love.graphics.setFont(flappyFont)
    love.graphics.print('Score: ' .. tostring(self.score), 8, 8)

    self.bird:render()

    if self.paused then
        love.graphics.printf('Paused', VIRTUAL_WIDTH / 2 - 70, VIRTUAL_HEIGHT / 2 - 110, 140, 'center')
        love.graphics.draw(woodPlaque, VIRTUAL_WIDTH / 2 - 75, VIRTUAL_HEIGHT / 2 - 70)
        love.graphics.printf('Maybe get some water!', VIRTUAL_WIDTH / 2 - 65, VIRTUAL_HEIGHT / 2 - 57, 130, 'center')
        love.graphics.setFont(mediumFont)
        love.graphics.printf('Press p again to resume.', VIRTUAL_WIDTH / 2 - 65, VIRTUAL_HEIGHT / 2 + 80, 130, 'center')
    end
end

function PlayState:enter()
    scrolling = true
end

function PlayState:exit()
    scrolling = false
end

