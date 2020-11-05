--  -     MATOPELI     -
--   a game about a worm
--  		 &
--	 HIS INSATIABLE HUNGER


function love.load()
	leveys = 20
	korkeus = 16
	love.window.setMode(leveys*15, korkeus*15)
	-- leveys & korkeus *kertaa NUMERO = numeron pitää olla samankokoinen "ruudun" kanssa (kts. alempaa ruutu muuuttuja)
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
	pisteet = 0
	ruoki()
	
end

function ruoki()
	ruoka = {}
	ruokaX = love.math.random(1,leveys)
	ruokaY = love.math.random(1,korkeus)
	
	local voiRuokkia = true
	
	for indeksi, matopala in ipairs(mato) do
	
		if ruokaX == matopala.x and ruokaY == matopala.y then
			voiRuokkia = false
		end
	
	
	end
	
	if voiRuokkia then
		ruoka.x = ruokaX
		ruoka.y = ruokaY
	-- pisteen lisäys
	else
		ruoki()
	end
	

	
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
	
	love.graphics.print(pisteet,(leveys -1)*ruutu,0)
	
	if peliJatkuu == false then
		love.graphics.setColor(1,0,0.25)
		gameoverText = "-- GAME OVER --\n\n     Points: " .. tostring(pisteet) .. "\n\nPress Enter to be \n   ~ REBORN ~"
		love.graphics.print(gameoverText,(leveys/3*ruutu), (korkeus*ruutu/3))
		
		
		
		
		--love.graphics.print("GAME OVER",(leveys -1)*ruutu,0)
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
		
		for indeksi,matopala in ipairs(mato) do
			if indeksi ~= #mato and seuraavax == matopala.x and seuraavay == matopala.y then
				peliJatkuu = false
			end
		end
		
		if peliJatkuu then
			table.insert(mato,1,{x =seuraavax, y = seuraavay})
			
			if mato[1].x == ruoka.x and mato[1].y == ruoka.y then
				pisteet = pisteet + 1
				ruoki()
				
				aikaraja = aikaraja - 0.005
				if aikaraja < 0.05 then
				aikaraja = 0.05
				end
				
			else
				table.remove(mato)
			end
		end
		
		
		
	end
end

function love.keypressed(key)
	if key == 'right' and peliJatkuu == true and suunta ~= 'left' then
		suunta = 'right'
		
	elseif key == 'left' and peliJatkuu == true and suunta ~= 'right' then
		suunta = 'left'
	
	-- U Käännös bugi: mato hajoaa jos suunta on alas ja painaa left & ylös niin mato hajoaa...
	-- Eli suunta on vaihtunut ennen kuin mato on liikkunut; ja täten pystyy tekemään "laittoman" U käännöksen ja häviämään
	
	elseif key == 'up' and peliJatkuu == true and suunta ~= 'down' then
		suunta = 'up'
		
	elseif key == 'down' and peliJatkuu == true and suunta ~= 'up' then
		suunta = 'down'
		
	elseif key =='return' then
		reset()
	end
end























