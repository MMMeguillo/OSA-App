local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )
local myApp = require( "myapp" )
local widgetExtras = require("widget-extras")


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
       onRelease = goBack
    }

    local rightButton = {
       onEvent = handleRightButton,
       label = "Add",
       labelColor = { default =  {1, 1, 1}, over = { 0.5, 0.5, 0.5} },
       font = "HelveticaNeue-Light",
       isBackButton = false
    }

    local navBar = widget.newNavigationBar({
       title = "ORGANIZATIONS",
       --backgroundColor = { 0.96, 0.62, 0.34 },
       background = "images/bg.png",
       titleColor = {1, 1, 1},
       font = "Helvetica",
       leftButton = leftButton,
       --rightButton = rightButton,
       includeStatusBar = true
    })
         
    sceneGroup:insert(background)
    sceneGroup:insert( navBar )
    
end


scene:addEventListener( "create" )

return scene
