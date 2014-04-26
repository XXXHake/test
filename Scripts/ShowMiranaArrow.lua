require("libs.Utils")

eff = {} pp = {} one = {} two = {}
sleeptick = 0 clear = true rrr = {}

F14 = drawMgr:CreateFont("F14","Calibri",33,500)

for z = 1, 40 do	
rrr[z] = drawMgr:CreateText(800, 150, 0xFF0D0D90,"Arrow",F14)
rrr[z].visible = false
end

function Tick(tick)
 
        if not client.connected or client.loading or client.console then return end
       
        local me = entityList:GetMyHero()
       
        if not me then return end
       
        local cast = entityList:GetEntities({classId=CDOTA_BaseNPC})
       
        for i,v in ipairs(cast) do
			if v.team ~= me.team then

				if pp[v.handle] == nil then one[v.handle] = v.position pp[v.handle] = 1 else two[v.handle] = v.position pp[v.handle] = nil end

				if one[v.handle] ~= nil and two[v.handle] ~= nil then					
					local distance = GetDistance(one[v.handle],two[v.handle])
					if distance ~= 17 and distance < 21 then
						local x_ = one[v.handle].x - two[v.handle].x						
						local y_ = one[v.handle].y - two[v.handle].y
						one[v.handle] = nil two[v.handle] = nil	
						if x_ > 1 or x_ < -1 then
							for z = 1, 40 do
								
								if me.activity == 422 and me:CanMove() then
									local vec = Vector(me.position.x + me.movespeed * (z * 0.1) * math.cos(me.rotR), me.position.y + me.movespeed* (z * 0.1) * math.sin(me.rotR), me.position.z)
									if ((v.position.x - x_*z*5-vec.x)^2+(v.position.y - y_*z*5-vec.y)^2)<=115^2 then
										me:Stop()
									--	rrr[z].visible = true
									--	rrr[z].text = "Predict Arrow"
									else
									--	rrr[z].text = "Predict Arrow"
									--	rrr[z].visible = false
									end
								else
									if ((v.position.x - x_*z*5-me.position.x)^2+(v.position.y - y_*z*5-me.position.y)^2)<=115^2 then										
									--	me:Move(Vector(0-me.position.y - y_*z*5,me.position.x - x_*z*5,me.position.z))
									--	rrr[z].text = "Arrow"
									--	rrr[z].visible = true
									else
									--	rrr[z].visible = false
									end
								end
							end
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
						end

					else
						one[v.handle] = nil two[v.handle] = nil
					end					
				end

			end
        end
		if clear == false and tick > sleeptick then
			for z = 1, 17 do
				eff[z] = nil
				--rrr[z].visible = false
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

--if ((v.position.x - x_*z*5-me.position.x)^2+(v.position.y - y_*z*5-me.position.y)^2)<=115^2 then

--[[function Prediction(me,)
	if me.activity == 422 and me:CanMove() then
		if Vector(first.position.x + first.movespeed * (GetDistance2D(first,me)/(list[mename].Speed * math.sqrt(1 - math.pow(first.movespeed/list[mename].Speed,2))) + list[mename].CastTime) * math.cos(first.rotR), first.position.y + first.movespeed * (GetDistance2D(first,me)/(list[mename].Speed * math.sqrt(1 - math.pow(first.movespeed/list[mename].Speed,2))) + list[mename].CastTime) * math.sin(first.rotR), first.position.z)) Sleep(100)
		end											
	else
		me:SafeCastAbility(Skill,Vector(first.position.x + first.movespeed * 0.05 * math.cos(first.rotR), first.position.y + first.movespeed* 0.05 * math.sin(first.rotR), first.position.z)) Sleep(100)
	end		
end]]

function GetDistance(a,b)
	return math.sqrt(math.pow(a.x-b.x,2)+math.pow(a.y-b.y,2))
end
 
script:RegisterEvent(EVENT_CLOSE,GameClose)            
script:RegisterEvent(EVENT_FRAME,Tick)
