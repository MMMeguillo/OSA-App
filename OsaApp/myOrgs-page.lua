local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )
local myApp = require( "myapp" )
local widgetExtras = require("widget-extras")

--go to chair-create-announcement page
local function createButtonEvent( event )
    print("handling left button")

    if ( "ended" == event.phase ) then
        print( "Button was pressed and released" )
        composer.gotoScene("chair-create-announcement", {time=250, effect="crossFade", params = options})
        return true
    end
    
end

function scene:create( event )
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
        includeStatusBar = true
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
  local CreateAnnBtn = widget.newButton{
      left = 20,
      top = 8,
      width = 100,
      height = 35,
      label = "my orgs",
      fontSize = 15,
      labelColor = { default = { 1.0, 1.0, 1.0, 1.0 }, },
      defaultFile = "images/bg.png",
      overFile = "images/timelineButton2.png",
      onEvent = createButtonEvent
  }
  
    timelineButton.x = 100
    timelineButton.y = 100
    myOrgsButton.x = 200
    myOrgsButton.y = 100
    CreateAnnBtn.x = 100
    CreateAnnBtn.y = 300
    sceneGroup:insert(background)
    sceneGroup:insert( navBar )
    sceneGroup:insert( timelineButton )
    sceneGroup:insert( myOrgsButton )
    sceneGroup:insert( CreateAnnBtn )
    
    
end


scene:addEventListener( "create" )

return scene
