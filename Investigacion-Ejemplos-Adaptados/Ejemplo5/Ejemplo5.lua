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

 Reference
	https://www.openprocessing.org/sketch/443297
 Author:                                                                                                 
	https://www.openprocessing.org/user/95522
]]

require "FfObj"

local _imgSize = 400
local _img, _img2, _img3
local _ffCount = 90
local _ff = {}

function setup()
	size(800,600)    
    background(0)
    noStroke()
    imgSet()
    for i=1, _ffCount do
        if (i<_ffCount/3) then 
			_ff[i] = FfObj:new(3,-10000+math.random(-1.5, 1.5),10000+math.random(-1.5, 1.5))
        elseif ( i>=_ffCount/3 and i<_ffCount/3*2 ) then  
			_ff[i] = FfObj:new(2,5000+math.random(-1.5, 1.5),-5000+math.random(-1.5, 1.5))
        else 
			_ff[i] = FfObj:new(1,1000+math.random(-1.5, 1.5),-1000+math.random(-1.5, 1.5))
		end
    end
end

function draw()
    background(0)
	for i,element in pairs(_ff) do    
		local img = nil
		if element.id == 1 then img = _img
		elseif element.id == 2 then img = _img2
		else img = _img3 end
        element:drawImg(img,_imgSize)
		element:drawMe()
		element:updateMe()
    end    
end

function imgSet() 
    _img = createImage(_imgSize, _imgSize)
	local pixels = loadPixels(_img)
	for i=0,_imgSize-1 do		
		for j=0,_imgSize-1 do	
			local pixAlpha = 255/(dist(_imgSize/2, _imgSize/2, i, j)-1)*1.47
			if (pixAlpha < 1.89) then pixAlpha=0 end									
			pixels[i*_imgSize+j] = color(210, 210, 255, pixAlpha)
		end
	end	
	updatePixels(_img,pixels)
	
	_img2 = createImage(_imgSize, _imgSize)
	pixels = loadPixels(_img2)
	for i=0,_imgSize-1 do		
		for j=0,_imgSize-1 do	
			local pixAlpha = 255/(dist(_imgSize/2, _imgSize/2, i, j)-1)*1.47
			if (pixAlpha < 1.89) then pixAlpha=0 end									
			pixels[i*_imgSize+j] = color(255, 210, 210, pixAlpha)
		end
	end	
	updatePixels(_img2,pixels)	

	_img3 = createImage(_imgSize, _imgSize)
	pixels = loadPixels(_img3)
	for i=0,_imgSize-1 do		
		for j=0,_imgSize-1 do	
			local pixAlpha = 255/(dist(_imgSize/2, _imgSize/2, i, j)-1)*1.47
			if (pixAlpha < 1.89) then pixAlpha=0 end									
			pixels[i*_imgSize+j] = color(210, 255, 210, pixAlpha)
		end
	end	
	updatePixels(_img3,pixels)    
end

function dist(x,y,x1,y2)
	return math.sqrt((x1-x)^2+(y2-y)^2)
end