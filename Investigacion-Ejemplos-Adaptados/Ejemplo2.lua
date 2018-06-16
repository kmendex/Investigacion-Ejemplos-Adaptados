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
      -> click: generate new patchwork                             

    -> keyboard                                                          
       -> 's': save image 
       -> '1': modeFn - semiDual
       -> '2': modeFn - shark
       -> '3': modeFn - oneSemi
       -> '4': modeFn - mess
       -> '5': modeFn - rotateSemi
       -> '6': modeFn - pear
       -> '7': modeFn - chain
	   -> any: random modeFN

 Reference
	https://www.openprocessing.org/sketch/510598
 Author:                                                                                                 
	https://www.openprocessing.org/user/23616
]]

local blockSize = 50
local countBorder = 9
local wdt = blockSize * countBorder
local hgt = blockSize * countBorder
local modes = {"semiDual", "shark", "oneSemi", "mess", "rotateSemi", "pear", "chain"}
local currModeFn = "semiDual"
local colorSchemes = {
  { '#152A3B', '#158ca7', '#F5C03E', '#D63826', '#F5F5EB' },
  { '#0F4155', '#288791', '#7ec873', '#F04132', '#fcf068' },
  { '#E8614F', '#F3F2DB', '#79C3A7', '#668065', '#4B3331' }
}
local queueNum = {1, 2, 3, 4, 5}
local clrs = colorSchemes[1]

function setup()
  size(wdt, hgt)
  rectMode(CENTER)
  noStroke()
  noLoop()
end

function draw() 
  background(25)
  for y = blockSize / 2, height(), blockSize do
    for x = blockSize / 2, width(), blockSize do	
      queueNum = shuffleArray({ 1, 2, 3, 4, 5})	  
      fill(clrs[queueNum[1]])
      rect(x, y, blockSize, blockSize)

      pushMatrix()
      translate(x, y)	 
      currMode(currModeFn)
      popMatrix()
    end
  end
  paper()
end

function currMode(mode)
	if string.find(mode,"semiDual") then semiDual(0,0)
	elseif string.find(mode,"shark") then shark(0,0)
	elseif string.find(mode,"oneSemi") then oneSemi(0,0)
	elseif string.find(mode,"mess") then mess(0,0)
	elseif string.find(mode,"rotateSemi") then rotateSemi(0,0)
	elseif string.find(mode,"pear") then pear(0,0)
	elseif string.find(mode,"chain") then chain(0,0) end	
end

function chain(x, y) 
  rotate(radians(90 * math.floor(0.5+math.random(1, 5))))
  fill(clrs[queueNum[2]])
  arc(x - blockSize / 2, y, blockSize, blockSize, radians(270), radians(450))
  fill(clrs[queueNum[3]])
  arc(x + blockSize / 2, y, blockSize, blockSize, radians(90),  radians(270))

  rotate(radians(90 * math.floor(0.5+math.random(1, 5))))
  fill(clrs[queueNum[2]])
  arc(x, y + blockSize / 2, blockSize, blockSize, radians(180), radians(360))
  fill(clrs[queueNum[3]])
  arc(x, y - blockSize / 2, blockSize, blockSize, radians(0),   radians(180))
end

function pear(x, y)
  rotate(radians(90 * math.floor(math.random(1, 5))))

  fill(clrs[queueNum[2]])
  arc(x - blockSize / 2, y, blockSize, blockSize, radians(270), radians(450))
  fill(clrs[queueNum[3]])
  arc(x + blockSize / 2, y, blockSize, blockSize, radians(90),  radians(270))

  fill(clrs[queueNum[2]])
  arc(x, y + blockSize / 2, blockSize, blockSize, radians(180), radians(360))
  fill(clrs[queueNum[3]])
  arc(x, y - blockSize / 2, blockSize, blockSize, radians(0),   radians(180))
end

function rotateSemi(x, y)
  rotate(radians(90 * math.floor(0.5+math.random(1, 5))))
  fill(clrs[queueNum[2]])
  arc(-blockSize / 2, 0, blockSize, blockSize, radians(270), radians(450))
end

function mess(x, y)
  fill(clrs[queueNum[math.floor(math.random(1,#queueNum))]])
  arc(-blockSize / 2, 0, blockSize, blockSize, radians(270), radians(450))
  for i = 0,3 do
    fill(clrs[queueNum[math.floor(math.random(1,#queueNum))]])
    rotate(radians(90 * math.floor(0.5+math.random(1, 5))))
    arc(x, y + blockSize / 2, blockSize, blockSize, radians(270), radians(450))
  end
end

function oneSemi(x, y)
  if (math.random(1) > .2) then
    fill(clrs[queueNum[math.floor(math.random(1,#queueNum))]])
    arc(x - blockSize / 2, y, blockSize, blockSize, radians(270), radians(450))
  end
end

function shark(x, y)
  if (math.random(1) > .4) then
    fill(clrs[queueNum[math.floor(math.random(1,#queueNum))]])
    arc(x, y + blockSize / 2, blockSize, blockSize, radians(270), radians(450))
  end
end

function semiDual(x, y)
  rotate(radians(90 * math.floor(0.5+math.random(1, 5))))
  if (math.random() > .005) then
    fill(clrs[queueNum[2]])
    arc(x - blockSize / 2, y, blockSize, blockSize, radians(270), radians(450))
    fill(clrs[queueNum[3]])
    arc(x + blockSize / 2, y, blockSize, blockSize, radians(90),  radians(270))
  end
end

function shuffleArray(array)
  local j, temp
  for i = #array, 1, -1 do
    j = math.floor(math.random(1,#array))
    temp = array[i]
    array[i] = array[j]
    array[j] = temp
  end
  return array
end

function resetPatchwork(modeFn) 
  currModeFn = modeFn or modes[math.floor(math.random(1,#modes))]
    
  clrs = colorSchemes[math.floor(math.random(1,#colorSchemes))] 
  redraw()
end

function mousePressed()
  resetPatchwork()
end

function keyPressed(key)
	if string.find(key,'1') then resetPatchwork("semiDual")
	elseif string.find(key,'2') then resetPatchwork("shark")
	elseif string.find(key,'3') then resetPatchwork("oneSemi")
	elseif string.find(key,'4') then resetPatchwork("mess")
	elseif string.find(key,'5') then resetPatchwork("rotateSemi")
	elseif string.find(key,'6') then resetPatchwork("pear")
	elseif string.find(key,'7') then resetPatchwork("chain")
	elseif string.find(key,'s') then saveFrame("Frame-####.png")
	else resetPatchwork()
	end   
end

function paper()
  pushMatrix()
  strokeWeight(1)
  noStroke()
  for i = 0, width()-1, 2 do
    for j = 0, height()-1, 2 do
      fill(math.random(205-40, 205+30), 25)
      rect(i, j, 2, 2)
    end
  end

  for i = 0, 30 do
    fill(math.random(130, 215), math.random(100, 170))
    rect(math.random(0, width()-2), math.random(0, height()-2), 
		math.random(1, 3), math.random(1, 3))
  end

  popMatrix()
end