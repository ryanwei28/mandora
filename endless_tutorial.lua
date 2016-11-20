-----------------------------------------------------------------------------------------
--
-- survival_tutorial.lua
-- 進入survival_tutorial


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
physics.start()
physics.setGravity(  0 , 50 )
--=======================================================================================
--宣告各種變數
--=======================================================================================
local background
local skip
local teacher1
local teacher2
local frame
local tutorial 
local board
local dialog1
local dialog2
local text1
local text2 
local glow 
local finger
local doraGroup = display.newGroup( )
local container2 = display.newContainer( _SCREEN.W*2.5 , _SCREEN.H*2.5 )
local container = display.newContainer( _SCREEN.W , _SCREEN.H )
local maskImg
local hole_back
local hole_front
local options = SheetInfo.sheet
local teacherText1 = {
        "等待葉子長大變成熟" , 
        "成熟的葉子會發光" , 
        "用手指把曼陀羅拔出來" , 
        "你拔到了一株曼陀羅" ,
        "讓我們再練習四株看看" ,
        "太棒了！" , 
        "連續拔出成熟的曼陀羅 \r\n可以達成Combo" , 
        "達成Combo可以在時間不夠 \r\n的情況下獲得幫助" , 
    }

local teacherText2 = {
        "非常好！" ,
        "太遲了！再試試看" ,
    }

local doraPosition = {
        { Vx = -150 , x = 90 } , 
        { Vx = -75 , x = 202 } , 
        { Vx =  0 , x = 318 } , 
        { Vx =  75 , x = 429 } , 
        { Vx = 150 , x = 545 } , 
    }

local textNum = 1 
local text2Num = 1
local pullNum = 0
--=======================================================================================
--宣告各種函數函數
--=======================================================================================
local init
local tutorial
local showMask
local leaveMask
local newMandora
local pullMandora
local tutorialComplete
local newMandora_old

--=======================================================================================
--定義各種函式
--=======================================================================================
init = function ( _parent  )
    
    --加入背景
    background = display.newImageRect( _parent , "images/background.png", _SCREEN.W , _SCREEN.H )
    background.x , background.y = _SCREEN.CENTER.X , _SCREEN.CENTER.Y

    --加入各項物件
    skip = display.newImageRect( _parent, "images/skip.png", 100*WIDTH , 60*HEIGHT )
    skip.x , skip.y =  _SCREEN.CENTER.X*0.2 , _SCREEN.CENTER.Y*1.7

    board = display.newImageRect( _parent, "images/board.png" , _SCREEN.W , 250*HEIGHT)
    board.x , board.y = _SCREEN.CENTER.X , _SCREEN.CENTER.Y*0.22

    teacher1 = display.newImage( _parent, "images/teacher1.png")
    teacher1.x , teacher1.y = _SCREEN.CENTER.X*0.35 , _SCREEN.CENTER.Y*0.9

    teacher2 = display.newImage( _parent, "images/teacher2.png")
    teacher2.x , teacher2.y = _SCREEN.CENTER.X*1.7 , _SCREEN.CENTER.Y*1.6

    frame = display.newImageRect( _parent, "images/frame.png",_SCREEN.W , 750*HEIGHT)
    frame.x , frame.y = _SCREEN.CENTER.X , _SCREEN.CENTER.Y*1.15

    dialog1 = display.newImageRect( _parent, "images/dialog1.png", 500*WIDTH, 120*HEIGHT)
    dialog1.x , dialog1.y = _SCREEN.CENTER.X*1.1 , _SCREEN.CENTER.Y*0.65
    dialog1.alpha = 0
    text1 = display.newText( _parent , teacherText1[1] ,_SCREEN.CENTER.X*1.1 , _SCREEN.CENTER.Y*0.64, font , 30 )
    text1.alpha = 0 
    text1:setFillColor(0)

    dialog2 = display.newImageRect( _parent, "images/dialog2.png",300*WIDTH , 100*HEIGHT )
    dialog2.x , dialog2.y = _SCREEN.CENTER.X*0.9 , _SCREEN.CENTER.Y*1.6
    dialog2.alpha = 0
    text2 = display.newText( _parent , teacherText2[text2Num] ,_SCREEN.CENTER.X*0.9 , _SCREEN.CENTER.Y*1.6, font , 30 )
    text2.alpha = 0 
    text2:setFillColor(0)

    hole_back = display.newImageRect( _parent, "images/hole_back.png", 160 , 80 )
    hole_back.x , hole_back.y = _SCREEN.CENTER.X , _SCREEN.CENTER.Y*1.2
    hole_back.isVisible = false

    sequence = graphics.newImageSheet( "images/grow_sequence.png", options )
    local sequence_data1 = {
        name = "grow" , 
        start = 1 , 
        count = 29, 
        time = 1500 ,
        loopCount = 1 ,
    }

    grow = display.newSprite( sequence, sequence_data1 )
    grow.x , grow.y = _SCREEN.CENTER.X , _SCREEN.CENTER.Y*1.2
    grow.anchorY = 1
    grow.width , grow.height = 110 , 65
    grow.isVisible = false

    sequence_data2 = {
        name = "old" , 
        start = 30 , 
        count = 58 , 
        time = 2000 ,
        loopCount = 1 ,
    }

    old = display.newSprite( sequence , sequence_data2 )
    old.x , old.y = _SCREEN.CENTER.X , _SCREEN.CENTER.Y*1.2
    old.anchorY = 1
    old.width , old.height = 110 , 65
    old.isVisible = false

    glow = display.newImageRect( _parent , "images/glow.png", 120 , 60 )
    glow.x , glow.y = _SCREEN.CENTER.X , _SCREEN.CENTER.Y* 1.187
    glow.anchorY = 1
    glow.isVisible = false
    _parent:insert( grow )
    _parent:insert( old )

    hole_front = display.newImageRect( _parent , "images/hole_front.png", 160 , 80 )
    hole_front.x ,hole_front.y = _SCREEN.CENTER.X , _SCREEN.CENTER.Y *1.2
    hole_front.isVisible = false

    finger = display.newImageRect( _parent , "images/finger.png", 100 , 100 )
    finger.x , finger.y = _SCREEN.CENTER.X , _SCREEN.CENTER.Y * 1.17
    finger.isVisible = false

    tutorial = display.newImageRect( _parent, "images/banner.png", 2000*WIDTH , 1000*HEIGHT)
    tutorial.x , tutorial.y = _SCREEN.CENTER.X , _SCREEN.CENTER.Y
    tutorial.isVisible = false

    _parent:insert (doraGroup)
    _parent:insert( container )
    _parent:insert( container2 )

    --加入遮罩
    container2.x , container2.y = _SCREEN.CENTER.X , _SCREEN.CENTER.Y
    container.x , container.y = _SCREEN.CENTER.X , _SCREEN.CENTER.Y

    --加入偵聽
    grow:addEventListener( "touch", pullMandora )
    old:addEventListener( "touch", pullOldMandora )
    --返回
    skip:addEventListener( "tap", function (  )
        audio.play( survival_tutorialSound )
        leaveMask()
        timer.performWithDelay( 1500, function ( )
            composer.gotoScene( "opening" )
        end )
    end )
end

--成熟的mandora
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

--過老的mandora
sequenceOld = function (  )
     old.yScale = 1
     grow.isVisible = false
     glow.isVisible = false
     old.isVisible = true
     old:play( )
     growTimer2 = timer.performWithDelay( 1000 , sequenceGrow )
end

--拔起曼陀羅產生一個新的mature
newMandora = function (  )
    pullNum = pullNum + 1 
    -- text2Num = 1
    mature = display.newImageRect( doraGroup ,"images/mature.png", 160 , 130 )
    physics.addBody( mature , "dynamics" )
    mature.x , mature.y  = _SCREEN.CENTER.X , _SCREEN.CENTER.Y*1.2
    mature:setLinearVelocity( doraPosition[pullNum].Vx , -1500 )
    timer.performWithDelay( 1400 , function (  )
        physics.removeBody( mature )
        transition.to( mature , {time = 100 , x = doraPosition[pullNum].x , y = 135 } )
    end )
end

--拔起老的曼陀羅產生一個old_mature
newMandora_old = function (  )
    -- text2Num = 2
    old_mature = display.newImageRect( doraGroup , "images/old_mature.png" , 160 , 130 )
    old_mature.x , old_mature.y  = _SCREEN.CENTER.X , _SCREEN.CENTER.Y*1.2
    physics.addBody( old_mature, "dynamics" )
    old_mature:setLinearVelocity( 400 , -800 )
end

pullOldMandora = function ( e )
    local phase = e.phase
    if (phase == "began") then
        display.getCurrentStage():setFocus( e.target )
        if (oldTimer) then
            timer.cancel( oldTimer )
        end

        if (growTimer2) then
            timer.cancel( growTimer2 )
        end

        if ( glowTimer ) then 
            timer.cancel( glowTimer )
        end
    elseif (phase == "moved") then 
        dy = e.y - e.yStart 
        if ( dy < -20 ) and (dy > -60 ) then
            old.yScale = -dy/20
        end 
    elseif (phase == "ended") then 
        display.getCurrentStage():setFocus(nil)
        if ( dy ) then
            text2Num = 2
            growTimer = timer.performWithDelay( 1400 , sequenceGrow )                   
            newMandora_old()
            teacherTalk2()
            old.isVisible = false
        end
    end
end

--Mandora拔起產生動作
pullMandora = function ( e )
    local phase = e.phase
    if (phase == "began") then
        display.getCurrentStage():setFocus( e.target )
        transition.cancel( finger.tran )
        finger.alpha = 0
        if (oldTimer) then
            timer.cancel( oldTimer )
        end

        if (growTimer2) then
            timer.cancel( growTimer2 )
        end

        if ( glowTimer ) then 
            timer.cancel( glowTimer )
        end
    elseif (phase == "moved") then 
        dy = e.y - e.yStart 
        if ( dy < -20 ) and (dy > -60 ) then
            grow.yScale = -dy/20
            glow.yScale = -dy/20
        end 
    elseif (phase == "ended") then 
        if ( dy ) then
            if ( dy < -20 ) then 
                if (pullNum == 0) then
                    dialog1.alpha = 0 
                    dialog1.y = _SCREEN.CENTER.Y*0.65
                    text1.alpha = 0 
                    text1.y = _SCREEN.CENTER.Y*0.64
                    textNum = textNum + 1 
                    text1.text = teacherText1[textNum]
                    transition.to( dialog1 , {time = 2500 , y = _SCREEN.CENTER.Y*0.63 ,alpha = 1 , onRepeat = function (  )
                        textNum = textNum + 1 
                        dialog1.alpha = 0 
                        dialog1.y = _SCREEN.CENTER.Y*0.65
                    end , iterations = 2} )
                    transition.to( text1 , {time = 2500 , y = _SCREEN.CENTER.Y*0.62 , alpha = 1 , onRepeat = function (  )
                        text1.text = teacherText1[textNum]
                        text1.alpha = 0 
                        text1.y = _SCREEN.CENTER.Y*0.64
                    end , iterations = 2 } )
                end
                grow.isVisible = false
                glow.isVisible = false
                display.getCurrentStage():setFocus(nil)
                text2Num = 1
                teacherTalk2()

                if (pullNum <= #doraPosition - 2) then
                    growTimer = timer.performWithDelay( 1400 , sequenceGrow )                   
                end
              
                if (pullNum <= #doraPosition - 1 ) then
                    newMandora()
                    if (oldTimer) then
                        timer.cancel( oldTimer )
                    end

                    if (growTimer2) then
                        timer.cancel( growTimer2 )
                    end

                    if ( glowTimer ) then 
                        timer.cancel( glowTimer )
                    end
                end
                
                if (pullNum == #doraPosition ) then 
                    tutorialComplete()
                end
            end
        end
    end
end
--teacher1 開始講話，曼陀羅狀態初始化
teacherTalk = function (  )
    hole_back.isVisible = true
    hole_front.isVisible = true

    dai1Tran = transition.to(  dialog1 , {time = 2500 , y = _SCREEN.CENTER.Y*0.63 , alpha = 1 , onComplete = function (  )
        dialog1.alpha = 0 
        dialog1.y = _SCREEN.CENTER.Y*0.65
        grow.isVisible = true
        grow:play( )
        timer.performWithDelay( 2000 , function ( )
            glow.isVisible = true
        end )
         timer.performWithDelay( 3000 , function (  )
            finger.isVisible = true
            finger.tran = transition.to( finger, {time = 2800 , y = _SCREEN.CENTER.Y* 0.95 , alpha = 0 , transition =  easing.outQuart , onComplete = function (  )
                 finger.alpha = 1 
                finger.y = _SCREEN.CENTER.Y*1.17
            end , iterations = -1} )
        end )
    end} )
    transition.to( text1 , {time = 2500 , y = _SCREEN.CENTER.Y*0.62 , alpha = 1 , onRepeat = function (  )
        textNum = textNum + 1 
        text1.text = teacherText1[textNum]
        text1.y = _SCREEN.CENTER.Y*0.64
        text1.alpha = 0 
    end , onComplete = function (  )
        text1.y = _SCREEN.CENTER.Y*0.62
        text1.alpha = 1 
    end, iterations = 3} )
    transition.to(  dialog1 , {time = 2500 , y = _SCREEN.CENTER.Y*0.63 , alpha = 1 , onRepeat = function (  )
        dialog1.alpha = 0 
        dialog1.y = _SCREEN.CENTER.Y*0.65
    end , iterations = 3} )
end

--teacher2講話
teacherTalk2 = function (  )
    text2.text = teacherText2[text2Num]
    transition.to( dialog2 , {time = 1200 , y = _SCREEN.CENTER.Y * 1.58 , alpha = 1 , onComplete = function (  )
        dialog2.alpha = 0 
        dialog2.y = _SCREEN.CENTER.Y * 1.6
    end} )
    transition.to( text2 , {time = 1200 , y = _SCREEN.CENTER.Y * 1.58 , alpha = 1 , onComplete = function (  )
        text2.alpha = 0 
        text2.y = _SCREEN.CENTER.Y * 1.6
    end} )
end

--完成教學
tutorialComplete = function (  )
    dialog1.alpha = 0 
    dialog1.y = _SCREEN.CENTER.Y * 0.65
    text1.alpha = 0 
    text1.y = _SCREEN.CENTER.Y*0.64
    textNum = textNum + 1
    text1.text = teacherText1[textNum]
    transition.to( dialog1 , {time = 2500 , alpha = 1 , y = _SCREEN.CENTER.Y *0.63 , onRepeat = function (  )
        dialog1.alpha = 0 
        dialog1.y = _SCREEN.CENTER.Y * 0.65
    end , iterations = 3 } )
    transition.to( text1 , {time = 2500 , alpha = 1 , y = _SCREEN.CENTER.Y *0.62 , onRepeat = function (  )
        textNum = textNum + 1
        text1.text = teacherText1[textNum]
        text1.alpha = 0 
        text1.y = _SCREEN.CENTER.Y * 0.64
    end ,iterations = 3 } )
    timer.performWithDelay( 8000 , function ( )
        leaveMask()
        timer.performWithDelay( 1500 , function (  )
            composer.gotoScene( "opening")
        end )
    end )
end

--停止計時
stopTimer = function (  )
    if (oldTimer) then
        timer.cancel( oldTimer )
    end

    if (growTimer2) then
        timer.cancel( growTimer2 )
    end

    if (glowTimer) then
        timer.cancel( glowTimer )
    end

    -- if (dia1Tran) then
        transition.cancel( dia1Tran )
    -- end
end

--進入後開始tutorial
tutorialStart = function (  )
    timer.performWithDelay( 1400 , function (  )
        tutorial.isVisible = true
        transition.to( tutorial , {time = 500 , xScale = 0.2 , yScale = 0.2 , onComplete = function ( )
            timer.performWithDelay( 500, function (  )
                tutorial.isVisible = false
                tutorial.xScale , tutorial.yScale = 1 , 1
                teacherTalk()
            end )    
        end} )
    end )
end

--進入下一個scene後出現的mask
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
    elseif ( "did" == phase ) then
        print('scene:show did')
        --把畫面已經被推上螢幕後要執行的程式碼寫在這邊
        --可能是移除之前的場景，播放音效，開始計時，播放各種動畫
        tutorialStart()
        showMask()
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
        composer.recycleOnSceneChange = true
        stopTimer()
        
    elseif ( "did" == phase ) then
        print('scene:hide did')
        --畫面已經移開螢幕時，要執行的程式碼
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