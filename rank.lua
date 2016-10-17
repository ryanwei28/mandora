-----------------------------------------------------------------------------------------
--
-- rank.lua
-- 排名
--
-----------------------------------------------------------------------------------------

--=======================================================================================
--引入各種函式庫
--=======================================================================================
local scene = composer.newScene( )
--=======================================================================================
--宣告各種變數
--=======================================================================================
local backgroud
local okBtn
local title
local rankData = {
   {path = "images/rank/01.png"} , 
   {path = "images/rank/02.png"} , 
   {path = "images/rank/03.png"} , 
   {path = "images/rank/04.png"} , 
   {path = "images/rank/05.png"} , 
   {path = "images/rank/06.png"} , 
   {path = "images/rank/07.png"} , 
   {path = "images/rank/08.png"} , 
   {path = "images/rank/09.png"} , 
   {path = "images/rank/10.png"} , 
}
--=======================================================================================
--宣告各種函數函數
--=======================================================================================
local init
local onRowRender
local onRowTouch
local handleBtn
--=======================================================================================
--定義各種函式
--=======================================================================================
init = function ( _parent )
  backgroud = display.newImageRect( _parent , "images/rank/bg.png", _SCREEN.W * 0.8 , _SCREEN.H*0.8 )
  backgroud.x , backgroud.y = _SCREEN.CENTER.X , _SCREEN.CENTER.Y

  title = display.newImageRect( _parent, "images/rank/title.png", _SCREEN.W*0.7, _SCREEN.H*0.07 )
  title.x , title.y = _SCREEN.CENTER.X , _SCREEN.CENTER.Y*0.3

  okBtn = widget.newButton( 
         { width = 200 ,
            height = 80 ,
            defaultFile = "images/rank/ok.png" ,
            overFile = "images/rank/ok_down.png" ,
            onRelease = handleBtn , 

         } )
  okBtn.x , okBtn.y = _SCREEN.CENTER.X*0.8 , _SCREEN.H*0.83

  tableView = widget.newTableView( 
        { x = _SCREEN.CENTER.X ,
         y = _SCREEN.CENTER.Y , 
         width = _SCREEN.W*0.8, 
         height = _SCREEN.H*0.55 , 
         isBouncedEnabled = true , 
         hideBackground = true , 
         onRowRender = onRowRender , 
         onRowTouch = onRowTouch ,   
      })   

   for i = 1 , 10 do
      local rowHeight = 100
      local rowColor = { default = {0,0,0,0}}
      tableView:insertRow( {
        rowHeight = rowHeight , 
        rowColor = rowColor , 

      } )
   end
   _parent:insert( tableView )
   _parent:insert(okBtn)
end

handleBtn = function (  )
   composer.hideOverlay()
end

onRowRender = function ( e , scene)
   row = e.row
   rankImg = display.newImageRect( row , rankData[row.index].path, _SCREEN.W*0.8 , 100*HEIGHT )
   rankImg.x , rankImg.y = _SCREEN.CENTER.X-50 , 50
end

onRowTouch = function (  )
    
end
--=======================================================================================
--Composer
--=======================================================================================

--畫面沒到螢幕上時，先呼叫scene:create
--任務:負責UI畫面繪製
function scene:create(event)
   print('scene1:create')
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
      print('scene1:show will')
      --畫面即將要推上螢幕時要執行的程式碼寫在這邊
   elseif ( "did" == phase ) then
      print('scene1:show did')
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
      print('scene1:hide will')
      --畫面即將移開螢幕時，要執行的程式碼
      --這邊需要停止音樂，釋放音樂記憶體，有timer的計時器也可以在此停止
   elseif ( "did" == phase ) then
      print('scene1:hide did')
      --畫面已經移開螢幕時，要執行的程式碼
      -- composer.recycleOnSceneChange = true
   end
end

--下一個場景畫面推上螢幕後
--任務:摧毀場景
function scene:destroy( event )
   print('scene1:destroy')
   if ("will" == event.phase) then
      --這邊寫下畫面要被消滅前要執行的程式碼


   end
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene