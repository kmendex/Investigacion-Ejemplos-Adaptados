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
      -> left click: generate new particle
	  -> click + draw: generate new particles
	  
 Reference
	https://www.openprocessing.org/sketch/492096
 Author:                                                                                                 
	https://www.openprocessing.org/user/56835
]]


local mass = {}
local positionX = {}
local positionY = {}
local velocityX = {}
local velocityY = {}

-- /////////////////////////////////////////////////////////////////////////////////////////////////////

function setup()
	size(400, 400)
	noStroke()
	frameRate(30)
	fill(64, 255, 255, 192)
end

-- /////////////////////////////////////////////////////////////////////////////////////////////////////

function draw()
	background(32)
	
	for particleA = 1, #mass do
		local accelerationX,accelerationY = 0,0
		
		for particleB = 1,#mass do
			if (particleA ~= particleB) then
				local distanceX = positionX[particleB] - positionX[particleA]
				local distanceY = positionY[particleB] - positionY[particleA]

				local distance = math.sqrt(distanceX * distanceX + distanceY * distanceY)
				if (distance < 1) then distance = 1 end

				local force = (distance - 320) * mass[particleB] / distance
				accelerationX = accelerationX + force * distanceX
				accelerationY = accelerationY + force * distanceY
			end
		end
		
		velocityX[particleA] = velocityX[particleA] * 0.99 + accelerationX * mass[particleA]
		velocityY[particleA] = velocityY[particleA] * 0.99 + accelerationY * mass[particleA]
	end
	
	for particle = 1, #mass do
		positionX[particle] = positionX[particle]+velocityX[particle]
		positionY[particle] = positionY[particle]+velocityY[particle]
		
		ellipse(positionX[particle], positionY[particle], mass[particle] * 1000, mass[particle] * 1000)
	end
end

-- /////////////////////////////////////////////////////////////////////////////////////////////////////

function addNewParticle(x,y)
	table.insert(mass,math.random()*0.03)
	table.insert(positionX,x)
	table.insert(positionY,y)
	table.insert(velocityX,0)
	table.insert(velocityY,0)
end

-- /////////////////////////////////////////////////////////////////////////////////////////////////////

function mouseClicked(x,y)	
	addNewParticle(x,y)
end

function mouseDragged(x,y)
	addNewParticle(x,y)
end

function mouseMoved(x,y)
end