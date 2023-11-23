function LoadAudioClips()

    Soundtrack = love.audio.newSource("sounds/FireDarer.mp3", "static")
    EndScreenSound = love.audio.newSource("sounds/EndScreen.wav", "static")
    GameOverSound = love.audio.newSource("sounds/GameOver.wav", "static")
    ShootingSound = love.audio.newSource("sounds/Shooting.wav", "static")
    ExplosionSound = love.audio.newSource("sounds/Explosion.wav", "static")
    OctopusSound = love.audio.newSource("sounds/Octopus.wav", "static")
    CrabSound = love.audio.newSource("sounds/Crab.wav", "static")
    TimerASound = love.audio.newSource("sounds/TimerA.wav", "static")
    TimerBSound = love.audio.newSource("sounds/TimerB.wav", "static")

end

initSoundtrackVolume = 0.3
soundtrackVolume = 0.3

function PlaySoundtrack()

    Soundtrack:setLooping(true)
    Soundtrack:play()
    Soundtrack:setVolume(soundtrackVolume)

end

function PlayGameOverSound()

    GameOverSound:play()
    GameOverSound:setVolume(0.7)

end

function PlayShootingSound()

    ShootingSound:play()
    ShootingSound:setVolume(0.3)

end

function PlayExplosionSound()

    ExplosionSound:play()
    ExplosionSound:setVolume(0.7)

end

function PlayOctopusSound()

    OctopusSound:play()
    OctopusSound:setVolume(0.4)

end

function PlayCrabSound()

    CrabSound:play()
    CrabSound:setVolume(0.4)

end

function PlayTimerASound()

    TimerASound:play()
    TimerASound:setVolume(0.3)

end

function PlayTimerBSound()

    TimerBSound:play()
    TimerBSound:setVolume(0.4)

end

function PlayEndScreen()

    EndScreenSound:play()
    EndScreenSound:setVolume(0.3)

end