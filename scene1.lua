local composer = require( "composer" )
local physics = require( "physics" )
local widget = require( "widget" )
physics.start()

physics.setGravity( 0, 0 )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local backGroup = display.newGroup()
local mainGroup = display.newGroup()
local uiGroup = display.newGroup()
local gameLoopTimer
local balls_table = {}
local lives = 3
local score = 0
local died = false
local livesText
local scoreText
local dark 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    
    local backgroundmusic = audio.loadSound('_audios/If_I_Had_a_Chicken.mp3')
    audio.play(backgroundmusic)

    livesText = display.newText( uiGroup, "Lives: " .. lives, 100, 40, native.systemFont, 24 )
    scoreText = display.newText( uiGroup, "Score: " .. score, 250, 40, native.systemFont, 24 )

    local function updateText()
	     livesText.text = "Lives: " .. lives
	     scoreText.text = "Score: " .. score
    end

    -- background of game
    local background = display.newImageRect( backGroup, '_img/background.png', 1250, 700)
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    -- loading light
    local light = display.newImageRect(mainGroup, '_img/light.png', 150, 120)
    light.x = 50
    light.y = 150
    light.myName = 'light'
    physics.addBody( light, "static", { radius=40, bounce=0.1 }  )

    local function gotoMenu()
        composer.gotoScene( "game-over" )
    end

    local function MoveLight( event )
        local light = event.target
        local phase = event.phase

        if ( "began" == phase ) then
            -- Set touch focus on the ship
            display.currentStage:setFocus( light )

            -- Store initial offset position
            light.touchOffsetX = event.x - light.x
            light.touchOffsetY = event.y - light.y

        elseif ( "moved" == phase ) then
            -- Move the light to the new touch position
            light.x = event.x - light.touchOffsetX
            light.y = event.y - light.touchOffsetY

        elseif ( "ended" == phase or "cancelled" == phase ) then
            -- Release touch focus on the ship
            display.currentStage:setFocus( nil )
        end
        return true  -- Prevents touch propagation to underlying objects
    end


    light:addEventListener( "touch", MoveLight )

    local function createBall()
        local newBall = display.newImageRect( mainGroup, '_img/circulo.png', 15, 15 )
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

    local function createBall2()
        local newBall2 = display.newImageRect( mainGroup, '_img/circulo-preto.png', 15, 15 )
        table.insert( balls_table, newBall2 )
        physics.addBody( newBall2, "dynamic", { radius=40, bounce=0.8 } )
        newBall2.myName = "ball2"

        local whereFrom = 3

        if ( whereFrom == 3 ) then
            -- From the right
            newBall2.x = display.contentWidth + 100
            newBall2.y = math.random( 50 )
            newBall2:setLinearVelocity( math.random( -90,-20 ), math.random( 20,40 ) )
        end

        newBall2:applyTorque( math.random( -6,6 ) )
    end


    local function gameLoop()
        -- Create new ball
	      createBall()
        createBall2()

    end
    gameLoopTimer = timer.performWithDelay( 800, gameLoop, 0 )

    local function restoreLight()
      	light.isBodyActive = false
      	light.x = display.contentCenterX
      	light.y = display.contentHeight - 100

      	transition.to( light, { alpha=1, time=4000,
      		onComplete = function()
      			light.isBodyActive = true
      			died = false
      		end
      	} )
    end

    --Função executada a 1 milisegundo, cuida da movimentação dos personagens
    function persegue()

	--Calcula a distancia entre doispontos no plano cartesiano
	    local distancia = math.sqrt ((light.x-dark.x)^2 + (light.y-dark.y) ^2)		

		--Verifica se ha distancia minima para perseguir
		if (distancia > 40) then
			if(dark.y < light.y) then
				dark.y = dark.y + 0.75
			end
			if(dark.y > light.y) then
				dark.y = dark.y - 0.75
			end
			if(dark.x < light.x) then
				dark.x = dark.x + 0.75
			end
			if(dark.x > light.x) then
				dark.x = dark.x - 0.75
			end
		else
			timer.pause(timer1)
        end
end


    local function onCollision( event )

    if ( event.phase == "began" ) then

        local obj1 = event.object1
        local obj2 = event.object2

        if ( ( obj1.myName == "ball" and obj2.myName == "light" ) or
             ( obj1.myName == "light" and obj2.myName == "ball" ) )

        then

            if(obj1.myName == "ball")
            then
                display.remove( obj1 )
                score = score + 100
                      scoreText.text = "Score: " .. score
                      if  (score == 1000) then
                            -- loading dark
                            dark = display.newImageRect(mainGroup, '_img/dark.png', 150, 120)
                            dark.x = 400
                            dark.y = 150
                            dark.myName = 'dark'
                            physics.addBody( dark, "static", { radius=40, bounce=0.1 }  )

                            timer1 = timer.performWithDelay(1, persegue, 0)
                        end
                end
            if(obj2.myName == "ball")
            then
                display.remove( obj2 )
                score = score + 100
                scoreText.text = "Score: " .. score
                if  (score == 1000) then
                    -- loading dark
                    dark = display.newImageRect(mainGroup, '_img/dark.png', 150, 120)
                    dark.x = 400
                    dark.y = 150
                    dark.myName = 'dark'
                    physics.addBody( dark, "static", { radius=40, bounce=0.1 }  )

                    timer1 = timer.performWithDelay(1, persegue, 0)
                end
            end
        end
    end
end

Runtime:addEventListener( "collision", onCollision )

  local function onCollision( event )

  if ( event.phase == "began" ) then

      local obj1 = event.object1
      local obj2 = event.object2

      if ( ( obj1.myName == "ball2" and obj2.myName == "light" ) or
           ( obj1.myName == "light" and obj2.myName == "ball2" ) )

      then

          if (obj1.myName == "ball2")
          then
              --display.remove( obj2 )
              --score = score - 100
			  --coreText.text = "Score: " .. score

              if ( died == false ) then
				         died = true

				         -- Update lives
				         lives = lives - 1
				         livesText.text = "Lives: " .. lives

				         if ( lives == 0 ) then
                              display.remove( light )
                              audio.pause(backgroundmusic)
                              composer.gotoScene( "game-over" )
				         else
					          light.alpha = 0
					          timer.performWithDelay( 1000, restoreLight )
				         end
			        end
          end

          if(obj2.myName == "ball2")
          then
              --display.remove( obj1 )
                --score = score - 100
			    --scoreText.text = "Score: " .. score

              if ( died == false ) then
                 died = true

                 -- Update lives
                 lives = lives - 1
                 livesText.text = "Lives: " .. lives

                 if ( lives == 0 ) then
                    display.remove( light )
                    audio.pause(backgroundmusic)
                    composer.gotoScene( "game-over")
                 else
                    light.alpha = 0
                    timer.performWithDelay( 1000, restoreLight )
                 end
              end
          end
      end
  end
  end

Runtime:addEventListener( "collision", onCollision )
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
--scene:addEventListener( "show", scene )
--scene:addEventListener( "hide", scene )
--scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
