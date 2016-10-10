local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )
local myApp = require( "myapp" )
local widgetExtras = require("widget-extras")

local function handleLeftButton( event )
    print("handling left button")

    if ( "ended" == event.phase ) then
        print( "Button was pressed and released" )
        composer.gotoScene("osa-panel")
        return true
    end
    
end
function scene:create( event )
  local sceneGroup = self.view
  local background = display.newRect(0,0,display.contentWidth, display.contentHeight)

    background:setFillColor( 0.95, 0.95, 0.95 )
    background.x = display.contentWidth / 2
    background.y = display.contentHeight / 2

    local leftButton = {
     width = 50,
     height = 50,
     defaultFile = "images/menu.png",
     overFile = "images/back.png",
     onEvent = handleLeftButton
  }

  local rightButton = {
     onEvent = handleRightButton,
     label = "Add",
     labelColor = { default =  {1, 1, 1}, over = { 0.5, 0.5, 0.5} },
     font = "HelveticaNeue-Light",
     isBackButton = false
  }

  local navBar = widget.newNavigationBar({
     title = "OSA NEWS",
     background = "images/bg.png",
     titleColor = {1, 1, 1},
     font = "Helvetica",
     leftButton = leftButton,
     includeStatusBar = true
  })
     print("yes")


    sceneGroup:insert(background)
    sceneGroup:insert( navBar )


end

scene:addEventListener( "create" )

return scene

