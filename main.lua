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


composer.gotoScene( "menu")
