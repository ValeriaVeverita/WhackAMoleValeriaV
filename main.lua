-- Title: WhackAMole
-- Name: Valeria V
-- Course: ICS2O
-- This program displays an object on the screen for an amount of time and ten disappears
--if the user click the object, the score increases by 1

--Hiding Status Bar
display.setStatusBar(display.HiddenStatusBar)

local automatic

--Create the background
local bck = display.setDefault("background", 247/255, 202/255, 201/255)

--Creating the ice-cream
local iceCream = display.newImage("Images/icecream.png", 0, 0)

  --Setting Position
   iceCream.x = display.contentCenterX
   iceCream.y = display.contentCenterY

   --Setting Visibility
   iceCream.isVisible = false

   --set the scale
   iceCream:scale(0.5, 0.5)

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
local iceWhacked = 0

--Score text
local score = display.newText( "Score:"..cupcakeWhacked, 0, 0, "Georgia", 50)
score.isVisible = false

   --Text Possition
   score.x = display.contentWidth/2
   score.y = 40

   --Changing Color of Score
   score:setFillColor( 1, 0, 0)

--create text pannel
local pannel = display.newRect(500, 380, 600, 700)
pannel.isVisible = true
pannel.strokeWidth = 5
pannel:setFillColor(255/255, 160/255, 122/255)
pannel:setStrokeColor(205, 92, 92)

--create the text
local info = display.newText("GameRules", 495, 220, native.systemFontBold, 70)
info.isVisible = true

--create text
local info2 = display.newText("Press cupcakes in order\nto score points.\nTry to avoid ice-cream\nor you will lose one point", 500, 400, "Georgia", 40)
info2.isVisible = true

--create an object
local cupcake2 = display.newImageRect("Images/cupcake.png", 300, 300)
cupcake2.isVisible = true
cupcake2.x = 800
cupcake2.y = 600

--create an object
local ice2 = display.newImageRect("Images/icecream.png", 300, 400)
ice2.isVisible = true
ice2.x = 250
ice2.y = 120
ice2.rotation = 40

--create the sounds
local cupcakeSound = audio.loadStream("Sounds/correct.mp3")
local cupcakeChannel

local icecreamSound = audio.loadStream("Sounds/drop.mp3")
local icecreamChannel

---------------------------------------------------------------------------------------------
--FUNCTIONS
---------------------------------------------------------------------------------------------------

--This function makes the cupcake appear in a random (x, y) position
function PopCake()
  automatic = math.random(1, 2)
  if (automatic == 1 ) then
	  --choosing random possition
	  cupcake.x = math.random( 0, display.contentWidth)
	  cupcake.y = math.random( 0, display.contentHeight)

	  --Make the cupcake visible
    cupcake.isVisible = true

    --after 500 miliseconds, call the Hide function
    timer.performWithDelay( 700, Hide)
 
 elseif (automatic == 2 ) then
  --choosing random possition
  iceCream.x = math.random( 0, display.contentWidth)
  iceCream.y = math.random( 0, display.contentHeight)

  --Make the cupcake visible
    iceCream.isVisible = true

    --after 500 miliseconds, call the Hide function
    timer.performWithDelay( 700, Hide)
  end
end

--This function calls the PopDelay
function PopDelayCake( )
	timer.performWithDelay( 500, PopCake)
end

--This function makes the cupcake invisible
function Hide( )

	--Changing Visibility
	cupcake.isVisible = false
  iceCream.isVisible = false

	--Staring the cycle over and over again
	PopDelayCake()
end

--This function starts the game
function GameStart()
	PopDelayCake()
  ice2.isVisible = false
  cupcake2.isVisible = false
  pannel.isVisible = false
  info2.isVisible = false
  info.isVisible = false
  score.isVisible = true
end
--This function increments the score
function Whacked( event )

	--If touch phase just started
	if (event.phase == "began") then
		cupcakeWhacked = cupcakeWhacked + 1
    print("cupcakeWhacked"..cupcakeWhacked)

    score.text = "Score:" .. cupcakeWhacked
    cupcakeChannel = audio.play(cupcakeSound)

	end
end

function Whacked2( event )

  --If touch phase just started
  if (event.phase == "began") then
    cupcakeWhacked = cupcakeWhacked - 1
    print("cupcakeWhacked"..cupcakeWhacked)
    score.text = "Score:" .. cupcakeWhacked
    icecreamChannel = audio.play(icecreamSound)

    if (cupcakeWhacked < 0 )then
      score.text = "Score:0"
      cupcakeWhacked = 0 
    end
  end
end

--Event listener
cupcake:addEventListener( "touch", Whacked)
iceCream:addEventListener("touch", Whacked2)


timer.performWithDelay(3000, GameStart)