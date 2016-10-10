local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )
local widgetExtras = require("widget-extras")




function scene:create( event )
    local sceneGroup = self.view
    local sceneGroup = self.view
    local background = display.newRect(0,0,display.contentWidth, display.contentHeight)

    background:setFillColor( 0.95, 0.95, 0.95 )
    background.x = display.contentWidth / 2
    background.y = display.contentHeight / 2

    local navBar = widget.newNavigationBar({
       title = "MY PROFILE",
       background = "images/bg.png",
       titleColor = {1, 1, 1},
       font = "Helvetica",
       leftButton = leftButton,
       includeStatusBar = true,
       print("navbar")
    })  
    local timelineButton = widget.newButton{
      left = 20,
      top = 8,
      width = 100,
      height = 35,
      label = "timeline",
      fontSize = 15,
        labelColor = { default = { 1.0, 1.0, 1.0, 1.0 }, },
      defaultFile = "images/timelineButton1.png",
      overFile = "images/timelineButton2.png",
      onEvent = handleButtonEvent
  }
  local myOrgsButton = widget.newButton{
      left = 20,
      top = 8,
      width = 100,
      height = 35,
      label = "my orgs",
      fontSize = 15,
      labelColor = { default = { 1.0, 1.0, 1.0, 1.0 }, },
      defaultFile = "images/timelineButton1.png",
      overFile = "images/timelineButton2.png",
      onEvent = handleButtonEvent
  }
  
   
    timelineButton.x = 100
    timelineButton.y = 100
    myOrgsButton.x = 200
    myOrgsButton.y = 100
    sceneGroup:insert(background)
    sceneGroup:insert( navBar )
    sceneGroup:insert( timelineButton )
    sceneGroup:insert( myOrgsButton )
    

end

scene:addEventListener( "create" )

return scene