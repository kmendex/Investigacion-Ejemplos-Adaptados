--	Instituto Tecnológico de Costa Rica
-- 	Escuela de Ingeniería en Computación
--	Visualización de Información
--	Investigación: Ejemplos Adaptados
--	Kenneth Méndez Calderón, 201046796
--	I Semestre, 2018
--
-- Döiköl Data Visualization Library
-- Versión 0.1.7

--[[
 Controls:                                                            
    -> mouse                                                         
      -> left click: generate new pattern                                  

    -> keyboard                                                                  
        'c': switch circle mode
        's': switch square mode                         
		'p': switch abstract mode

 Reference
	https://www.openprocessing.org/sketch/102233
 Author:                                                                                                 
	https://www.openprocessing.org/user/28569
]]


local prgrm = false
local choice = 1
local red, green, blue, speed, alpha
local lineWidth=1.0
local mouseX,mouseY,pMouseX,pMouseY = 0,0,0,0


function setup()
  smooth()
  size(500,500)
  noStroke()
  background(200)
end

function draw()
	show()
end

function show()
  if prgrm then
	red = map(mouseX, 0, width(), 0, 255)
    blue = map(mouseY, 0, width(), 0, 255)	
	green = dist(mouseX,mouseY,width()/2,height()/2)

    speed = dist(pMouseX, pMouseY, mouseX, mouseY)
    alpha = map(speed, 0, 20, 0, 10)
    lineWidth = constrain(lineWidth, 0, 10)
      
    noStroke()
    fill(0,0,0, alpha)
    rect(0, 0, width(), height())
    
    stroke(red, green, blue, 255)
    strokeWeight(lineWidth)
    fill(red, green, blue, 255)
    if (choice==1) then Circles(mouseX, mouseY,speed, speed,lineWidth)
    elseif (choice==2) then Boxes(mouseX, mouseY,speed, speed,lineWidth)
    elseif (choice==3) then psychadelia(mouseX, mouseY,speed, speed,lineWidth) end 
  end
end

function dist(x,y,x1,y2)
	return math.sqrt((x1-x)^2+(y2-y)^2)
end

function Circles(x, y, px, py, lineWidth)
  strokeWeight(lineWidth)
  ellipse(x,y,px,py)
  return
end

function Boxes(x, y, px, py, lineWidth)
  strokeWeight(lineWidth)
  pushMatrix()
  translate(x,y)
  rotate(math.random(px))
  rect(0+math.random(50),0+math.random(50),10,10)
  popMatrix()
  return
end

function psychadelia(x, y, px, py, lineWidth)
  strokeWeight(lineWidth)
  px=px+math.random(50)
  py=py+math.random(50)
  ellipse(x,y,px,py)
  ellipse(width()/2+((width()/2)-x),y,px,py)
  ellipse(x,height()/2+((height()/2)-y),px,py)
  ellipse(width()/2+((width()/2)-x),height()/2+((height()/2)-y),px,py)
  ellipse(width()/2+((width()/2)-y),width()/2-((width()/2)-x),px,py)
  ellipse(height()/2-((height()/2)-y),width()/2-((width()/2)-x),px,py)
  ellipse(width()/2+((width()/2)-y),height()/2+((height()/2)-x),px,py)
  ellipse(width()/2-((width()/2)-y),height()/2+((height()/2)-x),px,py)
  return
end

function mouseDragged(x,y)
	pMouseX=mouseX
	mouseX=x
	pMouseY=mouseY
	mouseY=y	
	prgrm=true
end

function mouseReleased(x,y)
	mouseX=x
	mouseY=y
	prgrm=false
end

function mouseMoved(x,y)
	mouseX=x
	mouseY=y
end

function keyPressed(key)
	if string.find(key,'c') then choice=1
	elseif string.find(key,'s') then choice=2
	elseif string.find(key,'p') then choice=3 end
end