PlayState = Class{__includes = BaseState}

PIPE_SPEED = 60
PIPE_HEIGHT = 288
PIPE_WIDTH = 96

BIRD_WIDTH = 26
BIRD_HEIGHT = 26

function PlayState:init()
    self.bird = Bird()
    self.pipePairs = {}
    self.timer = 0

    -- initialize last recorded Y value for gap placement
    self.lastY = - PIPE_HEIGHT + math.random(80) + 20
end

function PlayState:update(dt)
    self.timer = self.timer + dt

    if self.timer > 2 then
        local y = math.max(- PIPE_HEIGHT + 10, 
            math.min(self.lastY + math.random(-20, 20), VIRTUAL_HEIGHT -90 - PIPE_HEIGHT))
        self.lastY = y

        table.insert(self.pipePairs, PipePair(y))

        self.timer = 0
    end

    for key, pair in pairs(self.pipPairs) do
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
                gStateMachine:change('title')
            end
        end
    end
    if self.bird.y > VIRTUAL_HEIGHT - 15 then
        gStateMachine:change('title')
    end
end

function PlayState:render()
    for key, pair in pairs(self.pipePairs) do
        pair:render()
    end

    self.bird:render()
end

