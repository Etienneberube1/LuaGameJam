function LoadPlanes()

    planeSheet = love.graphics.newImage("assets/planes.png")

    planeSpawnTime = 1;
    PlaneSpawnElapsed = 0;
    planeMaxIndex = 4

    -- Quad infos
    planeSheetWidth = 96
    planeSheetHeight = 160
    planeScale = 3
    planeQuadWight = 32
    planeQuadHeight = 32
    planeColomn = 3

    -- planes dimensions
    planeWidth = planeQuadWight * planeScale
    planeHeight = planeQuadHeight * planeScale

    -- init lists
    planes = {}
    planesInfos = {}

    -- CONSTS LISTS

    -- PLANE 1
    plane1 = {}

    plane1.planeTileXAdder = planeQuadWight
    plane1.widthPerPlane = -planeQuadWight
    plane1.planeOrientation = math.rad(-90)
    plane1.interpolationTimesX = 0
    plane1.planeInterpolationX = 0
    plane1.interpolates = false
    plane1.planeSpeedY = 500
    plane1.planeSpeedX = 0
    plane1.planeSpawnRangeX = {GameScreen.x, GameScreen.maxX - planeWidth}
    plane1.planeSpawnRangeY = {GameScreen.y - (planeHeight * 2), GameScreen.y - planeHeight}
    plane1.hasProjectile = false

    table.insert(planesInfos, plane1)

    -- PLANE 2
    plane2 = {}

    plane2.planeTileXAdder = 0
    plane2.widthPerPlane = planeQuadWight
    plane2.planeOrientation = 0
    plane2.interpolationTimesX = 0
    plane2.planeInterpolationX = 0
    plane2.interpolates = false
    plane2.planeSpeedY = 0
    plane2.planeSpeedX = -400
    plane2.planeSpawnRangeX = {GameScreen.maxX, GameScreen.maxX + planeWidth}
    plane2.planeSpawnRangeY = {0, planeHeight * 2}
    plane2.hasProjectile = true

    table.insert(planesInfos, plane2)

    -- PLANE 3
    plane3 = {}

    plane3.planeTileXAdder = planeQuadWight
    plane3.widthPerPlane = -planeQuadWight
    plane3.planeOrientation = math.rad(-90)
    plane3.interpolationTimesX = 3
    plane3.planeInterpolationX = 100
    plane3.interpolates = true
    plane3.planeSpeedY = 400
    plane3.planeSpeedX = 0
    plane3.planeSpawnRangeX = {GameScreen.x + plane3.planeInterpolationX, GameScreen.maxX - plane3.planeInterpolationX - planeWidth}
    plane3.planeSpawnRangeY = {GameScreen.y - (planeHeight * 2), GameScreen.y - planeHeight}
    plane3.hasProjectile = false

    table.insert(planesInfos, plane3)

    -- PLANE 4
    plane4 = {}

    plane4.planeTileXAdder = planeQuadWight
    plane4.widthPerPlane = -planeQuadWight
    plane4.planeOrientation = math.rad(-90)
    plane4.interpolationTimesX = 3
    plane4.planeInterpolationX = 200
    plane4.interpolates = true
    plane4.planeSpeedY = 550
    plane4.planeSpeedX = 0
    plane4.planeSpawnRangeX = {GameScreen.x + plane3.planeInterpolationX, GameScreen.maxX - plane3.planeInterpolationX - planeWidth}
    plane4.planeSpawnRangeY = {GameScreen.y - (planeHeight * 2), GameScreen.y - planeHeight}
    plane4.hasProjectile = false

    table.insert(planesInfos, plane4)

    -- PLANE 5
    plane5 = {}

    plane5.planeTileXAdder = planeQuadWight
    plane5.widthPerPlane = -planeQuadWight
    plane5.planeOrientation = math.rad(-90)
    plane5.interpolationTimesX = 3
    plane5.planeInterpolationX = 50
    plane5.interpolates = true
    plane5.planeSpeedY = 650
    plane5.planeSpeedX = 0
    plane5.planeSpawnRangeX = {GameScreen.x + plane3.planeInterpolationX, GameScreen.maxX - plane3.planeInterpolationX - planeWidth}
    plane5.planeSpawnRangeY = {GameScreen.y - (planeHeight * 2), GameScreen.y - planeHeight}
    plane5.hasProjectile = false

    table.insert(planesInfos, plane5)

end

function SpawnPlaneTimer(dt)

    PlaneSpawnElapsed = PlaneSpawnElapsed + dt
    if PlaneSpawnElapsed > planeSpawnTime then
        SpawnPlane(planeMaxIndex)
        PlaneSpawnElapsed = 0
    end

end

function SpawnPlane(maxIndex)

    -- plane creation
    local plane = {}
    
    -- decides which plane spawns
    quadIndex = math.random(0, maxIndex)
    index = quadIndex + 1
    plane.type = index
    
    -- plane quad
    spawnx = math.random(planesInfos[index].planeSpawnRangeX[1], planesInfos[index].planeSpawnRangeX[2])
    spawny = math.random(planesInfos[index].planeSpawnRangeY[1], planesInfos[index].planeSpawnRangeY[2])
    
    planeTileX = ((quadIndex % planeColomn) * planeQuadWight) + planesInfos[index].planeTileXAdder
    planeTileY = (math.floor(quadIndex / planeColomn)) * planeQuadHeight
    
    plane.quad = love.graphics.newQuad(planeTileX, planeTileY, planesInfos[index].widthPerPlane, planeQuadHeight, planeSheetWidth, planeSheetHeight)
    
    -- plane position
    plane.x = spawnx
    plane.y = spawny

    -- plane hitbox info
    plane.left = plane.x
    plane.right = plane.x + planeWidth
    plane.top = plane.y
    plane.bottom = plane.y + planeHeight

    -- plane interpolation info
    plane.inerpolationTimer = 0
    plane.planeInterpolationUp = true
    plane.spawnX = spawnx
    plane.spawnY = spawny
    plane.interpolationTimesX = 0

    -- plane other infos
    plane.isExploding = false
    plane.projectileDropX = math.random(GameScreen.x + planeWidth, GameScreen.maxX - planeWidth)
    plane.hasShot = false
    
    table.insert(planes, plane)

    -- explosion creation
    local explosion = {}

    -- explosion infos
    explosion.frames = 0
    explosion.timer = 0
    explosion.quad = nil

    table.insert(explosions, explosion)

    -- initialisation  
    AnimateExplosion(#planes)

end

function DrawPlanes()
    for i = 1, #planes, 1 do
        love.graphics.draw(planeSheet, planes[i].quad, planes[i].x, planes[i].y, planesInfos[planes[i].type].planeOrientation, planeScale)
    end
end

function PlaneBehaviour(dt)

    for i = #planes, 1, -1 do

        local thisPlane = planes[i]
        local thisPlaneInfos = planesInfos[thisPlane.type]

        -- Projectiles
        if thisPlaneInfos.hasProjectile then
            if thisPlaneInfos.planeSpeedX < 0 then
                if  thisPlane.x <= thisPlane.projectileDropX and not thisPlane.hasShot then

                    thisPlane.hasShot = true
                    SpawnRocket(thisPlane.x, thisPlane.y)

                end
            else
                if  thisPlane.x >= thisPlane.projectileDropX and not thisPlane.hasShot then

                    thisPlane.hasShot = true
                    SpawnRocket(thisPlane.x, thisPlane.y)

                end
            end
        end

        -- if exploding, go to next iteration
        if thisPlane.isExploding then

            UpdateExplosion(dt, i)
            goto continue

        end

        -- if plane is out of bounds, explosion is true
        if thisPlane.y >= screen_height - planeWidth or thisPlane.x <= 0 - planeWidth then

            thisPlane.isExploding = true

        else 
            -- Interpolations
            if (thisPlaneInfos.interpolates) and thisPlaneInfos.interpolationTimesX >= thisPlane.interpolationTimesX then 

                thisPlane.inerpolationTimer = thisPlane.planeInterpolationUp and thisPlane.inerpolationTimer + dt or thisPlane.inerpolationTimer - dt

                if thisPlane.inerpolationTimer <= -1 or thisPlane.inerpolationTimer >= 1 then

                    thisPlane.interpolationTimesX = thisPlane.interpolationTimesX + 1
                    thisPlane.planeInterpolationUp = not thisPlane.planeInterpolationUp

                end

                local time = thisPlane.inerpolationTimer
                local x1 = thisPlane.spawnX
                local x2 = x1 + thisPlaneInfos.planeInterpolationX

                thisPlane.x = x1 - (x2 - x1) * time

            else -- no Interpolations
                
                thisPlane.x = thisPlane.x + dt * (thisPlaneInfos.planeSpeedX)

            end

            thisPlane.y = thisPlane.y + dt * thisPlaneInfos.planeSpeedY

        end

        -- Update hitbox Infos
        thisPlane.left = thisPlane.x
        thisPlane.right = thisPlane.x + planeWidth
        thisPlane.top = thisPlane.y
        thisPlane.bottom = thisPlane.y + planeHeight

        ::continue::

    end
end

function DeletePlane(index)

    table.remove(planes, index)
    table.remove(explosions, index)

end

function ReturnPlanesList()

    return planes

end