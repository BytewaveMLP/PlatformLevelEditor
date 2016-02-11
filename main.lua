function love.load()
	Tiles = 'countryside.png'
	Tileset = love.graphics.newImage(Tiles)
	love.window.setMode( 800, 576)
	level = [[]]
	for j = 1, 36 do
		for i = 1, 50 do
			level = level .. " "
		end
		level = level .. "\n"
	end

	x=0
	y=0
	chCl = '[ F#><*-OX@]+'
	--' ' could be 0, 0
	mouseOptions = "#><*-OXF@"
	mouseIndex = 1
	QuadData={ {' ',0,0},{'#',16,0},{'*',16,32},{'>',48,16},{'<',48,0},{'-',32,16},{'@',0,32},{'O',0,16},{'X',16,16},{'F',32,0} }


	Quads = {}
	for i=1,#QuadData do 
		Quads[QuadData[i][1]] = love.graphics.newQuad(QuadData[i][2],QuadData[i][3],16,16,64,64)
	end
end
function save(fileName)
	local file = love.filesystem.newFile(filename)
	local file = file:open()
	file:write("[[\n")
end
function love.wheelmoved( dx, dy ) 
	if dy>0 then
		mouseIndex = mouseIndex + 1
		if mouseIndex > #mouseOptions then
			mouseIndex = 1
		end
	else
		mouseIndex = mouseIndex - 1
		if mouseIndex < 1 then
			mouseIndex = #mouseOptions
		end
	end
end
function love.mousepressed( x, y, button, istouch)
	--[[if button == 2 then
		mouseIndex = mouseIndex + 1
		if mouseIndex > #mouseOptions then
			mouseIndex = 1
		end
	end]]
end
function love.keypressed( key, scancode, isrepeat )
	if key == 'space' then
		print(level)
	end

end
function love.update(dt)
	x = love.mouse.getX()
	y = love.mouse.getY()
	rows = math.floor(y/16)
	cols = math.floor(x/16)
	if love.mouse.isDown(1) then
		level = level:sub(1,51*rows+cols) .. mouseOptions:sub(mouseIndex,mouseIndex) .. level:sub(51*rows+cols+2)
		--print(level)
	elseif love.mouse.isDown(2) then
		level = level:sub(1,51*rows+cols) .. " " .. level:sub(51*rows+cols+2)
	end
	
end
function drawTiles()
	lineI, colI = 1,1
	for line in level:gmatch(chCl) do 
		colI=1
		for char in line:gmatch('.') do
			love.graphics.draw(Tileset, Quads[char], (colI-1)*16, (lineI-1)*16)
			colI=colI+1
		end
		lineI = lineI + 1
	end
end
function love.draw()
	love.graphics.setColor(255, 255, 255)
	drawTiles()
	love.graphics.setColor(0, 0, 0)
	for x = 1, 50 do
		love.graphics.line(x*16, 0, x*16, 576)
	end
	for y = 1, 36 do
		love.graphics.line(0, y*16, 800, y*16)
	end
	--love.graphics.setColor(100, 100, 100)
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(Tileset, Quads[mouseOptions:sub(mouseIndex,mouseIndex)], x-8, y-8)
end
