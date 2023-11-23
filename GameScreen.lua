function LoadGameScreen()
    GameScreen = {}
    GameScreen.image = love.graphics.newImage("assets/Background.png")
    GameScreen.x = screen_width / 4
    GameScreen.y = 0
    GameScreen.width = GameScreen.image:getWidth()
    GameScreen.height = GameScreen.image:getHeight()
    GameScreen.maxX = GameScreen.x + (GameScreen.width * CalScaleX())

    GameScreen.drawGameScreen = function()
        love.graphics.draw(GameScreen.image, GameScreen.x, GameScreen.y, 0, CalScaleX(), CalScaleY())
    end

    GameScreen.drawThemeScreen = function()
        love.graphics.setColor(black)
        love.graphics.rectangle("fill", 0, 0, GameScreen.x, screen_height)
        love.graphics.rectangle("fill", GameScreen.maxX, 0, GameScreen.x, screen_height)
    end
end

function DrawGameScreen()
    GameScreen.drawGameScreen()
end

function DrawThemeScreen()
    GameScreen.drawThemeScreen()
end

function CalScaleX()
    local actualRatioWidth = (screen_width / 2) / GameScreen.width
    return actualRatioWidth
end
function CalScaleY()
    local actualRatioHeight = screen_height / GameScreen.height
    return actualRatioHeight
end
