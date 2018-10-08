local composer = require( "composer" )
 
local scene = composer.newScene()
 
-- Gerador de numero aleatorios
math.randomseed( os.time() )

local physics = require( "physics" )
physics.start()
physics.setGravity( 0, 0 )

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
local backGroup = display.newGroup()
local mainGroup = display.newGroup()
local uiGroup = display.newGroup()
local balls_table = {}
local gameLoopTimer
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view

    local backgroundmusic = audio.loadSound('_audios/Memory_Rain.mp3')
    audio.play(backgroundmusic)

    local background = display.newImageRect( backGroup, '_img/backs/back03.png', 1250, 700)

    local logo = display.newImageRect( mainGroup, '_img/logo_gameover.png', 300, 100)
    logo.x = display.contentCenterX
    logo.y = display.contentCenterY

    local function gotoMenu()
        composer.gotoScene( "menu2" )
    end
    
    local backButton = display.newImageRect( mainGroup, "_img/backbtn.png", 80, 45 )
	backButton.x = display.contentCenterX + 230
	backButton.y = display.contentCenterY + 130
    backButton:addEventListener( "tap", gotoMenu )

    local function createBall()
        local newBall = display.newImageRect( mainGroup, '_img/circulo-preto.png', 40, 40 )
        table.insert( balls_table, newBall )
        physics.addBody( newBall, "dynamic", { radius=40, bounce=0.8 } )
        newBall.myName = "ball"

        local whereFrom = 3

        if ( whereFrom == 3 ) then
            -- From the right
            newBall.x = display.contentWidth + 100
            newBall.y = math.random( 50 )
            newBall:setLinearVelocity( math.random( -90,-20 ), math.random( 20,40 ) )
        end

        newBall:applyTorque( math.random( -6,6 ) )
    end

    local function gameLoop()
        -- Create new ball
	    createBall()

    end
    gameLoopTimer = timer.performWithDelay( 800, gameLoop, 0 )
   
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
    
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene