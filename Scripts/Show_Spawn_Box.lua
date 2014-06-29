require("libs.Utils")

spots = {
--radian
{2240,-4288,3776,-5312}, -- easy
{2688,-2944, 3776,-4096}, -- hard near rune
{1088,-3200,2304,-4544}, -- medium near rune
}

local eff = {}
local eff1 = {}
local eff2 = {}
local eff3 = {}
local eff4 = {}

local effec = "candle_flame_medium"

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
		
		local vec = Vector(me.position.x,me.position.y,me.position.z)
		
		if (GetDistance2D(Vector(k[1],k[2],0),vec) < 1500 or GetDistance2D(Vector(k[3],k[4],0),vec) < 1500) and not eff[i] then
			
			local coint1 = math.floor(math.floor(k[3]-k[1])/100)
			local coint2 = math.floor(math.floor(k[2]-k[4])/100)	
			
			eff[i] = {}		
			
			for a = 1,20 do
				eff[i].eff1 = {} eff[i].eff2 = {}	
				eff[i].eff3 = {} eff[i].eff4 = {}
			end		
			
			for a = 1,coint1 do
				local first = Vector(k[1]+a*100, k[4], 0)
				local second = Vector(k[1]+a*100, k[2], 0)				
				eff[i].eff1[a] = Effect(first,effec)
				eff[i].eff1[a]:SetVector(0,GetVector(first))				
				eff[i].eff3[a] = Effect(second,effec)
				eff[i].eff3[a]:SetVector(0,GetVector(second))
			end
			
			for a = 1,coint2 do		
				local first = Vector(k[1], k[4]+a*100, 0)
				local second = Vector(k[3], k[4]+a*100, 0)				
				eff[i].eff2[a] = Effect(first,effec)
				eff[i].eff2[a]:SetVector(0,GetVector(first))				
				eff[i].eff4[a] = Effect(second,effec)
				eff[i].eff4[a]:SetVector(0,GetVector(second))
			end
			
		elseif GetDistance2D(Vector(k[1],k[2],0),vec) > 1500 and GetDistance2D(Vector(k[3],k[4],0),vec) > 1500 and eff[i] then
			eff[i] = nil
			collectgarbage("collect")
		end
	
	end
	
	
end

function GetVector(Vec)
	retVector = Vec
	client:GetGroundPosition(retVector)
	retVector.z = retVector.z+50
	return retVector
end

script:RegisterEvent(EVENT_TICK,Tick)
