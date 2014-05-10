require("libs.Res")

local eff = {}

icon = drawMgr:CreateRect(0,0,16,16,0x000000ff)
icon.visible =false

function Tick(tick)
 
	if not client.connected or client.loading or client.console then return end

	local me = entityList:GetMyHero()
	
	if not me then return end
	
	local enemy = entityList:GetEntities({type=LuaEntity.TYPE_HERO, alive = true, team = (5 - me.team)})
	for i,v in ipairs(enemy) do
		if v.name == "npc_dota_hero_mirana" then
			if not Sick or (Sick and Sick >= tick) then
				icon.visible = not v.visible					
			else
				runeMinimap = nil
				icon.visible = false
			end
		end
	end

	local cast = entityList:GetEntities({classId=CDOTA_BaseNPC})

	for i,v in ipairs(cast) do
		local vision = v.dayVision
		if vision == 650 then
			if not start then start = v.position 
				return 
			end
			if v.visibleToEnemy then
				if not vec then vec = v.position end
			end				
			if start and vec then
				local distance = GetDistancePosD(vec,start)
				for z = 1,30 do
					if not eff[z] then
						local p = Vector((vec.x - start.x) * 100*z / distance + start.x,(vec.y - start.y) * 100*z / distance + start.y,v.position.z)
						eff[z] = Effect(p, "blueTorch_flame" )
						eff[z]:SetVector(0,p)							
					end						
				end
				sleeptick = tick + 3500
			end
			if runeMinimap == nil then
				Sick = tick + 3500
				runeMinimap = MapToMinimap(v.position.x,v.position.y)
				icon.x = runeMinimap.x-20/2
				icon.y = runeMinimap.y-20/2
				icon.textureId = drawMgr:GetTextureId("NyanUI/miniheroes/mirana")
			end
		end
	end
	if start ~= nil and vec ~= nil and tick > sleeptick then			
		for z = 1, 30 do
			eff[z] = nil
		end
		collectgarbage("collect")
		start,vec = nil,nil
	end

end

function GetDistancePosD(a,b)
    return math.sqrt(math.pow(a.x-b.x,2)+math.pow(a.y-b.y,2))
end
   
script:RegisterEvent(EVENT_TICK,Tick)
