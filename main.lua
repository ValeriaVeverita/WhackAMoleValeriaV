-- Title: WhackAMole
-- Name: Valeria V
-- Course: ICS2O
-- This program displays an object on the screen for an amount of time and ten disappears
--if the user click the object, the score increases by 1

--Hiding Status Bar
display.setStatusBar(display.HiddenStatusBar)

local automatic = math.random(1, 2)

--Create the background
local bck = display.setDefault("background", 247/255, 202/255, 201/255)

--Creating the ice-cream
local iceCream = display.newImage("Images/icecream.png", 0, 0)

  --Setting Position
   iceCream.x = display.contentCenterX
   iceCream.y = display.contentCenterY

   --Setting Visibility
   iceCream.isVisible = false

--Creating cupcake
local cupcake = display.newImage("Images/cupcake.png", 0, 0)
  
  --Setting the position
  cupcake.x = display.contentCenterX
  cupcake.y = display.contentCenterY

  --Setting Visibility
  cupcake.isVisible = false

  --set the scale
  cupcake:scale(0.1, 0.1)

--Score
local cupcakeWhacked = 0

--Score text
local score = display.newText( "Score:"..cupcakeWhacked, 0, 0, "Georgia", 50)

   --Text Possition
   score.x = display.contentWidth/2
   score.y = 40

   --Changing Color of Score
   score:setFillColor( 1, 0, 0)

---------------------------------------------------------------------------------------------
--FUNCTIONS
---------------------------------------------------------------------------------------------------

--This function makes the cupcake appear in a random (x, y) position
function PopCake()

	--choosing random possition
	cupcake.x = math.random( 0, display.contentWidth)
	cupcake.y = math.random( 0, display.contentHeight)

	--Make the cupcake visible
    cupcake.isVisible = true

    --after 500 miliseconds, call the Hide function
    timer.performWithDelay( 800, Hide)
end

--This function calls the PopDelay
function PopDelayCake( )
	timer.performWithDelay( 500, PopCake)
end

--This function makes the cupcake invisible
function Hide( )

	--Changing Visibility
	cupcake.isVisible = false

	--Staring the cycle over and over again
	PopDelay()
end

--This function starts the game
function GameStart()
	PopDelayCake()
end
--This function increments the score
function Whacked( event )

	--If touch phase just started
	if (event.phase == "began") then
		cupcakeWhacked = cupcakeWhacked + 1

		score.text = "Score:" .. cupcakeWhacked
	end
end


--Event listener
cupcake:addEventListener( 'touch', Whacked)

GameStart()