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
    -> keyboard                                                                  
        'g': switch between gradient color mode & single colot mode
        't': toggle line conection/ circle conection
		'r': reset
		's': save frame

 Reference
	https://www.openprocessing.org/sketch/510775
 Author:                                                                                                 
	https://www.openprocessing.org/user/11045
]]

require "Particle8"

-- build config
local PARTICLE_NUM = 60
local MIN_DIST = 70
local MIN_SPEED = 0.25
local MAX_SPEED = 0.75
local RING_SIZE = 150
local line_connect = true

-- show config
local use_color_map = false
local use_color_gradient = true
local clr
local NOISE_SCALE = 0.02
local frame_cnt = 0
local clrmap

local ps

function setup()
  reset()
end

function reset()
  size( 600, 600)
  background(255)
  smooth()

  ps = {}
  -- init particles
  for  i = 1, PARTICLE_NUM do
    local v = math.random(MIN_SPEED, MAX_SPEED)
    local angle = math.random(0, 2*PI)
    local v_angle = math.random(0, 2*PI)

    ps[i] = Particle8:new(i,RING_SIZE * math.cos(angle), 
		RING_SIZE * math.sin(angle), v, v_angle)
  end
  clr = math.random(1,255)
end

function draw()
  if (use_color_gradient) then
    clr = clr+math.random(0.001)
    clr = clr % 1
  end
  generateGraph("rand")
end

function changeColorGradient()
  use_color_gradient = not(use_color_gradient)
end

function generateGraph(coloring_type)
  translate(width()/2, height()/2)
  for i = 1,PARTICLE_NUM do
    for j = i+1, PARTICLE_NUM do
      local dis = dist(ps[i].x, ps[i].y, ps[j].x, ps[j].y)
      if ( dis < MIN_DIST ) then
        if string.find(coloring_type,"rand") then
          local k = (0.5 + i/2.0) / PARTICLE_NUM
          fill(clr, clr*k^1, clr*(0.9 * math.sqrt(1-k)), 1 * (1  - dis / MIN_DIST))
          stroke(clr, k^1, 0.9 * math.sqrt(1-k), 1 * (1  - dis / MIN_DIST))
        elseif string.find(coloring_type,"colormap") then
          local c = set_color_by_map(ps[i])		  
          fill(bit.band(bit.lshift(c,16), 0xFF), bit.band(bit.rshift(c,8), 0xFF),bit.band(c, 0xFF), 32 * (1 - dis / MIN_DIST))
          stroke(bit.band(bit.lshift(c,16), 0xFF), bit.band(bit.rshift(c,8), 0xFF),bit.band(c, 0xFF), 32 * (1 - dis / MIN_DIST))
        end
        buildConnect(ps[i], ps[j], dis)
      end
    end
    ps[i]:nextt()
  end
end

function dist(x,y,x1,y2)
	return math.sqrt((x1-x)^2+(y2-y)^2)
end

function keyPressed(key)
	if string.find(key,'g') then changeColorGradient()
	elseif string.find(key,'t') then changeConnectionBuild()
	elseif string.find(key,'r') then reset()	
	elseif string.find(key,'s') then saveFrame("Frame-####.png")
	end   
end

function buildConnect(p1, p2, dis)  
  if (line_connect) then 
    line(math.abs(p1.x), math.abs(p1.y), math.abs(p2.x), math.abs(p2.y))
  else
    local cx = (math.abs(p1.x) + math.abs(p2.x))/2
    local cy = (math.abs(p1.y) + math.abs(p2.y))/2
    noFill()
    ellipse(cx, cy, dis/2, dis/2)
  end
end

function changeConnectionBuild() 
  line_connect = not(line_connect)
end