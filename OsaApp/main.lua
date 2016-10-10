-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local widget = require( "widget" )
local composer = require ("composer")
local myApp = require( "myapp" )

local widgetExtras = require("widget-extras")
local logo = display.newImageRect("images/uplogo.png", 320, 480)
logo.x = display.contentCenterX
logo.y = display.contentCenterY

--
-- now make the first tab active.align
--

local function closeSplash()
    
    display.remove(logo)
    logo = nil
    display.remove(background)
    background = nil
    composer.gotoScene("home")
end

timer.performWithDelay(2500, closeSplash)
