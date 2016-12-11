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
local carrotGroup = display.newGroup( )
local front 
local endless_clock
local score_bg 
local bottle_morning
local cloud1
local cloud2 
local beganStart = false
local options = SheetInfo.sheet
local new_mandora
local grow_mandora = {}
local old_mandora = {}
local new_mandora = {}
local glow = {}
local numData = {11,12,13,14,15,16,17,21,22,23,24,25,26,27}
local carrotsData = {  "mandora/seedling.png" ,
                       "mandora/mature.png" ,
                       "mandora/withered.png" ,
                     }


--=======================================================================================
--宣告各種函數函數
--=======================================================================================
local init
local moveCloud
local sequenceNew
local sequenceGrow
local sequenceOld
local createAllHole
local pullNewMandora
local pullMandora
local pullOldMandora
local bezierCurve

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

    cloud1 = display.newImageRect( cloudGroup , "images/start/cloud1.png", 500 , 250 )
    cloud1.x , cloud1.y = _SCREEN.CENTER.X *2.6 , _SCREEN.CENTER.Y * 0.2

    cloud2 = display.newImageRect( cloudGroup , "images/start/cloud2.png", 500 , 250 )
    cloud2.x , cloud2.y = _SCREEN.CENTER.X *2.6 , _SCREEN.CENTER.Y * 0.25

    _parent:insert(hole_backGroup)
    _parent:insert(pullGroup)
    createAllHole(_parent)
    _parent:insert(hole_frontGroup)
    _parent:insert( carrotGroup )
    
    bottle_morning = display.newImageRect( _parent , "images/start/bottle_morning.png", 100 , 140 )
    bottle_morning.x , bottle_morning.y = _SCREEN.CENTER.X *0.25 , _SCREEN.CENTER.Y * 0.7

    skip = display.newImageRect( _parent, "images/skip.png", 100*WIDTH , 60*HEIGHT )
    skip.x , skip.y =  _SCREEN.CENTER.X , _SCREEN.CENTER.Y*0.4

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


    timer.performWithDelay( 100 , function (  )

        if #numData > 0 then
            getNum = math.random( 1 , #numData )
            saveNum = numData[getNum]
            sub_k = string.sub( numData[getNum] , 1 , 1)
            sub_l = string.sub( numData[getNum] , 2 , 2)
            k = tonumber( sub_k )
            l = tonumber( sub_l )

            sequenceNew( k , l , saveNum )
            table.remove( numData , getNum )
        end
    end , -1 )
end

--迴圈產生各動畫
createAllHole = function ( _parent )
    --mandora動畫
    sequence = graphics.newImageSheet( "images/grow_sequence.png", options )
    local sequence_data1 = {
        name = "new_mandora" , 
        start = 1 , 
        count = 28, 
        time = 1500 ,
        loopCount = 1 ,
    }

    local sequence_data2 = {
        name = "grow_mandora" , 
        start = 29 , 
        count = 30, 
        time = 1500 ,
        loopCount = 1 ,
    }

    local sequence_data3 = {
        name = "old_mandoras" , 
        start = 30 , 
        count = 58, 
        time = 1500 ,
        loopCount = 1 ,
    }

    --生成全部的洞和mandora
    for j = 1 , 2 do
        new_mandora[j] = {}
        grow_mandora[j] = {}
        glow[j] = {}
        old_mandora[j] = {}
        for i = 1 , 4 do 
            
            hole2back = {}
            hole2back[i] = display.newImageRect( hole_backGroup , "images/hole_back.png", 135 , 50 )
            hole2back[i].x , hole2back[i].y = -70 + 150*i , 450 + 250 * j 
            hole2front = {}
            hole2front[i] = display.newImageRect( hole_frontGroup , "images/hole_front.png", 135 , 50 )
            hole2front[i].x , hole2front[i].y = -70 + 150*i , 450 + 250 * j 
           
            new_mandora[j][i] = display.newSprite( sequence , sequence_data1 )
            new_mandora[j][i].x , new_mandora[j][i].y = -70 + 150*i , 450 + 250 * j 
            new_mandora[j][i].anchorY = 1
            new_mandora[j][i].width , new_mandora[j][i].height = 110 , 65
            new_mandora[j][i].isVisible = false
            new_mandora[j][i].id = j..i

            grow_mandora[j][i] = display.newSprite( sequence , sequence_data2 )
            grow_mandora[j][i].x , grow_mandora[j][i].y = -70 + 150*i , 450 + 250 * j 
            grow_mandora[j][i].anchorY = 1
            grow_mandora[j][i].width , grow_mandora[j][i].height = 90 , 65
            grow_mandora[j][i].isVisible = false
            grow_mandora[j][i].id = j..i

            glow[j][i] = display.newImageRect( pullGroup , "images/glow.png", 120 , 60 )
            glow[j][i].x , glow[j][i].y = -70 + 150*i , 440 + 250 * j 
            glow[j][i].isVisible = false
            glow[j][i].anchorY = 1

            old_mandora[j][i] = display.newSprite( sequence , sequence_data3 )
            old_mandora[j][i].x , old_mandora[j][i].y = -70 + 150*i , 450 + 250 * j 
            old_mandora[j][i].anchorY = 1
            old_mandora[j][i].width , old_mandora[j][i].height = 110 , 65
            old_mandora[j][i].isVisible = false
            old_mandora[j][i].id = j..i

            pullGroup:insert( grow_mandora[j][i])
            pullGroup:insert( new_mandora[j][i])
            pullGroup:insert( old_mandora[j][i])

            new_mandora[j][i]:addEventListener( "touch", pullNewMandora )
            grow_mandora[j][i]:addEventListener( "touch", pullMandora )
            old_mandora[j][i]:addEventListener( "touch", pullOldMandora )
        end

         for i = 5 , 7 do 

            hole2back[i] = display.newImageRect( hole_backGroup , "images/hole_back.png", 135 , 50 )
            hole2back[i].x , hole2back[i].y =  15 + 150*(i - 4) , 315 + 250 * j 
            hole2front[i] = display.newImageRect( hole_frontGroup , "images/hole_front.png", 135 , 50 )
            hole2front[i].x , hole2front[i].y = 15 + 150*(i - 4) , 315 + 250 * j  

            new_mandora[j][i] = display.newSprite( sequence , sequence_data1 )
            new_mandora[j][i].x , new_mandora[j][i].y = 15 + 150*(i - 4) , 315 + 250 * j  
            new_mandora[j][i].anchorY = 1
            new_mandora[j][i].width , new_mandora[j][i].height = 110 , 65
            new_mandora[j][i].isVisible = false
            new_mandora[j][i].id = j..i

            grow_mandora[j][i] = display.newSprite( sequence , sequence_data2 )
            grow_mandora[j][i].x , grow_mandora[j][i].y = 15 + 150*(i - 4) , 315 + 250 * j  
            grow_mandora[j][i].anchorY = 1
            grow_mandora[j][i].width , grow_mandora[j][i].height = 90 , 65
            grow_mandora[j][i].isVisible = false
            grow_mandora[j][i].id = j..i

            glow[j][i] = display.newImageRect( _parent , "images/glow.png", 120 , 60 )
            glow[j][i].x , glow[j][i].y = 15 + 150*(i - 4) , 305 + 250 * j 
            glow[j][i].anchorY = 1
            glow[j][i].isVisible = false

            old_mandora[j][i] = display.newSprite( sequence , sequence_data3 )
            old_mandora[j][i].x , old_mandora[j][i].y = 15 + 150*(i - 4) , 315 + 250 * j  
            old_mandora[j][i].anchorY = 1
            old_mandora[j][i].width , old_mandora[j][i].height = 110 , 65
            old_mandora[j][i].isVisible = false
            old_mandora[j][i].id = j..i

            pullGroup:insert( grow_mandora[j][i])
            pullGroup:insert( new_mandora[j][i])
            pullGroup:insert( old_mandora[j][i])

            new_mandora[j][i]:addEventListener( "touch", pullNewMandora )
            grow_mandora[j][i]:addEventListener( "touch", pullMandora )
            old_mandora[j][i]:addEventListener( "touch", pullOldMandora )
        end
    end
end

--雲開始移動
moveCloud = function (  )
    transition.to( cloud1 , {time = 15000 , x = - 300 , transition = easing.outSine , onRepeat = function (  )
        -- cloud1.x = 100
    end , iterations = -1} )
    transition.to( cloud2 , {time = 12000 , x = - 300 , transition = easing.outInSine , onRepeat = function (  )
        -- cloud2.x = _SCREEN.CENTER.X * 2.2
    end , iterations = -1} )
end

--new mandora 動畫出現
sequenceNew = function ( k , l , saveNum)
    new_mandora[k][l].yScale = 1
    new_mandora[k][l].isVisible = true
    new_mandora[k][l]:play( )
    new_mandora[k][l].newTimer = timer.performWithDelay( 1500 , function (  )
        sequenceGrow( k , l ,saveNum)
    end )
end

--grow mandora 動畫出現
sequenceGrow = function ( k , l , saveNum)
    new_mandora[k][l].isVisible = false
    grow_mandora[k][l].isVisible = true
    grow_mandora[k][l].yScale = 1
    glow[k][l].yScale = 1
    glow[k][l].isVisible = true
    grow_mandora[k][l].growTimer = timer.performWithDelay( 1500 , function (  )
        glow[k][l].isVisible = false
        sequenceOld(k , l , saveNum)
    end )
end

--old mandora 動畫出現
sequenceOld = function (k , l , saveNum)
     old_mandora[k][l].yScale = 1
     old_mandora[k][l].xScale = 1
     grow_mandora[k][l].isVisible = false
     old_mandora[k][l].isVisible = true
     old_mandora[k][l]:play( )
     old_mandora[k][l].oldTimer = timer.performWithDelay( 1500 , function (  )
         transition.to( old_mandora[k][l] , {timer = 1000 , xScale = 0.4 , yScale = 0.4 , onComplete = function (  )
            old_mandora[k][l].isVisible = false
            table.insert( numData , #numData + 1 , saveNum )
         end} )
     end )
end

--拉起new mandora
pullNewMandora = function ( e )
    local phase = e.phase

    if (phase == "began") then
        beganStart = true
        print( "began" )
        display.getCurrentStage():setFocus( e.target )
        timer.pause( e.target.newTimer )    
    elseif (phase == "moved") then
        if (beganStart == true) then
            local dy = e.y - e.yStart 
            local sub_k = string.sub( e.target.id , 1 , 1)
            local sub_l = string.sub( e.target.id , 2 , 2)
            local k = tonumber( sub_k )
            local l = tonumber( sub_l )
            
            if ( dy < -20 ) and (dy > -60 ) then
                e.target.yScale = -dy/25
            elseif (dy <= -60 ) then
                local target = e.target
                carrotNum = 1
                target.isVisible = false
                timer.cancel( e.target.newTimer )    
                carrotJump(target)
                beganStart = false
                display.getCurrentStage():setFocus(nil)
                table.insert( numData , #numData + 1 , k..l )
            end 
        end
    elseif(phase == "ended") then
        if(beganStart == true) then
            timer.resume( e.target.newTimer )
            display.getCurrentStage():setFocus(nil)
            beganStart = false
        end
    end
end

--拉起grow mandora 
pullMandora = function ( e )
    local phase = e.phase

    if (phase == "began") then
        beganStart = true
        print( "began" )
        display.getCurrentStage():setFocus( e.target )
        timer.pause( e.target.growTimer )    
    elseif (phase == "moved") then
        if (beganStart == true) then
            local dy = e.y - e.yStart 

            local sub_k = string.sub( e.target.id , 1 , 1)
            local sub_l = string.sub( e.target.id , 2 , 2)
            local k = tonumber( sub_k )
            local l = tonumber( sub_l )

            if ( dy < -20 ) and (dy > -60 ) then
                e.target.yScale = -dy/25
                print( k,l )
                glow[k][l].yScale = -dy/25

            elseif (dy <= -60 ) then
                local target = e.target
                carrotNum = 2
                target.isVisible = false
                glow[k][l].isVisible = false
                timer.cancel( e.target.growTimer )    
                carrotJump(target)
                beganStart = false
                display.getCurrentStage():setFocus(nil)
                table.insert( numData , #numData + 1 , k..l )
            end 
        end
    elseif(phase == "ended") then
        if(beganStart == true) then
            print( "ended" )
            timer.resume( e.target.growTimer )
            display.getCurrentStage():setFocus(nil)
            beganStart = false
        end
    end
end

--拉起old mandora 
pullOldMandora = function ( e )
    local phase = e.phase

    if (phase == "began") then
        beganStart = true
        print( "began" )
        display.getCurrentStage():setFocus( e.target )
        timer.pause( e.target.oldTimer )    
    elseif (phase == "moved") then
        if (beganStart == true) then
            local dy = e.y - e.yStart 
            local sub_k = string.sub( e.target.id , 1 , 1)
            local sub_l = string.sub( e.target.id , 2 , 2)
            local k = tonumber( sub_k )
            local l = tonumber( sub_l )
            
            if ( dy < -20 ) and (dy > -60 ) then
                e.target.yScale = -dy/25
            elseif (dy <= -60 ) then
                local target = e.target
                carrotNum = 3
                target.isVisible = false
                timer.cancel( e.target.oldTimer )    
                carrotJump(target)
                beganStart = false
                display.getCurrentStage():setFocus(nil)
                table.insert( numData , #numData + 1 , k..l )
            end 
        end
    elseif(phase == "ended") then
        if(beganStart == true) then
            print( "ended" )
            timer.resume( e.target.oldTimer )
            display.getCurrentStage():setFocus(nil)
            beganStart = false
        end

    end
end

--拔出mandora,跳出一個carrot
carrotJump = function ( target )
    local carrot = display.newImageRect( carrotGroup , carrotsData[carrotNum], 180 , 180 )
    carrot.x , carrot.y = target.x , target.y
    bezierCurve(carrot , carrot.x , carrot.y , _SCREEN.CENTER.X *0.25 , _SCREEN.CENTER.Y * 0.6 , 400 , -200 )
    transition.to( carrot , {time = 800 , xScale = 0.7 , yScale = 0.7} )
    timer.performWithDelay( 800 , function (  )
        transition.to( bottle_morning , { time = 200 , xScale = 1.3 , transition = easing.continuousLoop })
        carrot.isVisible = false
    end )
end

-- target :要操控的元件, ox :起點x座標 , oy: 起點y座標 , dx :終點x座標 , dy : 終點y座標  , mx : 控制點x座標 , my : 控制點y座標
function bezierCurve( target , ox , oy , dx , dy , mx , my)
    local timeVal = 0
    timer.performWithDelay( 10, function ( e )
        timeVal = timeVal + 0.04
        local px = (1-timeVal)*((1-timeVal)*ox + timeVal*mx) + timeVal*((1-timeVal)*mx + timeVal*dx)
        local py = (1-timeVal)*((1-timeVal)*oy + timeVal*my) + timeVal*((1-timeVal)*my + timeVal*dy)
        target.x , target.y = px , py

        if (math.abs(px - dx) <= 1 and math.abs(py - dy) <= 1) then
            timer.cancel( e.source )
        end
    end , -1 )
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

--關閉timer
timerTurnOff = function (  )
    for j = 1 , 2 do
        for i = 1 , 7 do 
            timer.cancel( new_mandora[j][i].newTimer ) 
            timer.cancel( grow_mandora[j][i].growTimer )
            timer.cancel( old_mandora[j][i].oldTimer )
        end
    end
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
       timerTurnOff()
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