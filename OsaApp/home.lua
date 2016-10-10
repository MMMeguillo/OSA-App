local widget = require ( "widget" )
local composer = require ( "composer" )
local scene = composer.newScene()
local myApp = require( "myapp" )
local widgetExtras = require("widget-extras")

--create tab bar
myApp.tabBar = {}
function myApp.showScreen1()
    myApp.tabBar:setSelected(1)
    composer.removeHidden()
    composer.gotoScene("home", {time=250, effect="crossFade"})
    return true
end

function myApp.showScreen2(event)
    myApp.tabBar:setSelected(2)
    local options = {

        pageTitle = "OSA"
    }
    composer.removeHidden()
    composer.gotoScene("osa", {time=250, effect="crossFade", params = options})
    return true
end

function myApp.showScreen3()
    myApp.tabBar:setSelected(3)
    local options = {

        pageTitle = "ORGANIZATIONS"
    }
    composer.removeHidden()
    composer.gotoScene("orgs", {time=250, effect="crossFade"})
    return true
end

function myApp.showScreen4()
    myApp.tabBar:setSelected(4)
    local options = {

        pageTitle = "JOB HIRING"
    }
    composer.removeHidden()
    composer.gotoScene("job hiring", {time=250, effect="crossFade", params = options})
    return true
end

function myApp.showScreen5()
    myApp.tabBar:setSelected(5)
    local options = {

        pageTitle = "ALUMNI"
    }
    composer.removeHidden()
    composer.gotoScene("alumni", {time=250, effect="crossFade", params = options})
    return true
end

function myApp.showScreen6()
    myApp.tabBar:setSelected(6)
    local options = {

        pageTitle = "PROFILE"
    }
    composer.removeHidden()
    composer.gotoScene("profile", {time=250, effect="crossFade", params = options})
    return true
end

local tabButtons = {
    {
        label = "HOME",
        defaultFile = "images/home1.png",
        overFile = "images/home2.png",
        labelColor = { 
            default = { 0.5, 0.5, 0.5 }, 
            over = { 1, 0.1, 0 }
        },
        width = 32,
        height = 32,
        onPress = myApp.showScreen1,
        selected = true,
    },
     {
        label = "OSA",
        defaultFile = "images/osa1.png",
        overFile = "images/osa2.png",
        labelColor = { 
            default = { 0.5, 0.5, 0.5 }, 
            over = { 1, 0.1, 0 }
        },
        width = 32,
        height = 32,
        onPress = myApp.showScreen2,
    },
    {
        label = "ORGS",
        defaultFile = "images/orgs1.png",
        overFile = "images/orgs2.png",
        labelColor = { 
            default = { 0.5, 0.5, 0.5 }, 
            over = { 1, 0.1, 0 }
        },
        width = 32,
        height = 32,
        onPress = myApp.showScreen3,
    },
    {
        label = "JOB",
        defaultFile = "images/job1.png",
        overFile = "images/job2.png",
        labelColor = { 
            default = { 0.5, 0.5, 0.5 }, 
            over = { 1, 0.1, 0 }
        },
        width = 32,
        height = 32,
        onPress = myApp.showScreen4,
    },
    {
        label = "ALUMNI",
        defaultFile = "images/alumni1.png",
        overFile = "images/alumni2.png",
        labelColor = { 
            default = { 0.5, 0.5, 0.5 }, 
            over = { 1, 0.1, 0 }
        },
        width = 32,
        height = 32,
        onPress = myApp.showScreen5,
    },
    {
        label = "PROFILE",
        defaultFile = "images/profile1.png",
        overFile = "images/profile2.png",
        labelColor = { 
            default = { 0.5, 0.5, 0.5 }, 
            over = { 1, 0.1, 0 }
        },
        width = 32,
        height = 32,
        onPress = myApp.showScreen6,
    },
}

myApp.tabBar = widget.newTabBar{
    top =  display.contentHeight,
    left = 0,
    width = display.contentWidth,
    backgroundFile = tabBarBackgroundFile,
    tabSelectedLeftFile = tabBarLeft,      -- New
    tabSelectedRightFile = tabBarRight,    -- New
    tabSelectedMiddleFile = tabBarMiddle,      -- New
    tabSelectedFrameWidth = 20,                                         -- New
    tabSelectedFrameHeight = 50,                                        -- New    
    buttons = tabButtons,
    height = 45,
    --background="images/tabBarBg7.png"
}

-- local function handleLeftButton( event )
--     print("handling left button")

--     if ( "ended" == event.phase ) then
--         print( "Button was pressed and released" )
--         composer.gotoScene("panel")
--         return true
--     end
    
-- end
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
       title = "HOME",
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