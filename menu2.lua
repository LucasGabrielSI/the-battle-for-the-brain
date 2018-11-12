local composer = require( "composer" )
 
local scene = composer.newScene()
     
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

-- Inclui a biblioteca de Widgets
local widget = require "widget"

 -- Remover a barra de status do celular
display.setStatusBar( display.HiddenStatusBar )    

W = display.contentWidth  -- Pega a largura da tela
H = display.contentHeight -- Pega a altura da tela

local backGroup = display.newGroup()
local mainGroup = display.newGroup()
local uiGroup = display.newGroup()
     
     
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
     
-- create()
function scene:create( event )
     
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

        
        local function gotoMenu()
            composer.gotoScene( "scene1" )
        end
        
        local background = display.newImageRect( backGroup, '_img/backs/back03.png', 1250, 700)
        background.x = display.contentCenterX
        background.y = display.contentCenterY

        local nameOfgame = display.newImageRect( mainGroup, '_img/logo.png', 255, 75)
        nameOfgame.x = display.contentCenterX 
        nameOfgame.y = display.contentCenterY - 100

        local button_init = widget.newButton
        {
            left = 180,
            top = 150,
            width = 100,
            height = 50,
            defaultFile = '_img/iniciar.png',
            overFile = '_img/iniciar.png',
        }

        button_init:addEventListener( "tap", gotoMenu )

        
        
        
        

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
