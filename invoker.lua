require("libs.Utils")

---------------config---------------
Activated = true
Spell = true
ActivatedKey = string.byte("P")
SpellKey = string.byte("L")
xx = 10
yy = 100
------------------------------------

list = { 
		{meteor,string.byte("D"),3,3,2,6},
		{snap,string.byte("Y"),1,1,1,6},
		{alacrity,string.byte("Z"),2,2,3,6},
		{emp,string.byte("C"),2,2,2,6},
		{tornado,string.byte("X"),2,2,1,6},
		{blast,string.byte("B"),1,2,3,6},
		{forge,string.byte("F"),3,3,1,6},
		{wall,string.byte("G"),1,1,3,6},
		{ss,string.byte("T"),3,3,3,6},
		{walk,string.byte("V"),1,1,2,6},
}

icons = {}
spells = {}
aa = true

function Tick()

	if not client.connected or client.loading or client.console or not SleepCheck() then return end

	local me = entityList:GetMyHero()

	if not me then return end	
	
	Start = true
	
	if me.name ~= "npc_dota_hero_invoker" then
		script:Disable()
	else
		if Spell then clear = nil
			local q = me:GetAbility(1) local w = me:GetAbility(2) local e = me:GetAbility(3) local r = me:GetAbility(6)		
			if aa then
				for i = 1, 15 do
					local skill = me:GetAbility(i)				
					if skill.name ~= q.name and skill.name ~= w.name and skill.name ~= e.name and skill.name ~= r.name and skill.name ~= "invoker_empty1" and skill.name ~= "invoker_empty2" then				
						table.insert(icons, skill)
						aa = false
					end
				end
			end
			for i,v in ipairs(icons) do
				if not spells[i] then spells[i] = {}
				spells[i].icon = drawMgr:CreateRect(xx,yy+35*i,32,32,0x000000FF,drawMgr:GetTextureId("NyanUI/spellicons/"..v.name)) spells[i].icon.visible = false
				spells[i].rect = drawMgr:CreateRect(xx,yy+35*i,32,32,0x000000FF,true) spells[i].rect.visible = false
				spells[i].stat = drawMgr:CreateRect(xx+1,yy+35*i+1,30,30,0x000000FF) spells[i].stat.visible = false
				spells[i].txt = drawMgr:CreateText(xx+6,yy+35*i+6,0xFFFFFFff,"",drawMgr:CreateFont("F11","Arial",20,600)) spells[i].txt.visible = false	
				end
				spells[i].icon.visible = true
				spells[i].rect.visible = true
				if v.cd > 0 then						
					local cd = math.ceil(v.cd)
					if cd < 10 then	spells[i].txt.x = xx+10 elseif cd > 100 then spells[i].txt.x = xx+1 else spells[i].txt.x = xx+6 end
					spells[i].txt.text = ""..cd spells[i].txt.visible = true spells[i].txt.color = 0xFFFFFFff
					spells[i].stat.color  = 0xA1A4A120 spells[i].stat.visible = true
				elseif me.mana - v.manacost - r.manacost < 0 then					
					local mp = math.floor(math.ceil(v.manacost + r.manacost - me.mana))
					if mp < 10 then	spells[i].txt.x = xx+10 elseif mp > 100 then spells[i].txt.x = xx+1 else spells[i].txt.x = xx+6 end
					spells[i].txt.text = ""..mp spells[i].txt.visible = true spells[i].txt.color = 0xBBA9EEff
					spells[i].stat.color  = 0x047AFF20 spells[i].stat.visible = true
				else
					spells[i].txt.visible = false spells[i].stat.visible = false
				end				
			end
		else
			if not clear then
				Clear()
				clear = true
			end	
		end
	end
	Sleep(250)
end

function Key(msg,code)
	
	if not client.chat and Start then	
	
		if IsKeyDown(ActivatedKey) then
			Activated = not Activated 
		end
		
		if IsKeyDown(SpellKey) then
			Spell = not Spell
		end
	
		if Activated then	
			local me = entityList:GetMyHero()
			local invoke = me:GetAbility(6)
			if invoke.state == -1 then
				for i,v in ipairs(list) do
					if (IsKeyDown(v[2]) and IsKeyDown(0x12)) then
						me:CastAbility(me:GetAbility(v[3])) me:CastAbility(me:GetAbility(v[4])) me:CastAbility(me:GetAbility(v[5])) me:CastAbility(me:GetAbility(v[6]))
					end
				end
			end
		end
		
	end
	
end

function Clear()
	if icons ~= nil then
		for i,v in ipairs(icons) do
			spells[i].icon.visible = false
			spells[i].rect.visible = false
			spells[i].stat.visible = false
			spells[i].txt.visible = false
		end
	end
end

function GameClose()
	Clear()
	Clear = nil
	icons = {}
	spells = {}
	aa = true
	Start = false
	collectgarbage("collect")
end


script:RegisterEvent(EVENT_CLOSE, GameClose)
script:RegisterEvent(EVENT_KEY,Key)
script:RegisterEvent(EVENT_TICK,Tick)
