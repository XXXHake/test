require("libs.Utils")

spots = {
--radian
{2240,-4288,3776,-5312}, -- easy
{2688,-2944, 3776,-4096}, -- medium near rune
{1088,-3200,2304,-4544}, -- hard near rune
}

eff = {}
eff1 = {}
eff2 = {}
eff3 = {}
eff4 = {}
draw = {}

--[[

	a----b
	|	 |
	|	 |
	d----c
	
	a 2240;-4288
	c 3776;-5312

]]

function Tick(tick)

	if not client.connected or client.loading or client.console or not SleepCheck() then return end	
	
	Sleep(500)
	
	local me = entityList:GetMyHero()
	if not me then return end


	for i,k in ipairs(spots) do
	
		if not eff[i] then
			eff[i] = {}
		end
		
		local vec = Vector(me.position.x,me.position.y,me.position.z)
		
		if (GetDistance2D(Vector(k[1],k[2],0),vec) < 1000 or GetDistance2D(Vector(k[3],k[4],0),vec) < 1000) and not draw[i] then
		
			draw[i] = true 
			
			local coint1 = math.floor(math.floor(k[3]-k[1])/100)
			local coint2 = math.floor(math.floor(k[2]-k[4])/100)

			for a = 1,20 do
				if not eff1[a] then eff1[a] = {} end
				if not eff[i].eff1 then
					eff[i].eff1 = {}	
				end
				if not eff[i].eff2 then
					eff[i].eff2 = {}	
				end	
				if not eff[i].eff3 then
					eff[i].eff3 = {}	
				end	
				if not eff[i].eff4 then
					eff[i].eff4 = {}	
				end	
			end
			
			for a = 1,coint1 do
				if not eff[i].eff1[a] then	
					eff[i].eff1[a] = Effect(Vector(k[1]+a*100, k[4], 300),"candle_flame_medium")
					eff[i].eff1[a]:SetVector(0,Vector(k[1]+a*100, k[4], 300))
				end
			end
			for a = 1,coint2 do
				if not eff[i].eff2[a] then			
					eff[i].eff2[a] = Effect(Vector(k[1], k[4]+a*100, 300),"candle_flame_medium")
					eff[i].eff2[a]:SetVector(0,Vector(k[1], k[4]+a*100, 300))
				end
			end
			for a = 1,coint1 do
				if not eff[i].eff3[a] then			
					eff[i].eff3[a] = Effect(Vector(k[1]+a*100, k[2], 300),"candle_flame_medium")
					eff[i].eff3[a]:SetVector(0,Vector(k[1]+a*100,k[2], 300))
				end
			end
			for a = 1,coint2 do
				if not eff[i].eff4[a] then			
					eff[i].eff4[a] = Effect(Vector(k[3], k[4]+a*100, 300),"candle_flame_medium")
					eff[i].eff4[a]:SetVector(0,Vector(k[3], k[4]+a*100, 300))
				end
			end
			
		elseif GetDistance2D(Vector(k[1],k[2],0),vec) > 1000 and GetDistance2D(Vector(k[3],k[4],0),vec) > 1000 and draw[i] then
			draw[i] = false
			eff[i] = nil
			collectgarbage("collect")
		end
	
	end
	
	
end

script:RegisterEvent(EVENT_TICK,Tick)
