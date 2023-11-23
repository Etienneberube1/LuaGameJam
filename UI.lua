scoringValue = 10
score = 0
highscore = 0
health = 3
initHealth = 3

-----------------------Load-------------------------------

function LoadUI()

    screenWidth = love.graphics.getWidth()
    screenHeight = love.graphics.getHeight()

    titleFont = love.graphics.newFont("fonts/Digivolve.otf", screenWidth * 0.1)
    mainFont = love.graphics.newFont("fonts/Kemco.ttf", screenWidth * 0.072)
    smallFont = love.graphics.newFont("fonts/SmallFont.ttf", screenWidth * 0.036)

    black = {0 / 255, 0 / 255, 0 / 255}
    white = {255 / 255, 255 / 255, 255 / 255}
    red = {220 / 255, 40 / 255, 20 / 255}
    blue = {30 / 255, 50 / 255, 180 / 255}
    teal = {0 / 255, 200 / 255, 200 / 255}

    heartList = {}
    LoadHeart()
    LoadHeart()
    LoadHeart()

end

function LoadHeart()

    heart = {}
    heart.image = love.graphics.newImage("assets/Heart.png")
    heart.width = heart.image:getWidth()
    heart.height = heart.image:getHeight()
    heart.scale = screenWidth / 5000
    heart.x = screenWidth / 30
    heart.y = screenHeight - (heart.height * heart.scale) - heart.x
    table.insert(heartList, heart)

end

-----------------------Update-------------------------------

canDrawStart = true
local startOnElapsed = 0
local startOffElapsed = 0
local startOnDelay = 1.0
local startOffDelay = 0.3

function UpdatePressStart(dt)

    if canDrawStart then
        startOnElapsed = startOnElapsed + 1 * dt
    else
        startOffElapsed = startOffElapsed + 1 * dt
    end

    if startOnElapsed > startOnDelay then
        canDrawStart = false
        startOnElapsed = 0
    elseif startOffElapsed > startOffDelay then
        canDrawStart = true
        startOffElapsed = 0
    end

end

initRecPosX = 100
rectanglePosX = 100
local RightScrollSpeed = 600

function UpdateRectangle(dt)

    rectanglePosX = rectanglePosX + RightScrollSpeed * dt

end

canDrawHit = false
hitPositionX = 0
hitPositionY = 0
local smallFontSize = 1
local hitElapsed = 0
local hitDelay = 0.5

function UpdateHitScore(dt)

    if canDrawHit then
        hitElapsed = hitElapsed + 1 * dt
        smallFontSize = smallFontSize - 1 * dt
    end

    if hitElapsed > hitDelay then
        canDrawHit = false
        hitElapsed = 0
        smallFontSize = 1
    end

end

canDrawRed = false
local redElapsed = 0
local redDelay = 0.4
local redAlphaValue = 0.5

function UpdateRedPanel(dt)

    if canDrawRed then
        redElapsed = redElapsed + 1 * dt
        redAlphaValue = redAlphaValue - 2 * dt
    end

    if redElapsed > redDelay then
        canDrawRed = false
        redElapsed = 0
        redAlphaValue = 0.5
    end

end

canDrawCountDown = false
local countDownTime = 3
local countDownScale = 2
local countDownPosition = 0.45
local scaleElapsed = 0

function UpdateCountDown(dt)

    if canDrawCountDown then
        countDownTime = countDownTime - 1 * dt
        countDownScale = countDownScale - 1.5 * dt
        countDownPosition = countDownPosition + 0.037 * dt
        scaleElapsed = scaleElapsed + 1 * dt
    end

    if scaleElapsed >= 1 then
        countDownScale = 2
        countDownPosition = 0.45
        scaleElapsed = 0 
        PlayTimerASound()
    end

    if countDownTime < 0 then
        canDrawCountDown = false
        countDownTime = 3
        countDownPosition = 0.45
        countDownScale = 2
        scaleElapsed = 0
        gameState = 3
        PlayTimerBSound()
    end

end

canFadeToBlack = false
local fadeElapsed = 0
local blackAlphaValue = 0

function UpdateFadeToBlack(dt)

    if canFadeToBlack then
        fadeElapsed = fadeElapsed + 1 * dt
        blackAlphaValue = blackAlphaValue + 255 * dt
    end

    if fadeElapsed > 1 then
        isGameOver = true
        fadeElapsed = 0
        blackAlphaValue = 0
        canFadeToBlack = false
    end

end

canDrawFinal = false
gameOverPosY = 0
local scrollDownSpeed = 350

function UpdateGameOverUI(dt)

    if gameOverPosY < screenHeight * 0.6 then
        gameOverPosY = gameOverPosY + scrollDownSpeed * dt
    else
        canDrawFinal = true
    end

end

function CheckHighScore()
    if score > highscore then
        highscore = score
    end
end

function CheckHealth(dt)
    if health < 1 then
        StartTransition(dt)
    end
end

-----------------------Draw-------------------------------

function DrawMenuUI()

    love.graphics.setColor(black)
    love.graphics.rectangle("fill", 0, 0, screenWidth, screenHeight)
    love.graphics.setColor(red)
    love.graphics.setFont(titleFont)
    love.graphics.print("OCEAN WARFARE", screenWidth * 0.07, screenHeight * 0.07)
    love.graphics.setFont(mainFont)
    love.graphics.setColor(white)
    love.graphics.print("PROTECT THE CRABS FROM THE PLANES!", screenWidth * 0.12, screenHeight * 0.33, 0, 0.4)
    love.graphics.setColor(black)
    love.graphics.rectangle("fill", rectanglePosX, screenHeight * 0.3, screenWidth, screenHeight * 0.1)
    love.graphics.setColor(white)
    love.graphics.print("------- CONTROLS -------", screenWidth * 0.29, screenHeight * 0.46, 0, 0.3)
    love.graphics.print("  UP  : W     LEFT  : A ", screenWidth * 0.33, screenHeight * 0.53, 0, 0.25)
    love.graphics.print(" DOWN : S     RIGHT : D ", screenWidth * 0.33, screenHeight * 0.58, 0, 0.25)
    love.graphics.print("    SHOOT : SPACE BAR   ", screenWidth * 0.33, screenHeight * 0.63, 0, 0.25)
    love.graphics.print("------------------------", screenWidth * 0.29, screenHeight * 0.70, 0, 0.3)
    love.graphics.print("|                      |", screenWidth * 0.26, screenHeight * 0.83, 0, 0.35)
    love.graphics.setColor(teal)

    if canDrawStart then
        love.graphics.print("  PRESS ENTER TO START  ", screenWidth * 0.26, screenHeight * 0.83, 0, 0.35)
    end

end

function DrawGameUI()

    DrawHearts()

    love.graphics.setColor(white)
    love.graphics.print("SCORE: " .. score, screenWidth / 40, screenWidth / 40, 0, 0.39)
    love.graphics.print("HIGH: " .. highscore, screenWidth / 1.3, screenWidth / 40, 0, 0.39)

    if canDrawCountDown then
        love.graphics.setColor(black)
        love.graphics.print(math.ceil(countDownTime), screenWidth * countDownPosition, screenHeight * countDownPosition,
            0, countDownScale)
        love.graphics.setColor(white)
    end

    love.graphics.setColor(0, 0, 0, blackAlphaValue / 255)
    love.graphics.rectangle("fill", 0, 0, screenWidth, screenHeight)
    love.graphics.setColor(black)
    love.graphics.rectangle("fill", 0, screenHeight / 4, screenWidth / 4, screenHeight / 4)
    love.graphics.setColor(white)

    if canDrawHit then
        DrawHitScore(scorePositionX, scorePositionY)
    end

    if canDrawRed then
        DrawRedPanel()
    end

end

function DrawGameOverUI()

    love.graphics.setColor(black)
    love.graphics.rectangle("fill", 0, 0, screenWidth, screenHeight)
    love.graphics.setColor(red)
    love.graphics.print("GAME OVER", screenWidth * 0.19, gameOverPosY - (screenWidth * 0.08), 0, 1.25)
    love.graphics.setColor(white)

    if canDrawFinal then
        love.graphics.print("SCORE: " .. score, screenWidth * 0.35, screenHeight * 0.12, 0, 0.55)
        love.graphics.print("HIGHSCORE: " .. highscore, screenWidth * 0.29, screenHeight * 0.22, 0, 0.55)
        love.graphics.print("|                       |", screenWidth * 0.22, screenHeight * 0.75, 0, 0.4)
        love.graphics.print("|                      |", screenWidth * 0.23, screenHeight * 0.85, 0, 0.4)
        love.graphics.setColor(teal)
        love.graphics.print("  PRESS ENTER TO REPLAY  ", screenWidth * 0.22, screenHeight * 0.75, 0, 0.4)
        love.graphics.print("  PRESS ESCAPE TO QUIT  ", screenWidth * 0.23, screenHeight * 0.85, 0, 0.4)
    end

end

function DrawHearts()
    love.graphics.setColor(red)
    if health > 0 then
        love.graphics.draw(heartList[1].image, heart.x, heart.y, 0, heart.scale)
    end
    if health > 1 then
        love.graphics.draw(heartList[2].image, 1.5 * heart.x + (heart.width * heart.scale), heart.y, 0, heart.scale)
    end
    if health > 2 then
        love.graphics.draw(heartList[3].image, 2 * heart.x + 2 * (heart.width * heart.scale), heart.y, 0, heart.scale)
    end

end

function DrawRedPanel()

    love.graphics.setColor(1, 0, 0, redAlphaValue)
    love.graphics.rectangle("fill", 0, 0, screenWidth, screenHeight)
    love.graphics.setColor(white)

end

function DrawHitScore(x, y)

    love.graphics.setColor(black)
    love.graphics.setFont(smallFont)
    love.graphics.print("+" .. scoringValue, x, y, 0, smallFontSize)
    love.graphics.setFont(mainFont)
    love.graphics.setColor(white)

end
