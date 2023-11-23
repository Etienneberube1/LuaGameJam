gameState = 1
isGameOver = false

function AskInput()

    if love.keyboard.isDown("return")
    then ResetValues()
         PlayTimerASound() 
         gameState = 2
    elseif love.keyboard.isDown("escape")
    then love.event.quit()
    end

end

function ResetValues()
    
    isGameOver = false
    canDrawCountDown = true
    canDrawRed = false
    canDrawHit = false
    canDrawFinal = false
    canFadeToBlack = false
    health = initHealth
    rectanglePosX = initRecPosX
    soundtrackVolume = initSoundtrackVolume
    gameOverPosY = 0
    score = 0
    DestroyAllCrabs()
    LoadCrab(5)
    LoadPlanes()
    LoadRocket()

end

function StartTransition(dt)

    canFadeToBlack = true
    soundtrackVolume = soundtrackVolume - initSoundtrackVolume * dt
    PlayGameOverSound()

end

function CheckGameOver(dt)

    if isGameOver
    then gameState = 4
         PlayEndScreen()
    end

end