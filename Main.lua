--  -     MATOPELI     -
--  "a game about a worm"


function love.load()
	leveys = 20
	korkeus = 15
	
	reset()
end

function reset()

	mato ={
	{x = 3+leveys/2, y = korkeus/2},
	{x = 2+leveys/2, y = korkeus/2},
	{x = 1+leveys/2, y = korkeus/2},
	}
	
	suunta = 'right'
	ajastin = 0
	
end



-- Funktio peli"framien" piirtämiseen
function love.draw()
	local ruutu = 15;
	love.graphics.setColor(.28,.28,.28)
	
	love.graphics.rectangle('fill', 0, 0, leveys*ruutu, korkeus*ruutu)
	
	local function piirraRuutu(x,y)
		love.graphics.rectangle('fill',(x-1)*ruutu,(y-1)*ruutu,ruutu-1,ruutu-1)
	end
	
	for indeksi , matopala in ipairs(mato) do
		love.graphics.setColor(.6,.9,0.32)
		piirraRuutu(matopala.x, matopala.y)
	end
	
end

function love.update(dt)
	
	local seuraavax = mato[1].x
	local seuraavay = mato[1].y
	
	if suunta == 'right' then
		seuraavax = seuraavax + 1
		
		if seuraavax > leveys - 1 then
		suunta = 'left'
		end
		
	elseif suunta == 'left' then
		seuraavax = seuraavax - 1
		
		if seuraavax < 1 then
		suunta = 'right'
		end
	end
	
	table.insert(mato,1,{x =seuraavax, y = seuraavay})
	table.remove(mato)
end








