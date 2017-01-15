-----------------------------------------------------------------------------------------
--模仿mandora做出一個類似遊戲
--
--
--

--Date:2016/09/18   19:35
--Author:Ryan
-----------------------------------------------------------------------------------------

--=======================================================================================
--引入各種函式庫
--=======================================================================================
display.setStatusBar( display.HiddenStatusBar ) 
composer = require("composer")
math.randomseed( os.time(  ) )
widget = require("widget")
physics = require("physics")
particle = require("particleDesigner")
--=======================================================================================
--宣告各種變數
--=======================================================================================
_SCREEN = {
	W = display.contentWidth ,
	H = display.contentHeight
}
_SCREEN.CENTER = {
	X = display.contentCenterX ,
	Y = display.contentCenterY
}

WIDTH = _SCREEN.W/640
HEIGHT = _SCREEN.H/1136

--預先載入音效
backSound = audio.loadSound( "sounds/back.wav")
playSound = audio.loadSound( "sounds/play.wav")
rockSound = audio.loadSound( "sounds/rock.wav")
endlessSound = audio.loadSound( "sounds/endless.wav")
survivalSound = audio.loadSound( "sounds/survival.wav")
bookSound = audio.loadSound( "sounds/book.wav")
endless_tutorialSound = audio.loadSound( "sounds/endless_tutorial.wav")
survival_tutorialSound = audio.loadSound( "sounds/survival_tutorial.wav")
title_bgm = audio.loadStream( "sounds/title_bgm.mp3")
tutorial_bgm = audio.loadStream( "sounds/tutorial_bgm.mp3")

--=======================================================================================
--宣告各個函式名稱
--=======================================================================================
local init

local demo_scene = "opening"
--=======================================================================================
--宣告與定義main()函式
--=======================================================================================
local main = function ( )
	init()
end

--=======================================================================================
--定義其他函式
--=======================================================================================
init = function (  )
	composer.gotoScene( demo_scene )
end

--=======================================================================================
--呼叫主函式
--=======================================================================================
main()



