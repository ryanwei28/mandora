-----------------------------------------------------------------------------------------
--
-- opening.lua
-- 進入opening 開場畫面


-- Author: Ryan
-- Time: 2016/9/24
--
-----------------------------------------------------------------------------------------

--=======================================================================================
--引入各種函式庫
--=======================================================================================
local scene = composer.newScene( )
--=======================================================================================
--宣告各種變數
--=======================================================================================
local opening1
local opening2
local sky
local openGroup = display.newGroup( )
local treehouse
local houseGroup = display.newGroup( )
local cloudGroup1 = display.newGroup( )
local cloudGroup2 = display.newGroup( )
local btnGroup = display.newGroup( )
local backPackageGroup = display.newGroup( )
local frontPackageGroup = display.newGroup( )
local packageGroup = display.newGroup( )
local logoGroup = display.newGroup( )
local package_front
local package_back
local mandora_logo
local straps
local rock
local rock_back
local play
local back
local play_wood
local survival_spring
local survival_shadow
local survival_tutorial
local endless 
local endless_tutorial
local cloud1
local cloud2
local book_light
stSound = audio.loadSound( "images/mandora/1st.mp3" )
ahoyySound = audio.loadSound( "images/mandora/ahoyy.mp3" )
appleSound = audio.loadSound( "images/mandora/apple.mp3" )
batooSound = audio.loadSound( "images/mandora/batoo.mp3" )
bearnieSound = audio.loadSound( "images/mandora/bearnie.mp3" )
beerboSound = audio.loadSound( "images/mandora/beerbo.mp3" )
bikidoraSound = audio.loadSound( "images/mandora/bikidora.mp3" )
bomboSound = audio.loadSound( "images/mandora/bombo.mp3" )
caishenSound = audio.loadSound( "images/mandora/caishen.mp3" )
chocoSound = audio.loadSound( "images/mandora/choco.mp3" )

local houseData = {
      {path = "images/1.png" , x = 1, y = 1,width = 230, height = 300} ,
      {path = "images/2.png" , x = 1, y = 1,width = 250, height = 300} ,
      {path = "images/3.png" , x = 1, y = 1,width = 210, height = 320} ,
      {path = "images/4.png" , x = 1, y = 1,width = 220, height = 300} ,
      {path = "images/5.png" , x = 1, y = 1,width = 300, height = 300}
      }

boxData = {
        { path = "images/mandora/1st.png" , sound = stSound } ,
        { path = "images/mandora/ahoyy.png" , sound = ahoyySound } ,
        { path = "images/mandora/alohama.png" , sound = ahoyySound } ,
        { path = "images/mandora/apple.png" , sound = appleSound } ,
        { path = "images/mandora/batoo.png" , sound = batooSound } ,
        { path = "images/mandora/bearnie.png" , sound = bearnieSound} ,
        { path = "images/mandora/beerbo.png" , sound = beerboSound } ,
        { path = "images/mandora/bikidora.png" , sound = bikidoraSound } ,
        { path = "images/mandora/bombo.png" , sound = bomboSound } ,
        { path = "images/mandora/caishen.png" , sound = caishenSound } ,
        { path = "images/mandora/choco.png" , sound = chocoSound } ,
    }

maskData = {
        { x = 0 , y = _SCREEN.H*0.75 , width = _SCREEN.W*2 , height = _SCREEN.H*0.5  , moveX = 0 , moveY = _SCREEN.H*0.25} ,
        { x = 0 , y = -_SCREEN.H*0.75 , width = _SCREEN.W*2 , height = _SCREEN.H*0.5 , moveX = 0  , moveY = -_SCREEN.H*0.25} ,
        { x = -_SCREEN.W*0.75 , y = 0 , width = _SCREEN.W*0.5 , height = _SCREEN.H*2 , moveX = -_SCREEN.W*0.25 , moveY = 0} ,
        { x = _SCREEN.W*0.75 , y = 0 , width = _SCREEN.W*0.5 , height = _SCREEN.H*2 , moveX = _SCREEN.W*0.25 , moveY = 0} ,
    }

maskImgData = {
        {path = "images/masks/1.png"} ,
        {path ="images/masks/2.png"} ,
        {path ="images/masks/3.png"} ,
        {path ="images/masks/4.png"} ,
        {path ="images/masks/5.png"} ,
        {path ="images/masks/6.png"} ,
    }

--=======================================================================================
--宣告各種函數函數
--=======================================================================================
local init
local boxListener
local audioPlay
local audioStop
--=======================================================================================
--定義各種函式
--=======================================================================================
init = function ( sceneGroup )
    
    --將各群組加入sceneGroup
    sceneGroup:insert( openGroup )
    sceneGroup:insert( houseGroup )
    sceneGroup:insert( cloudGroup1 )
    sceneGroup:insert( cloudGroup2 )
    sceneGroup:insert( btnGroup )
    sceneGroup:insert( packageGroup )
    sceneGroup:insert( logoGroup )
    packageGroup:insert(backPackageGroup)
    packageGroup:insert( frontPackageGroup )
    physics.start( )
    physics.setGravity( 0 , 80 )
       
    --加入mandroa logo
    mandora_logo = display.newImageRect( logoGroup, "images/mandora_logo.png" , 600*HEIGHT , 600 * HEIGHT )
    mandora_logo.x , mandora_logo.y = _SCREEN.CENTER.X , _SCREEN.CENTER.Y *2.8

    --加入選項齒輪
    straps = display.newImage( logoGroup, "images/straps.png" )
    straps.anchorY = 0
    straps.rotation = -5
    straps.x , straps.y = _SCREEN.CENTER.X * 0.25 , _SCREEN.CENTER.Y*3.25

    --開場圖片
    opening1 = display.newImageRect( openGroup , "images/opening1.png", _SCREEN.W , _SCREEN.H )
    opening1.x , opening1.y = _SCREEN.CENTER.X , _SCREEN.CENTER.Y

    opening2 = display.newImageRect( openGroup, "images/opening2.png", _SCREEN.W, _SCREEN.H )
    opening2.x , opening2.y = _SCREEN.CENTER.X , _SCREEN.CENTER.Y * -1

    --天空背景
    sky = display.newImageRect( houseGroup , "images/sky.png", _SCREEN.W*2.5 , _SCREEN.H )
    sky.x , sky.y = _SCREEN.CENTER.X , _SCREEN.CENTER.Y* -3

    --雲朵
    cloud1 = display.newImage( cloudGroup1, "images/cloud1.png" )
    cloud1.x , cloud1.y = _SCREEN.CENTER.X*-0.6 , _SCREEN.CENTER.Y* -3.8

    cloud2 = display.newImage( cloudGroup1, "images/cloud1.png" )
    cloud2.x , cloud2.y = _SCREEN.CENTER.X*3.6 , _SCREEN.CENTER.Y* -3.8

    cloud3 = display.newImage( cloudGroup2, "images/cloud2.png")
    cloud3.x , cloud3.y = _SCREEN.CENTER.X*-0.6 , _SCREEN.CENTER.Y* -3.7

    cloud4 = display.newImage( cloudGroup2, "images/cloud2.png")
    cloud4.x , cloud4.y = _SCREEN.CENTER.X*1.6 , _SCREEN.CENTER.Y* -3.7

    cloud5 = display.newImage( cloudGroup2, "images/cloud2.png")
    cloud5.x , cloud5.y = _SCREEN.CENTER.X*3.6 , _SCREEN.CENTER.Y* -3.7

    houseGroup:insert( cloudGroup1 )
    houseGroup:insert( cloudGroup2 )

    --樹屋背景
    bg_tree = display.newImageRect( houseGroup, "images/bg_tree.png", _SCREEN.W*2.5 , _SCREEN.H*0.75 )
    bg_tree.x , bg_tree.y = _SCREEN.CENTER.X , _SCREEN.CENTER.Y* -2.8

    treehouse = display.newImageRect( houseGroup, "images/treehouse.png", _SCREEN.W*2.5 , _SCREEN.H )
    treehouse.x ,treehouse.y = _SCREEN.CENTER.X , _SCREEN.CENTER.Y*-3

    --樹屋上包裹
    package_front = display.newImage( frontPackageGroup, "images/package_front.png")
    package_front.x , package_front.y = _SCREEN.CENTER.X*0.8 , _SCREEN.CENTER.Y*-2.6

    package_back = display.newImage( backPackageGroup, "images/package_back.png" )
    package_back.x , package_back.y = _SCREEN.CENTER.X*0.8 , _SCREEN.CENTER.Y*-2.6

    houseGroup:insert( packageGroup )
    addHouseDora()

    --BOOK STORE 圖案
    book_light = display.newImage( houseGroup , "images/book_light.png")
    book_light.x , book_light.y = _SCREEN.CENTER.X*-1.05 , _SCREEN.CENTER.Y*-2.17

    --PLAY木板
    play_wood = display.newImage( btnGroup, "images/play_wood.png" )
    play_wood.x , play_wood.y = _SCREEN.CENTER.X * 1.5 , _SCREEN.CENTER.Y* -2.2

    play = display.newImage( btnGroup, "images/play.png" )
    play.x , play.y = _SCREEN.CENTER.X * 1.5 , _SCREEN.CENTER.Y* -2.3

    --石頭
    rock = display.newImage( btnGroup, "images/rock.png" )
    rock.x , rock.y = _SCREEN.CENTER.X * 0.5 , _SCREEN.CENTER.Y * -2.2

    back = display.newImage( btnGroup, "images/back.png" )
    back.x , back.y = _SCREEN.CENTER.X * 2.4 ,_SCREEN.CENTER.Y * -2.2

    rock_back = display.newImage( btnGroup,"images/rock_back.png" )
    rock_back.x , rock_back.y = _SCREEN.CENTER.X * 0.5 , _SCREEN.CENTER.Y * -2.2
    rock_back.isVisible = false

    --endless模式樹葉
    endless = display.newImageRect( btnGroup, "images/endless.png" , 180 *WIDTH , 180 *HEIGHT)
    endless.anchorX = 1
    endless.anchohY = 0.8
    endless.x , endless.y = _SCREEN.CENTER.X * 3.65 ,_SCREEN.CENTER.Y * -2.93

    --endless 教學木板
    endless_tutorial = display.newImageRect( btnGroup, "images/endless_tutorial.png" , 60 *WIDTH , 80*HEIGHT )
    endless_tutorial.anchorY = 0
    endless_tutorial.x , endless_tutorial.y = _SCREEN.CENTER.X * 3.7 ,_SCREEN.CENTER.Y * -3.22
    endless_tutorial.rotation = -8

    --survival模式
    survival_spring = display.newImageRect( btnGroup, "images/survival_spring.png" , 320*WIDTH , 320*HEIGHT)
    survival_spring.x , survival_spring.y = _SCREEN.CENTER.X * 3.3 ,_SCREEN.CENTER.Y * -2.6

    --survival模式教學木箱
    survival_tutorial = display.newImage( btnGroup, "images/survival_tutorial.png" )
    survival_tutorial.x , survival_tutorial.y = _SCREEN.CENTER.X * 3.75 ,_SCREEN.CENTER.Y * -2.15

    survival_shadow = display.newImage( btnGroup, "images/survival_shadow.png" )
    survival_shadow.x , survival_shadow.y = _SCREEN.CENTER.X * 3.3 ,_SCREEN.CENTER.Y * -2.1

    logo = display.newImage( "images/logo.png")
    logo.x , logo.y = _SCREEN.CENTER.X , _SCREEN.CENTER.Y*1.4
    logo.alpha = 0
    transition.to( logo , {time = 1500 , alpha = 1 ,onComplete = function ( )
        timer.performWithDelay( 1000, function (  )
            transition.to( logo , {time = 1000 , alpha = 0})
        end )
    end} )
    --延時一段時間後進入開場畫面
    startOpening = timer.performWithDelay( 3000 , function (  )
        --將畫面帶入選單
        transition.to( openGroup , {time = 5000 , y = _SCREEN.H * 2 ,transition = easing.inCubic } )
        transition.to( houseGroup , {time = 5000 , y = _SCREEN.H * 2 ,transition = easing.inCubic } )
        transition.to( btnGroup , {time = 5000 , y = _SCREEN.H * 2 ,transition = easing.inCubic} )
        --上方LOGO持續移動
        transition.to( logoGroup, {time = 5000 , y =  _SCREEN.CENTER.Y * -2.8 ,onComplete = function (  )
            transition.to( logoGroup, {time = 5000 , y = _SCREEN.CENTER.Y * -2.88 , transition = easing.continuousLoop
            , iterations =  -1 } )
            transition.to (straps , {time = 2000 , rotation = 5 ,transition = easing.continuousLoop
            , iterations =  -1 })
        end} )
        
        --移動背景的雲
        transition.to( cloudGroup1, {time = 10000 , x = _SCREEN.CENTER.X *-4.2 , onComplete = function ( )
            cloudGroup1.x = _SCREEN.CENTER.X * 6
        end, iterations = -1} )
        transition.to( cloudGroup2, {time = 30000 , x = _SCREEN.CENTER.X *-6 , onComplete = function ( )
            cloudGroup2.x = _SCREEN.CENTER.X * 12
        end, iterations = -1} )
        --可點選按鈕產生動作
        timer.performWithDelay( 3000 , function (  )
            transition.to( play, {time = 300 , rotation = 10 , transition = easing.continuousLoop} )
            transition.to( endless, {time = 200 , rotation = 2 , transition = easing.outBack , onComplete = function ( )
            transition.to( endless, {time = 200 , rotation = -2 ,transition = easing.outBack } )
            transition.to( survival_tutorial, {time = 400 , rotation = 20 ,transition = easing.continuousLoop} )
            transition.to( packageGroup, {time = 400 , x = 5 , y = 5 ,transition = easing.continuousLoop} )
        end} )
        end , -1 )
        transition.to( survival_spring , {time = 3000 , y = survival_spring.y + 50 , transition = easing.continuousLoop , iterations = -1 } )
        transition.to( survival_shadow , {time = 3000 , xScale = 1.4 , yScale = 1.4 , transition = easing.continuousLoop , iterations = -1 } )
        transition.to(endless_tutorial , {time = 2000 , rotation = 8 ,transition = easing.continuousLoop , iterations = -1})
    end )     

    lineData = {
                { xForce = 4 , yForce = -20 , x =  package_back.x+10 , y = package_back.y+11 } ,
                { xForce = -3 , yForce = -25 , x =  package_back.x+12 , y = package_back.y+12 } ,
                { xForce = 1 , yForce = -18 , x =  package_back.x+11 , y = package_back.y+13 } ,
                { xForce = -3 , yForce = -20 , x =  package_back.x+9 , y = package_back.y+14 } ,
                { xForce = 3 , yForce = -23 , x =  package_back.x-10 , y = package_back.y+9 } ,
                { xForce = -3 , yForce = -24 , x =  package_back.x-11 , y = package_back.y-10 } ,
                { xForce = 5 , yForce = -30 , x =  package_back.x+13 , y = package_back.y-11 } ,
                { xForce = -5 , yForce = -16 , x =  package_back.x-9 , y = package_back.y-12 } ,
                { xForce = 4 , yForce = -20 , x =  package_back.x-10 , y = package_back.y-13 } ,
            }

      --將各個按鈕加入偵聽
    play:addEventListener( "tap", function (  )
        transition.to( houseGroup, {time = 100 , x = _SCREEN.CENTER.X * -1.5 } )
        transition.to( logoGroup, {time = 100 , x = _SCREEN.CENTER.X * -1.9 } )
        transition.to( btnGroup, {time = 100 , x = _SCREEN.CENTER.X * -2 } )
        audio.play( playSound )
    end )

    packageGroup:addEventListener( "tap", boxListener )      

    rock:addEventListener( "tap", function ( )
        audio.play( rockSound )
        transition.to( houseGroup, {time = 100 , x = _SCREEN.CENTER.X * 1.5 } )
        transition.to( btnGroup, {time = 100 , x = _SCREEN.CENTER.X * 1.2  } )
        transition.to( logoGroup, {time = 100 , x = _SCREEN.CENTER.X * 1.9 } )
        rock.isVisible = false
        rock_back.isVisible = true
        timer.performWithDelay( 300, function (  )
            houseDora:removeSelf( )
            addHouseDora()
        end )   
    end )

    back:addEventListener( "tap", function (  )
        audio.play( backSound )
        transition.to( houseGroup, {time = 100 , x = 0  } )
        transition.to( btnGroup, {time = 100 , x = 0 } )
        transition.to( logoGroup, {time = 100 , x = 0  } )
        
    end )

    rock_back:addEventListener( "tap", function (  )
        audio.play( rockSound )
        transition.to( houseGroup, {time = 100 , x = 0 } )
        transition.to( btnGroup, {time = 100 , x = 0  } )
        transition.to( logoGroup, {time = 100 , x = 0 } )
        rock.isVisible = true
        rock_back.isVisible = false
    end )

    book_light:addEventListener( "tap", function (  )
        audio.play( bookSound )
         composer.gotoScene( "book_light" )
    end )

    endless:addEventListener( "tap", function ( )
        audio.play( endlessSound )
         composer.gotoScene( "endless" )
    end )

    endless_tutorial:addEventListener( "tap", function (  )
        audio.play( endless_tutorialSound )
         composer.gotoScene( "endless_tutorial" )
    end )

    survival_spring:addEventListener( "tap", function (  )
        audio.play( survivalSound )
        local options = 
        {  
            isModal = true,
            effect = "fade",
            time = 400,
            }
        composer.showOverlay( "rank" , options )
         -- composer.gotoScene( "survival_spring" )
    end )

    survival_tutorial:addEventListener( "tap", function (  )
        audio.play( survival_tutorialSound )
        composer.gotoScene( "survival_tutorial" )
    end )

    Runtime:addEventListener( "tap", function ( e )
        local emitter = particle.newEmitter("particle_texture.json")
        emitter.x , emitter.y = e.x , e.y
    end )
end

--隨機產生樹屋上mandora
addHouseDora = function (  )
    i = math.random( 1,#houseData )
    houseDora = display.newImageRect( houseGroup, houseData[i].path, houseData[i].width, houseData[i].height )
    houseDora.x , houseDora.y = _SCREEN.CENTER.X*1.65, _SCREEN.CENTER.Y*-2.9
end

--畫面推上螢幕後執行函式
audioPlay = function (  )
    --撥放音樂
    audio.play( title_bgm , {channel = 1 , loops = -1 } )
    audio.resume( 1 )
end

--畫面即將離開螢幕執行函式
audioStop = function ( )
    audio.pause( 1 )
    audio.rewind( 1 )
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

boxListener = function (  )
    transition.to( package_front , {time = 300 , xScale = 0.9 , yScale =0.9 , transition = easing.continuousLoop} )
    transition.to( package_back , {time = 300 , xScale = 0.9 , yScale =0.9 , transition = easing.continuousLoop} )
    i = math.random( #boxData )
    j = math.random( #lineData)
    audio.play( boxData[i].sound )
    boxTable = {}
    boxTable[i] = display.newImageRect( backPackageGroup , boxData[i].path , 200 , 200 )
    boxTable[i].x , boxTable[i].y = _SCREEN.CENTER.X*0.8 , _SCREEN.CENTER.Y*-2.6
    physics.addBody(  boxTable[i] ,"dynamics" )
    boxTable[i].isSensor = true
    boxTable[i]:applyLinearImpulse( lineData[j].xForce , lineData[j].yForce , lineData[j].x , lineData[j].y )
    packageGroup:removeEventListener( "tap", boxListener )
    timer.performWithDelay( 300 , function ( )
       packageGroup:addEventListener( "tap", boxListener )
    end  )
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
        audioPlay()
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
        audioStop()
    elseif ( "did" == phase ) then
        print('scene:hide did')
        --畫面已經移開螢幕時，要執行的程式碼
        composer.recycleOnSceneChange = false
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