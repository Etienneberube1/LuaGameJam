require("Planes")
require("Player")
require("Crabe")
require("GameScreen")
require("Explosion")
require("Collision")
require("GameStates")
require("UI")
require("Audio")
require("Rocket")

function love.load()

    math.randomseed(os.time())
    SetScreen()
    LoadGameScreen()    
    createPlayer()
    LoadExplosion()
    LoadPlanes()
    LoadRocket()
    LoadUI()
    LoadAudioClips()

end

function love.update(dt)

    if gameState == 1 then
        UpdateMenu(dt)
    elseif gameState == 2 then
        UpdateCountDown(dt)
    elseif gameState == 3 then
        UpdateGame(dt)
    elseif gameState == 4 then
        UpdateGameOver(dt)
    end

end

function love.draw()

    if gameState == 1 then
        DrawMenu()
    elseif gameState == 2 or gameState == 3 then
        DrawGame()
    elseif gameState == 4 then
        DrawGameOver()
    end

end

-----------------------Load-------------------------------

function SetScreen()

    love.mouse.setVisible(false)
    love.window.setFullscreen(true)
    love.window.setTitle("Ocean Warfare")
    screen_width = love.graphics.getWidth()
    screen_height = love.graphics.getHeight()

end

-----------------------Update-------------------------------

function UpdateMenu(dt)

    AskInput()
    UpdateRectangle(dt)
    UpdatePressStart(dt)
    UpdateFadeToBlack(dt)
    PlaySoundtrack()

end

function UpdateGame(dt)

    Shot(dt)
    playermovement(dt)
    UpdateShot(dt)
    UpdateCrab(dt)
    AnimateOctopus(dt)
    AnimateCrab(dt)
    SpawnPlaneTimer(dt)
    PlaneBehaviour(dt)
    UpdateRocket(dt)
    isHit()
    UpdateHitScore(dt)
    UpdateRedPanel(dt)
    UpdateRectangle(dt)
    UpdateFadeToBlack(dt)
    CheckHealth(dt)
    CheckGameOver()
    CheckHighScore()
    PlaySoundtrack()

end

function UpdateGameOver(dt)

    UpdateGameOverUI(dt)
    AskInput()

end

-----------------------Draw-------------------------------

function DrawMenu() 
    
    DrawMenuUI() 

end

function DrawGame()

    DrawGameScreen()
    DrawCrab()
    drawPlayer()
    DrawShots()
    DrawPlanes()
    DrawRocket()
    DrawExplosion()
    DrawThemeScreen()
    DrawGameUI()

end

function DrawGameOver() 
    
    DrawGameOverUI() 

end
