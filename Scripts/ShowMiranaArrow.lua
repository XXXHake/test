require("libs.Res")

local eff = {}

icon = drawMgr:CreateRect(0,0,16,16,0x000000ff)
icon.visible =false

function Tick(tick)
 
		if not client.connected or client.loading or client.console then return end

		local me = entityList:GetMyHero()
		
		
		local enemy = entityList:GetEntities({type=LuaEntity.TYPE_HERO, alive = true, team = (5 - me.team)})
		for i,v in ipairs(enemy) do
			if v.name == "npc_dota_hero_mirana" then
				if not Sick or (Sick and Sick >= tick) then
					icon.visible = not v.visible					
				else
					aa = false
					icon.visible = false
				end
			end
		end

		local cast = entityList:GetEntities({classId=CDOTA_BaseNPC})

		for i,v in ipairs(cast) do
			local vision = v.dayVision
			if vision == 650 then
				if not start then start = v.position end
				if pp == nil then one = v.position pp = 1 else two = v.position pp = nil end
				if one ~= nil and two ~= nil then
					if one.x ~= two.x and one.y ~= two.y then
						if start == one then theend = two else theend = one	end
						for z = 1, math.ceil((3000-GetDistancePosD(one,two))/100) do
							if not eff[z] then
								local p = Vector((theend.x - start.x) * 100*z / GetDistancePosD(theend,start) + start.x,(theend.y - start.y) * 100*z / GetDistancePosD(start,theend) + start.y,v.position.z-200)
								eff[z] = Effect(p, "blueTorch_flame" )
								eff[z]:SetVector(0,p)
								sleeptick = tick + 3000
								clear = false
							end
						end
					end
				end
				if not aa then
					aa = true
					Sick = tick + 3000
					runeMinimap = MapToMinimap(v.position.x,v.position.y)
					icon.x = runeMinimap.x-20/2
					icon.y = runeMinimap.y-20/2
					icon.textureId = drawMgr:GetTextureId("NyanUI/miniheroes/mirana")
				end
			end
		end
		if clear == false and tick > sleeptick then
			for z = 1, 30 do
				eff[z] = nil
			end
			collectgarbage("collect")
			clear = true
		end
		

end

function GetDistancePosD(a,b)
    return math.sqrt(math.pow(a.x-b.x,2)+math.pow(a.y-b.y,2))
end
   
script:RegisterEvent(EVENT_TICK,Tick)
