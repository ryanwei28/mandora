-----------------------------------------------------------------------------------------
--
-- endless.lua
-- 進入endless


-- Author: Ryan
-- Time: 2016/9/24
--
-----------------------------------------------------------------------------------------

--=======================================================================================
--引入各種函式庫
--=======================================================================================
local scene = composer.newScene( )
require("opening")
require("grow_sequence")

--=======================================================================================
--宣告各種變數
--=======================================================================================
local background
local skip
local container2 = display.newContainer( _SCREEN.W*2.5 , _SCREEN.H*2.5 )
local container = display.newContainer( _SCREEN.W , _SCREEN.H )
local cloudGroup = display.newGroup( )
local hole_backGroup = display.newGroup( )
local hole_frontGroup = display.newGroup( )
local pullGroup = display.newGroup( )
local front 
local endless_clock
local score_bg 
local bottle_morning
local cloud1
local cloud2 
local options = SheetInfo.sheet
local new_mandora
local grow_mandora
local old_mandora 

--=======================================================================================
--宣告各種函數函數
--=======================================================================================
local init
local moveCloud
local sequenceNew
local sequenceGrow
local sequenceOld

--=======================================================================================
--定義各種函式
--=======================================================================================
init = function ( _parent  )
   
    --加入背景以及各項物件
    background = display.newImageRect( _parent , "images/start/sky_morning.png", _SCREEN.W , _SCREEN.H*0.4 )
    background.x , background.y = _SCREEN.CENTER.X , _SCREEN.CENTER.Y *0.3

    _parent:insert(cloudGroup)

    front = display.newImageRect( _parent, "images/start/front_morning.png", _SCREEN.W , _SCREEN.H )
    front.x , front.y = _SCREEN.CENTER.X , _SCREEN.CENTER.Y*1.1

    endless_clock = display.newImageRect( _parent , "images/start/endless_clock.png", 120 , 120 )
    endless_clock.x , endless_clock.y = _SCREEN.CENTER.X *1.75 , _SCREEN.CENTER.Y * 0.15

    score_bg = display.newImageRect( _parent , "images/start/score_bg.png", 180 , 120 )
    score_bg.x , score_bg.y = _SCREEN.CENTER.X *0.33 , _SCREEN.CENTER.Y * 0.12

    bottle_morning = display.newImageRect( _parent , "images/start/bottle_morning.png", 100 , 140 )
    bottle_morning.x , bottle_morning.y = _SCREEN.CENTER.X *0.25 , _SCREEN.CENTER.Y * 0.7

    cloud1 = display.newImageRect( cloudGroup , "images/start/cloud1.png", 500 , 250 )
    cloud1.x , cloud1.y = _SCREEN.CENTER.X *2.6 , _SCREEN.CENTER.Y * 0.2

    cloud2 = display.newImageRect( cloudGroup , "images/start/cloud2.png", 500 , 250 )
    cloud2.x , cloud2.y = _SCREEN.CENTER.X *2.6 , _SCREEN.CENTER.Y * 0.25

    --生成全部的洞
    for j = 1 , 2 do
        for i = 1 , 4 do 
            hole2back = {}
            hole2back[i] = display.newImageRect( hole_backGroup , "images/hole_back.png", 135 , 50 )
            hole2back[i].x , hole2back[i].y = -70 + 150*i , 450 + 250 * j 
            hole2front = {}
            hole2front[i] = display.newImageRect( hole_frontGroup , "images/hole_front.png", 135 , 50 )
            hole2front[i].x , hole2front[i].y = -70 + 150*i , 450 + 250 * j 
        end

         for i = 5 , 7 do 
            hole2back = {}
            hole2back[i] = display.newImageRect( hole_backGroup , "images/hole_back.png", 135 , 50 )
            hole2back[i].x , hole2back[i].y =  15 + 150*(i - 4) , 315 + 250 * j 
            hole2front = {}
            hole2front[i] = display.newImageRect( hole_frontGroup , "images/hole_front.png", 135 , 50 )
            hole2front[i].x , hole2front[i].y = 15 + 150*(i - 4) , 315 + 250 * j  
        end
    end

    sequence = graphics.newImageSheet( "images/grow_sequence.png", options )
    local sequence_data1 = {
        name = "grow" , 
        start = 1 , 
        count = 28, 
        time = 1500 ,
        loopCount = 1 ,
    }

    local sequence_data2 = {
        name = "grow" , 
        start = 29 , 
        count = 29, 
        time = 1500 ,
        loopCount = 1 ,
    }

    local sequence_data3 = {
        name = "grow" , 
        start = 30 , 
        count = 58, 
        time = 1500 ,
        loopCount = 1 ,
    }

    new_mandora = display.newSprite( sequence , sequence_data1 )
    new_mandora.x , new_mandora.y = _SCREEN.CENTER.X , _SCREEN.CENTER.Y*1.2
    new_mandora.anchorY = 1
    new_mandora.width , new_mandora.height = 110 , 65

    grow_mandora = display.newSprite( sequence, sequence_data2 )
    grow_mandora.x , grow_mandora.y = _SCREEN.CENTER.X , _SCREEN.CENTER.Y*1.2
    grow_mandora.anchorY = 1
    grow_mandora.width , grow_mandora.height = 110 , 65

    old_mandora = display.newSprite( sequence, sequence_data2 )
    old_mandora.x , old_mandora.y = _SCREEN.CENTER.X , _SCREEN.CENTER.Y*1.2
    old_mandora.anchorY = 1
    old_mandora.width , old_mandora.height = 110 , 65

    pullGroup:insert( grow_mandora)
    pullGroup:insert( new_mandora)
    pullGroup:insert( old_mandora)

    _parent:insert(hole_backGroup)
    _parent:insert(pullGroup)
    _parent:insert(hole_frontGroup)

    skip = display.newImageRect( _parent, "images/skip.png", 100*WIDTH , 60*HEIGHT )
    skip.x , skip.y =  _SCREEN.CENTER.X , _SCREEN.CENTER.Y

    skip:addEventListener( "tap", function (  )
        audio.play( survival_tutorialSound )
        leaveMask()
        timer.performWithDelay( 1500, function ( )
            composer.gotoScene( "opening" )
        end )
    end )

     _parent:insert( container )
    _parent:insert( container2 )

    --加入遮罩
    container2.x , container2.y = _SCREEN.CENTER.X , _SCREEN.CENTER.Y
    container.x , container.y = _SCREEN.CENTER.X , _SCREEN.CENTER.Y

    -- mandoraAction()
end

--雲開始移動
moveCloud = function (  )
    transition.to( cloud1 , {time = 15000 , x = - 300 , onRepeat = function (  )
        -- cloud1.x = 100
    end , iterations = -1} )
    transition.to( cloud2 , {time = 12000 , x = - 300 , onRepeat = function (  )
        -- cloud2.x = _SCREEN.CENTER.X * 2.2
    end , iterations = -1} )
end

mandoraAction = function (  )
    new_mandora:play( )
    old_mandora:play( )
end

sequenceNew = function (  )
    -- body
end

sequenceGrow = function (  )
    old.isVisible = false
    grow.isVisible = true
    grow.yScale = 1
    glow.yScale = 1
    grow:play( )
    glowTimer = timer.performWithDelay( 2000 , function (  )
        glow.isVisible = true
    end )
    oldTimer = timer.performWithDelay( 3000, sequenceOld )
end

sequenceOld = function (  )
     old.yScale = 1
     grow.isVisible = false
     glow.isVisible = false
     old.isVisible = true
     old:play( )
     growTimer2 = timer.performWithDelay( 1000 , sequenceGrow )
end

-- --進入下一個scene後出現的mask
showMask = function (  )
    j = math.random( 1,#maskImgData )
    maskImg = display.newImageRect( container , maskImgData[j].path , _SCREEN.W , _SCREEN.H )
    maskImg.x , maskImg.y = 0 , 0

    for i = 1 , #maskData do 
        mask = {}
        md = maskData[i] 
        mask[i] = display.newRect( container2, md.x , md.y, md.width, md.height )
        mask[i]:setFillColor( 0 )
        transition.from(mask[i] , {time = 900 ,x = md.moveX , y = md.moveY })
    end

    transition.from( container, { time = 900 , xScale = 0.1 , yScale = 0.01 ,onComplete = function (  )
        transition.to( container, {time = 500 , xScale = 3 , yScale = 3} )
    end})
end

--離開scene之前產生的mask
leaveMask = function (  )
    j = math.random( 1,#maskImgData )
    maskImg2 = display.newImageRect( container , maskImgData[j].path , _SCREEN.W , _SCREEN.H )
    maskImg2.x , maskImg2.y = 0 , 0

    for i = 1 , #maskData do 
        mask = {}
        md = maskData[i] 
        mask[i] = display.newRect( container2, md.x , md.y, md.width, md.height )
        mask[i]:setFillColor( 0 )
        transition.to(mask[i] , {time = 1400 ,x = md.moveX , y = md.moveY })
    end

    container.xScale , container.yScale = 1 , 1
    transition.to( container, { time = 1400 , xScale = 0.01 , yScale = 0.01 })
end

--=======================================================================================
--Composer
--=======================================================================================

--畫面沒到螢幕上時，先呼叫scene:create
--任務:負責UI畫面繪製
function scene:create(event)
    print('scene:create')
    --把場景的view存在sceneGroup這個變數裡
    local sceneGroup = self.view

   --接下來把會出現在畫面的東西，加進sceneGroup裡面，這個非常重要
   init(sceneGroup)

end


--畫面到螢幕上時，呼叫scene:show
--任務:移除前一個場景，播放音效，開始計時，播放各種動畫
function  scene:show( event)
    local sceneGroup = self.view
    local phase = event.phase

    if( "will" == phase ) then
        print('scene:show will')
        --畫面即將要推上螢幕時要執行的程式碼寫在這邊
        audio.play( bgMusic )
    elseif ( "did" == phase ) then
        print('scene:show did')
        showMask()
        moveCloud()
        --把畫面已經被推上螢幕後要執行的程式碼寫在這邊
        --可能是移除之前的場景，播放音效，開始計時，播放各種動畫

        --移除前一個畫面的元件
      
    end
end


--即將被移除，呼叫scene:hide
--任務:停止音樂，釋放音樂記憶體，停止移動的物體等
function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

    if ( "will" == phase ) then
        print('scene:hide will')
        --畫面即將移開螢幕時，要執行的程式碼
        --這邊需要停止音樂，釋放音樂記憶體，有timer的計時器也可以在此停止
       leaveMask()
    elseif ( "did" == phase ) then
        print('scene:hide did')
        --畫面已經移開螢幕時，要執行的程式碼
        composer.recycleOnSceneChange = true

    end
end

--下一個場景畫面推上螢幕後
--任務:摧毀場景
function scene:destroy( event )
    print('scene:destroy')
    if ("will" == event.phase) then
        --這邊寫下畫面要被消滅前要執行的程式碼

    end
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene