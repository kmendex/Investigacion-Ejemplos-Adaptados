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

 Reference
	https://www.openprocessing.org/sketch/510775
 Author:                                                                                                 
	https://www.openprocessing.org/user/11045
]]

Particle8={}
function Particle8:new(id,x,y,v,v_angle)
	local s = {id=id,
		x=x,y=y,
		vx=v*math.cos(v_angle),
		vy= v*math.sin(v_angle),
		rot_angle=math.random(-0.005, 0.005),
		step=math.random(80, 300)}
	setmetatable(s,self)
   self.__index = self
   return s
end

function Particle8:nextt()
	local pvx,pvy = self.vx,self.vy
	self.vx = pvx * math.cos(self.rot_angle) - pvy * math.sin(self.rot_angle)
    self.vy = pvx * math.sin(self.rot_angle) + pvy * math.cos(self.rot_angle)
	self.x = self.x + self.vx
	self.y = self.y + self.vy
	self.step = self.step -1	
	if (self.step <=0) then 
		self.rot_angle=math.random(-0.005, 0.005)
		self.step=math.random(80, 300)		
	end
end