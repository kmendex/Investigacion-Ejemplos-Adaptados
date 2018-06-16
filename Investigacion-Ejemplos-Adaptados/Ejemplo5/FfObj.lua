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
	https://www.openprocessing.org/sketch/443297
 Author:                                                                                                 
	https://www.openprocessing.org/user/95522
	
 Improved Noise reference implementation
 Reference
	https://mrl.nyu.edu/~perlin/noise/
 Author:                                                                                                 
	K. PERLIN (2002)
]]


FfObj={}
function FfObj:new(id,noiseX,noiseY)
	local s = {id=id,
		pX=width()/2 + math.random(-10, 10),
		pY=height()/2 + math.random(-10, 10),
		noiseScale=0.016,
		noiseX=noiseX,
		noiseY=noiseY}
   setmetatable(s,self)
   self.__index = self
   return s
end

function FfObj:updateMe()
	self.pX = self.pX+noise(self.noiseX)*6--.00008
    self.pY = self.pY+noise(self.noiseY)*6--.00008
    if (self.pX < 0) then self.pX = 0 end
    if (self.pX > width()) then self.pX = width() end
    if (self.pY < 0) then self.pY = 0 end
    if (self.pY > height()) then self.pY = height() end
    self.noiseX = self.noiseX+self.noiseScale
    self.noiseY = self.noiseY+self.noiseScale
end

function FfObj:drawImg(_img,_imgSize)
	image(_img, self.pX -_imgSize/2 , self.pY -_imgSize/2)
end

function FfObj:drawMe()
	if self.id == 1 then fill(220, 220, 235, 225)
	elseif self.id == 2 then fill(235, 220, 220, 225)
	else fill(220, 235, 220, 225) end
	ellipse(self.pX, self.pY, 6, 6)
end


function noise(x,y,z)
   local p = {}
   local permutation = {151,160,137,91,90,15,
   131,13,201,95,96,53,194,233,7,225,140,36,103,30,69,142,8,99,37,240,21,10,23,
   190, 6,148,247,120,234,75,0,26,197,62,94,252,219,203,117,35,11,32,57,177,33,
   88,237,149,56,87,174,20,125,136,171,168, 68,175,74,165,71,134,139,48,27,166,
   77,146,158,231,83,111,229,122,60,211,133,230,220,105,92,41,55,46,245,40,244,
   102,143,54, 65,25,63,161, 1,216,80,73,209,76,132,187,208, 89,18,169,200,196,
   135,130,116,188,159,86,164,100,109,198,173,186, 3,64,52,217,226,250,124,123,
   5,202,38,147,118,126,255,82,85,212,207,206,59,227,47,16,58,17,182,189,28,42,
   223,183,170,213,119,248,152, 2,44,154,163, 70,221,153,101,155,167, 43,172,9,
   129,22,39,253, 19,98,108,110,79,113,224,232,178,185, 112,104,218,246,97,228,
   251,34,242,193,238,210,144,12,191,179,162,241, 81,51,145,235,249,14,239,107,
   49,192,214, 31,181,199,106,157,184, 84,204,176,115,121,50,45,127, 4,150,254,
   138,236,205,93,222,114,67,29,24,72,243,141,128,195,78,66,215,61,156,180
   }
	for i=1, 256 do
		p[i] = permutation[i]
		p[256+i] = p[i]
	end
	
	z=z or 255
	y=y or 255
   local X = bit.band(math.floor(x),255)
   local Y = bit.band(math.floor(y),255)
   local Z = bit.band(math.floor(z),255)
   local x = x-math.floor(x)
   local y = y-math.floor(y)
   local z = z-math.floor(z)
   local u = fade(x)
   local v = fade(y)
   local w = fade(z)   
   local A = p[X ]+Y 
   local AA,AB = p[A]+Z, p[A+1]+Z
   local B = p[X+1]+Y
   local BA,BB = p[B]+Z,p[B+1]+Z
	
	return lerp(w, lerp(v, lerp(u, grad(p[AA  ], x  , y  , z   ),
                                     grad(p[BA  ], x-1, y  , z   )),
                             lerp(u, grad(p[AB  ], x  , y-1, z   ),
                                     grad(p[BB  ], x-1, y-1, z   ))),
                     lerp(v, lerp(u, grad(p[AA+1], x  , y  , z-1 ),
                                     grad(p[BA+1], x-1, y  , z-1 )),
                             lerp(u, grad(p[AB+1], x  , y-1, z-1 ),
									 grad(p[BB+1], x-1, y-1, z-1 ))))
end
   
function fade (t)
	return t * t * t * (t * (t * 6 - 15) + 10)
end      
function lerp(t, a, b)
	return a + t * (b - a)
end
function grad(hash, x, y, z)
    local h = bit.band(hash, 15) 
    local u,v
	if h<8 then u=x else u=y end
	if h<4 then v=y
	else 
		if h==12 or h==14 then v=x
		else v=z end
	end    
	local res
	if bit.band(h,1) == 0 then res=u
	else res=-u end
	if bit.band(h,2) == 0 then res=res+v
	else res=res+-v end
	return res    
end   