local composer = require( "composer" )
local scene = composer.newScene()
local json = require "json"
local widget = require( "widget" )
local data
local feedback
local usernameLabel
local usernameField
local passwordLabel
local passwordField
local loginButton
local validCredentials = false

local function networkListener( event )

    if ( event.isError ) then
        print( "Network error: ", event.response )
    else
        data = json.decode(event.response)

        while validCredentials == false do
	        for key in pairs(data) do
	        	if data[key].up_mail == usernameField.text and data[key].pass == passwordField.text then
					validCredentials = true
					break
				end	 
	    	end
	    	break
    	end
	end
	
	if validCredentials == true then
		composer.gotoScene( "home", { isModal=true, time=250, effect="fade" } )
	else
		--print("Invalid Credentials")
		feedback = display.newText("Invalid Credentials", display.contentCenterX - 80, display.contentCenterY - 20, native.systemFont)
		feedback:setFillColor(0,0,0)
		feedback.anchorX = 0
	end

end

local function submitForm( event )
	network.request( "http://192.168.1.7:3000/", "GET", networkListener)
end

local function fieldHandler( textField )
	return function( event )
		if ( "began" == event.phase ) then
			-- This is the "keyboard has appeared" event
			-- In some cases you may want to adjust the interface when the keyboard appears.
			event.target.text = ''
		elseif ( "ended" == event.phase ) then
			-- This event is called when the user stops editing a field: for example, when they touch a different field
			
		elseif ( "editing" == event.phase ) then
			display.remove(feedback)
		elseif ( "submitted" == event.phase ) then
			-- This event occurs when the user presses the "return" key (if available) on the onscreen keyboard
			print( textField().text )
			
			-- Hide keyboard
			native.setKeyboardFocus( nil )
		end
	end
end

function scene:create( event )
	local sceneGroup = self.view

	-- Maroon Background
	local background = display.newImage("images/bg.png")
	background.x = display.contentCenterX
	background.y = display.contentCenterY
	sceneGroup:insert(background)

	-- Username Label
	usernameLabel = display.newText("UP Mail:", display.contentCenterX - 80, display.contentCenterY - 150, native.systemFont)
	usernameLabel:setFillColor(1,1,1)
	sceneGroup:insert(usernameLabel)
	usernameLabel.anchorX = 0

	-- Password Label
	passwordLabel = display.newText("Password:", display.contentCenterX - 80, display.contentCenterY - 80, native.systemFont)
	passwordLabel:setFillColor(1,1,1)
	sceneGroup:insert(passwordLabel)
	passwordLabel.anchorX = 0

	-- Display text for invalid credentials
	feedback = display.newText(" ", display.contentCenterX - 80, display.contentCenterY - 20, native.systemFont)
	feedback:setFillColor(0,0,0)
	sceneGroup:insert(feedback)
	feedback.anchorX = 0

end

function scene:show( event )
	local sceneGroup = self.view

	if event.phase == "did" then

		local fieldWidth = display.contentWidth - 150
		if fieldWidth > 250 then
			fieldWidth = 250
		end

		-- Username Field
		usernameField = native.newTextField( display.contentCenterX - 80 , display.contentCenterY - 120, fieldWidth, 30 )
		usernameField:addEventListener( "userInput", fieldHandler( function() return usernameField end ) ) 
		sceneGroup:insert(usernameField)
		usernameField.anchorX = 0
		usernameField.placeholder = "Enter your UP Mail"

		-- Password Field
		passwordField = native.newTextField( display.contentCenterX - 80 , passwordLabel.y + 30, fieldWidth, 30 )
		passwordField:addEventListener( "userInput", fieldHandler( function() return passwordField end ) ) 
		passwordField.isSecure = true
		sceneGroup:insert(passwordField)
		passwordField.anchorX = 0
		passwordField.placeholder = "Enter you password"

		-- Login Button
		loginButton = widget.newButton({
	        width = 160,
	        height = 40,
	        label = "Submit",
	        labelColor = { 
	            default = { 1,1,1 }, 
	            over = { 0,0,0 } 
	        },
	        labelYOffset = -4, 
	        font = native.systemFont,
	        fontSize = 18,
	        emboss = false,
		    onRelease = submitForm
	    })
	    loginButton.x = display.contentCenterX
	    loginButton.y = usernameField.y + 150
	    sceneGroup:insert(loginButton)
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	--
	-- Clean up native objects
	--
	if event.phase == "will" then
		usernameField:removeSelf()
		usernamedField = nil
		passwordField:removeSelf()
		passwordField = nil
	end
end

function scene:destroy( event )
	local sceneGroup = self.view

end


scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
return scene

