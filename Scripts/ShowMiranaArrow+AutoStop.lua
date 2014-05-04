require("libs.Utils")

eff = {} pp = {} one = {} two = {}
sleeptick = 0 clear = true rrr = {}

function Tick(tick)
 
        if not client.connected or client.loading or client.console then return end
       
        local me = entityList:GetMyHero()
       
        if not me or me:IsMagicDmgImmune() then return end
       
        local cast = entityList:GetEntities({classId=CDOTA_BaseNPC})
       
        for i,v in ipairs(cast) do
			if v.team ~= me.team then

				if v.dayVision == 650 then

					if pp[v.handle] == nil then one[v.handle] = v.position pp[v.handle] = 1 else two[v.handle] = v.position pp[v.handle] = nil end

					if one[v.handle] ~= nil and two[v.handle] ~= nil then					
						local distance = GetDistance(one[v.handle],two[v.handle])
						if distance ~= 17 and distance < 21 then
							local x_ = one[v.handle].x - two[v.handle].x						
							local y_ = one[v.handle].y - two[v.handle].y
							one[v.handle] = nil two[v.handle] = nil	
							if x_ > 1 or x_ < -1 then
								--[[for z = 1, 40 do
									if GetDistance(v.position,me.position) < 3000 then
										if me.activity == 422 and me:CanMove() then
											if ((v.position.x - x_*z*5-me.position.x)^2+(v.position.y - y_*z*5-me.position.y)^2)>=115^2 then
												local vec = Vector(me.position.x + me.movespeed * (z * 0.1) * math.cos(me.rotR), me.position.y + me.movespeed* (z * 0.1) * math.sin(me.rotR), me.position.z)
												if ((v.position.x - x_*z*5-vec.x)^2+(v.position.y - y_*z*5-vec.y)^2)<=115^2 then
													me:Stop()
												end
											end
										else
											if ((v.position.x - x_*z*5-me.position.x)^2+(v.position.y - y_*z*5-me.position.y)^2)<=115^2 then										
											me:Move(Vector(me.position.y - y_*z*5,me.position.x - x_*z*5,me.position.z))
											end
										end
									end]]
									if clear then
										for z = 1, 17 do									
											local p = Vector(v.position.x - x_*z*10, v.position.y - y_*z*10, v.position.z-200)
											eff[z] = Effect(p, "fire_torch" )
											eff[z]:SetVector(1,Vector(255,255,255))
											eff[z]:SetVector(0,p)
											
										end
										sleeptick = tick + 4000
										clear = false
									end
								--end
							end

						else
							one[v.handle] = nil two[v.handle] = nil
						end					
					end
				end

			end
        end
		if clear == false and tick > sleeptick then
			for z = 1, 17 do
				eff[z] = nil
			end
			collectgarbage("collect")
			clear = true
		end
end
 
function GameClose()
	for z = 1, 17 do
		eff[z] = nil
	end
	sleeptick = 0
	clear = true
	collectgarbage("collect")
end

function GetDistance(a,b)
	return math.sqrt(math.pow(a.x-b.x,2)+math.pow(a.y-b.y,2))
end
 
script:RegisterEvent(EVENT_CLOSE,GameClose)            
script:RegisterEvent(EVENT_FRAME,Tick)
