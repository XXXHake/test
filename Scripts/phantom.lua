local sleepTick = 0

function Tick(tick)

	if not client.connected or client.loading or client.console or tick < sleepTick then
		return
	end
	
	local me = entityList:GetMyPlayer()
	
	local PL = entityList:FindEntities(function (v) return v.type==LuaEntity.TYPE_HERO and v.classId == CDOTA_Unit_Hero_PhantomLancer and v.team ~= me.team and v.visible and not v.illusion end)
	local illusions = entityList:FindEntities(function (v) return v.type==LuaEntity.TYPE_HERO and v.classId == CDOTA_Unit_Hero_PhantomLancer and v.illusion and v.team ~= me.team and v.unitState == -1031241196 end)[1]

	if #PL==0 and illusions then
		if not eff then
			eff = Effect(illusions,"generic_slowed_cold")				
		end
	elseif eff then
		eff = nil
		collectgarbage("collect")
	end
 
	sleepTick = tick + 250
	
end	

function GameClose()
	eff = nil
	collectgarbage("collect")
end
 

script:RegisterEvent(EVENT_TICK, Tick)
