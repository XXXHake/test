--use abilities to target under the cursor

require("libs.Utils")

local stun = string.byte("R")
local clap = string.byte("F")
local drink = string.byte("T")
local tornado = string.byte("E")
local dispell = string.byte("W")
local invis = string.byte("Q")
local sufferbitch = string.byte("C")
local all = string.byte(" ")
local key = false
local hero = {}
local spell = {}
local F12 = drawMgr:CreateFont("F12","Arial",25,500)
local xx = 448


function Tick()

	if not client.connected or client.loading or client.console or client.chat then return end

	local me = entityList:GetMyHero()	
	
	if not me then return end
	
	if me.classId ~= CDOTA_Unit_Hero_Brewmaster then
		script:Disable()
	elseif not key then
		script:RegisterEvent(EVENT_KEY,Key)
		key = true
	end

	splits = entityList:GetEntities(function (ent) return ent.classId == CDOTA_Unit_Brewmaster_PrimalEarth or ent.classId == CDOTA_Unit_Brewmaster_PrimalFire or ent.classId == CDOTA_Unit_Brewmaster_PrimalStorm and ent.controllable end)

	for i,v in ipairs(splits) do
		if v.classId ~= 371 then
			if not hero[v.handle] then hero[v.handle] = {} end
			for a= 1, 4 do
				if not spell[a] then spell[a] = {} end
				if not hero[v.handle].spell then hero[v.handle].spell = {} end									
				if not hero[v.handle].spell[a] then hero[v.handle].spell[a] = {}
					hero[v.handle].spell[a].bg = drawMgr:CreateRect(-30 +a*52,xx+i*52,42,42,0x00000095) hero[v.handle].spell[a].bg.visible = false 
					hero[v.handle].spell[a].nl = drawMgr:CreateRect(-30 +a*52-1,xx+ i*52 - 1,44,44,0x00000090,true) hero[v.handle].spell[a].nl.visible = false					
					hero[v.handle].spell[a].fon = drawMgr:CreateRect(-30 +a*52-1,xx+ i*52,44,44,0x00000099) hero[v.handle].spell[a].fon.visible = false
					hero[v.handle].spell[a].textT = drawMgr:CreateText(-30 +a*52+16,xx+8+ i*52,0xFFFFFFff,"",F12) hero[v.handle].spell[a].textT.visible = false 
				end				
				local Spell = v:GetAbility(a)				
				if v.alive and Spell ~= nil then
					hero[v.handle].spell[a].bg.textureId = drawMgr:GetTextureId("NyanUI/spellicons/"..Spell.name)
					hero[v.handle].spell[a].bg.visible = true
					hero[v.handle].spell[a].nl.visible = true
					if Spell.state == -1 then
						hero[v.handle].spell[a].textT.visible = false
						hero[v.handle].spell[a].fon.visible = false
					elseif Spell.cd > 0 then
						local cooldown = math.ceil(Spell.cd)
						hero[v.handle].spell[a].textT.text = ""..cooldown hero[v.handle].spell[a].textT.visible = true
						hero[v.handle].spell[a].fon.visible = true
					elseif hero[v.handle].spell[a].nl.visible then
						hero[v.handle].spell[a].nl.visible = false
						hero[v.handle].spell[a].textT.visible = false
						hero[v.handle].spell[a].fon.visible = false
					end
				else
					if hero[v.handle].spell[a].bg.visible then
						hero[v.handle].spell[a].bg.visible = false
						hero[v.handle].spell[a].nl.visible = false
						hero[v.handle].spell[a].textT.visible = false
						hero[v.handle].spell[a].fon.visible = false
					end
				end
			end
		end
	end	
	
end

function Key()

	if not client.connected or client.loading or client.console or client.chat then return end

	local me = entityList:GetMyHero()	
	
	if not me then return end

	if me.classId ~= CDOTA_Unit_Hero_Brewmaster then
		script:Disable()
	else
		local target = entityList:GetMouseover()
		local player = entityList:GetMyPlayer()
		
		for i,v in ipairs(splits) do
			if v.health > 0 then
				if IsKeyDown(all) then
					if v then
						player:SelectAdd(v)
					end
				end			
				if v.classId == 370 then
					if IsKeyDown(stun) then
						if target then
							v:CastAbility(v:GetAbility(1),target)
						end
						return true
					elseif IsKeyDown(clap) then
						v:CastAbility(v:GetAbility(4))
						return true
					end
				end			
				if v.classId == 372 then
					if IsKeyDown(drink) then
						if target then
							v:CastAbility(v:GetAbility(4),target)
						end
						return true
					elseif IsKeyDown(tornado) then
						if target then
							v:CastAbility(v:GetAbility(2),target)
						end
						return true
					elseif IsKeyDown(dispell) then		
						v:CastAbility(v:GetAbility(1),client.mousePosition)
						return true
					elseif IsKeyDown(invis) then
						player:Select(v)
						player:UseAbility(v:GetAbility(3))
						return true
					end
				end			
				if v.classId == 371 then	
					if IsKeyDown(sufferbitch) then
						if target then
							v:Attack(target)
							player:Unselect(v)
						end
					end
				end
			end
		end
	end
	
end

function GameClose()
	ey = false
	spell = {}
	hero = {}	
	collectgarbage("collect")	
end

script:RegisterEvent(EVENT_TICK,Tick)