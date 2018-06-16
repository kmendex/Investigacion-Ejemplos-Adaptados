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
        'b': switch between b&w and color mode
        's': save image                         

 Reference
	https://www.openprocessing.org/sketch/516672
 Author:                                                                                                 
	https://www.openprocessing.org/user/23616
]]


local blockSize, circNum
local isColorMode = true
local bgClr = 250
local colors = {'#152A3B', '#158ca7', '#F5C03E', '#D63826', '#0F4155', '#7ec873', '#4B3331'}

function setup()
  size(500,500)  
  background(0)  
  strokeWeight(1.5)  
  stroke(0, 200) 
  noLoop()
end

function draw()
  genParcattern()
end

function genParcattern()
  circNum = math.random(4, 10)
  blockSize = math.random(30, 70)

  if (isColorMode) then bgClr = colors[#colors]  
  else bgClr = 250 end
  fill(bgClr) rect(0, 0, width(), height())

  for y = blockSize/2, height()+blockSize/2 , blockSize do
    for x = blockSize/2, width()+blockSize/2 ,  blockSize do
      pushMatrix()
      translate(x, y)	  
      rotate(HALF_PI * math.floor(0.5+math.random(4)))

      for i = circNum, 0, -1 do
        local diam = blockSize * 2 * i / (circNum + 1)
        if i < 2 or not(isColorMode) then fill(bgClr) 
		else fill(colors[separateIdx(i-1, circNum+1)+1]) end
        arc(-blockSize/2, -blockSize/2, diam, diam, 0, HALF_PI )
      end

      for i = circNum, 0, -1 do
        local diam = blockSize * 2 * i / (circNum + 1)
        if i < 2 or not(isColorMode) then fill(bgClr)
		else fill(colors[separateIdx(i-1, circNum + 1)+1]) end
        arc(-blockSize/2+blockSize, -blockSize/2+blockSize, diam, diam, PI, PI + HALF_PI)
      end
      popMatrix()
    end
  end  
  
  colors = shuffleArray(colors)  
end

function separateIdx(idx, length)
  return math.floor(math.abs(idx - (length-1) / 2 ))
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

function mousePressed() 
    genParcattern()
end

function keyPressed(key)
	if string.find(key,'s') then saveFrame("Frame-####.png")
	elseif string.find(key,'b') then isColorMode = not(isColorMode) end
end
