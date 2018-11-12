-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local composer = require( 'composer' )

-- Gerador de numero aleatorios
math.randomseed( os.time() )

-- Remover a barra de status do celular
display.setStatusBar( display.HiddenStatusBar )

-- Standard text object
--local displayText = display.newText( "Hello World", 150, 80, "CoolCustomFont.ttf", 24 )
 
-- Font for native text input field
--local inputText = native.newFont( "CoolCustomFont.ttf", 16 )
--local textField = native.newTextField( 150, 150, 180, 30 )
--textField.font = inputText

composer.gotoScene( "menu")