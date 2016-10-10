local widget = require ( "widget" )
local composer = require( "composer" )
local widgetExtras = require("widget-extras")

local scene = composer.newScene()
local navbar
local list
local width = display.actualContentWidth
print(display.screenOriginY)
function scene:create( event )

	local sceneGroup = self.view

	function widget.newPanel( options )
		local customOptions = options or {}
		local opt = {}
		opt.location = customOptions.location or "top"

		local default_width, default_height
		if(opt.location == "top" or opt.location == "bottom") then
			default_width = display.contentWidth
			default_height = display.contentHeight
			print("here")
		else
			default_width = display.contentWidth * 0.33
			default_height = display.contentHeight + display.screenOriginY
			print("me here")

		end

		opt.width = customOptions.width or default_width
		opt.height = customOptions.height or default_height

		opt.speed = customOptions.speed or 500
		opt.inEasing = customOptions.inEasing or easing.linear
		opt.inEasing = customOptions.inEasing or easing.linear

		if ( customOptions.onComplete and type(customOptions.onComplete) == "function" ) then
			opt.listener = customOptions.onComplete
		else 
			opt.listener = nil
		end

		local container = display.newContainer( opt.width, opt.height )


		if( opt.location == "left" ) then
			container.anchorX = 1.0
			container.x = display.screenOriginX
			container.anchorY = 0.5
			container.y = display.contentCenterY
		elseif ( opt.location == "right" ) then
			container.anchorX = 0.0
			container.x = display.actualContentWidth
			container.anchorY = 0.5
			container.y = display.contentCenterY
		elseif ( opt.location == "top" ) then
			container.anchorX = 0.5
			container.x = display.contentCenterX
			container.anchorY = 1.0
			container.y = display.screenOriginY
		else
			container.anchorX = 0.5
			container.x = display.contentCenterX
			container.anchorY = 0.0
			container.y = display.actualContentHeight
		end

		function container:show()
			local options = {
				time = opt.speed,
				transition = opt.inEasing
			}
			if ( opt.listener ) then
				options.onComplete = opt.listener
				self.completeState = "shown"
			end
			if ( opt.location == "top" ) then
				options.y = display.screenOriginY +opt.height
			elseif ( opt.location == "bottom" ) then
				options.y = display.actualContentHeight - opt.height
			elseif ( opt.location == "left" ) then
				options.x = display.screenOriginX +opt.width
			else
				options.x = display.actualContentWidth - opt.width
			end
			transition.to(self, options)
		end
		function container:hide()
			local options = { 
				time = opt.speed,
				transition = opt.outEasing
			}
			if ( opt.listener ) then
				options.onComplete = opt.listener
				self.completeState = "hidden"
			end

			
			if ( opt.location == "top" ) then
				options.y = display.screenOriginY
			elseif ( opt. location == "bottom" ) then
				options.y = display.actualContentHeight
			elseif ( pot.location == "left" ) then
				options.x = display.screenOriginX
			else
				options.x = display.actualContentWidth
			end
			transition.to( self, options)
		end
		return container
	end
	-- local function panelTransDone( target )
	-- 	native.showAlert( "Panel", "Complete", { "Okay"} )
	-- 	if ( target.completeState ) then
	-- 		print( " PANEL STATE IS: "..target.completeState )
	-- 	end
	-- end
	local panel = widget.newPanel{
	location = "left",
	onComplete = panelTransDone,
	width = display.contentWidth * 0.6,
	height = display.contentHeight * 0.7,
	speed = 800,
	inEasing = easing.outBack,
	outEasing = easing.outCubic
	}
	panel.background = display.newRect( 0, 0, panel.width, panel.height )
	panel.background:setFillColor( 0.8, 0.075, 0.075 )
	panel:insert( panel.background )

	panel.title = display.newText( "menu", 0, 0, native.systemFontBold, 18 )
	panel.title:setFillColor( 1, 1, 1 )
	panel:insert( panel.title )

---------------------------------------------------------------------------------
--inserting rows to the panel
	list = widget.newTableView{
	top = (display.actualContentHeight - (display.actualContentHeight/4)) + display.screenOriginY,
	left = display.screenOriginX,
	width = width-(width/4), 
	height = display.actualContentHeight - (display.actualContentHeight - (display.actualContentHeight/4)),
	onRowRender = onRowRender,
	onRowTouch = onRowTouch,
	}

	panel:insert( list )

	panel:show()
	-- panel:hide()

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

    navBar = widget.newNavigationBar({
       title = "OSA NEWS",
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

    sceneGroup:insert(panel)
end

scene:addEventListener( "create" )

return scene