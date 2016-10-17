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
local container2 = display.newContainer( _SCREEN.W*2.5 , _SCREEN.H*2.5 )
local container = display.newContainer( _SCREEN.W , _SCREEN.H )
local maskImg
--=======================================================================================
--宣告各種函數函數
--=======================================================================================
local init
local tutorial
local showMask
local leaveMask
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
    dialog1.x , dialog1.y = _SCREEN.CENTER.X*1.1 , _SCREEN.CENTER.Y*0.63

    dialog2 = display.newImageRect( _parent, "images/dialog2.png",300*WIDTH , 100*HEIGHT )
    dialog2.x , dialog2.y = _SCREEN.CENTER.X*0.9 , _SCREEN.CENTER.Y*1.6

    tutorial = display.newImageRect( _parent, "images/banner.png", 2000*WIDTH , 1000*HEIGHT)
    tutorial.x , tutorial.y = _SCREEN.CENTER.X , _SCREEN.CENTER.Y
    tutorial.isVisible = false

    _parent:insert( container )
    _parent:insert( container2 )

    --加入遮罩
    container2.x , container2.y = _SCREEN.CENTER.X , _SCREEN.CENTER.Y
    container.x , container.y = _SCREEN.CENTER.X , _SCREEN.CENTER.Y

    skip:addEventListener( "tap", function (  )
        audio.play( survival_tutorialSound )
        leaveMask()
        timer.performWithDelay( 1500, function ( )
            composer.gotoScene( "opening" )
        end )
    end )
end

--進入後開始tutorial
tutorialStart = function (  )
    timer.performWithDelay( 1400 , function (  )
        tutorial.isVisible = true
        transition.to( tutorial , {time = 500 , xScale = 0.2 , yScale = 0.2 , onComplete = function ( )
            timer.performWithDelay( 500, function (  )
                tutorial.isVisible = false
                tutorial.xScale , tutorial.yScale = 1 , 1
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
        -- reset()
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