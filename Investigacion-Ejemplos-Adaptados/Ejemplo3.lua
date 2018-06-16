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
	  -> wheel up: zoom
	  -> wheel down: zoom out
      -> left click: restore size
	  
 Reference
	https://www.openprocessing.org/sketch/502415
 Author:                                                                                                 
	https://www.openprocessing.org/user/91723
]]


-- You can change with these values:
local sides = 4
local delay = 40
local bg = 230
local fg = 0
local targetFps = 30
--


local primes = {2, 3, 5, 7, 11, 13}
local nowSide = 0
local remain = 0
local xs, ys = {}, {}
local x, y = 0, 0
local ptx, pty, tx, ty = x, y, x, y
local number = 0
local rot = 0
local zoom = 1.0


function setup()  
  size(600, 600)
  strokeWeight(4)
  frameRate(targetFps)
  for i = 1, 200 do
	xs[i]=0
	ys[i]=0 
  end  
end

function draw()  
  ptx=ptx+(x-ptx)/64
  pty=pty+(y-pty)/64
  tx=tx+(ptx-tx)/64
  ty=ty+(pty-ty)/64
  background(bg)
  rot=rot+0.0005

  translate(width()/2, height()/2)
  rotate(rot)
  scale(zoom)

  translate(-tx, -ty) 
  stroke(lerp(bg,fg,0.8))  
  for i = 1, #xs-2 do    	
    line(xs[i], ys[i], xs[i+1], ys[i+1])
  end

  stroke(fg)  
  local last = #xs-1
  if last>0 then
    local v =(math.cos(remain/delay*PI)+1)/2 -- smooth motion
    line(xs[last], ys[last], 
      lerp(xs[last], x, v), 
      lerp(ys[last], y, v))
  end
  
  remain = remain -1
  if (remain<0) then
    delay = delay + (5-delay)/32 -- faster every time
    
    for i = 1, #xs-1 do
      xs[i] = xs[i+1]
      ys[i] = ys[i+1]
    end
	
    xs[#xs-1] = x
    ys[#ys-1] = y
    local magnitude = primes[math.random(#primes)] * 30
    nowSide = (nowSide+1)%sides
	if(nowSide<0.1)  then
		magnitude=magnitude+60
	end
    x=x+math.cos(TWO_PI*nowSide/sides)*magnitude
    y=y+math.sin(TWO_PI*nowSide/sides)*magnitude
    remain = delay
  end
end

function lerp(a,b,f)
	return a + f * (b - a)
end

function mousePressed()	
	zoom = 1.0
end

function mouseWheel(n)
	zoom =  zoom + n / 100
	if (zoom < 0.1) then zoom = 0.1 end
	if (zoom > 2.0) then zoom = 2.0 end
end