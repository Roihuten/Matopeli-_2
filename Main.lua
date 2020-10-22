--  -     MATOPELI     -
--   a game about a worm
--  		 &
--	 HIS INSATIABLE HUNGER


function love.load()
	leveys = 20
	korkeus = 16
	
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
	aikaraja = 0.25
	ruoki()
	
end

function ruoki()
	ruoka = {}
	ruokaX = love.math.random(1,leveys)
	ruokaY = love.math.random(1,korkeus)
	
	ruoka.x = ruokaX
	ruoka.y = ruokaY
	-- pisteen lisäys
	
end


-- Funktio peli"framien" piirtämiseen
function love.draw()
	local ruutu = 15;
	love.graphics.setColor(.28,.28,.28)
	
	love.graphics.rectangle('fill', 0, 0, leveys*ruutu, korkeus*ruutu)
	
	
	
	local function piirraRuutu(x,y)
		love.graphics.rectangle('fill',(x-1)*ruutu,(y-1)*ruutu,ruutu-1,ruutu-1)
	end
	
	love.graphics.setColor(1,.3,.3)
	piirraRuutu(ruoka.x,ruoka.y)
	
	for indeksi , matopala in ipairs(mato) do
		love.graphics.setColor(.6,.9,0.32)
		piirraRuutu(matopala.x, matopala.y)
	end
	
end

function love.update(dt)
	
	ajastin = ajastin + dt
	
	if ajastin >= aikaraja then
	
		ajastin = ajastin - aikaraja
	
		local seuraavax = mato[1].x
		local seuraavay = mato[1].y
		
		peliJatkuu = true
		
		if suunta == 'right' then
			seuraavax = seuraavax + 1
			
			if seuraavax > leveys then
				-- VAIHDETTU miinus PLUSSAKSI YLLÄOLEVASSA leveys +/- 1 KOHDASSA
				--KORJAUS: PELKKÄ LEVEYS (ja korkeus alempana)
				peliJatkuu = false
			end
			
		elseif suunta == 'left' then
			seuraavax = seuraavax - 1
			
			if seuraavax < 1 then
				peliJatkuu = false
			end
			
		elseif suunta == 'down' then
			seuraavay = seuraavay + 1
			
			if seuraavay > korkeus then
				peliJatkuu = false
			end
			
		elseif suunta == 'up' then
			seuraavay = seuraavay - 1
			
			if seuraavay < 1 then
				peliJatkuu = false
			end	
		
		end
		
		if peliJatkuu then
			table.insert(mato,1,{x =seuraavax, y = seuraavay})
			
			if mato[1].x == ruoka.x and mato[1].y == ruoka.y then
				ruoki()
				
				aikaraja = aikaraja - 0.01
				if aikaraja < 0.02 then
				end
				
			else
				table.remove(mato)
			end
		end
		
		
		
	end
end

function love.keypressed(key)
	if(key == 'right' and peliJatkuu == true and suunta ~= 'left') then
		suunta = 'right'
		
	elseif key == 'left' and peliJatkuu == true and suunta ~= 'right' then
		suunta = 'left'
	
	elseif key == 'up' and peliJatkuu == true and suunta ~= 'down' then
		suunta = 'up'
		
	elseif key == 'down' and peliJatkuu == true and suunta ~= 'up' then
		suunta = 'down'
	end
end























