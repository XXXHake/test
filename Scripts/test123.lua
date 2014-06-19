require("libs.Utils")
require("libs.SideMessage")

------------------------[[Config]]-------------------------
local toggleKey = string.byte("Z")
local ComboKey = string.byte("Z")
------------------------------------------------------------
if math.floor(client.screenRatio*100) == 177 then
	xx = client.screenSize.x/300
	yy = client.screenSize.y/1.372
elseif math.floor(client.screenRatio*100) == 125 then
	xx = client.screenSize.x/512
	yy = client.screenSize.y/1.341
elseif math.floor(client.screenRatio*100) == 160 then
	xx = client.screenSize.x/512
	yy = client.screenSize.y/1.378
else
	xx = client.screenSize.x/512
	yy = client.screenSize.y/1.378
end

--Stuff
local hero = {} local note = {} local reg = false
local activ = true local draw = true local myhero = nil

--Draw function
local shft = client.screenSize.x/1600
local F14 = drawMgr:CreateFont("F14","Calibri",14*shft,500*shft)
local rect = drawMgr:CreateRect(xx-1,yy-1,26,26,0x00000090,true)
rect.visible = false
local icon = drawMgr:CreateRect(xx,yy,24,24,0x000000ff)
icon.visible = false
local dmgCalc = drawMgr:CreateText(xx*shft, yy-18*shft, 0x00000099,"Dmg",F14)
dmgCalc.visible = false

function Load()
	if PlayingGame() then
		local me = entityList:GetMyHero()
		if KillStealer(me) then 
			script:Disable() 
		else
			reg = true
			myhero = me.classId
			script:RegisterEvent(EVENT_TICK,Tick)
			script:RegisterEvent(EVENT_KEY,Key)
			script:UnregisterEvent(Load)
		end
	end
end

function Tick(tick)
	
	if not SleepCheck() then return end	Sleep(150)

	local me = entityList:GetMyHero()	
	if not me then			
		return
	end
	local ID = me.classId
	if ID ~= myhero then
		GameClose()
	end

	dmgCalc.visible = draw
	rect.visible,icon.visible = activ,activ
	
	--Kill(false,me,ability,damage,scepter damage,range,target,classId,damage type)
	if ID == CDOTA_Unit_Hero_Abaddon then
		Kill(false,me,1,{100, 150, 200, 250},nil,nil,1)
	elseif ID == CDOTA_Unit_Hero_Axe then		
		Kill(false,me,4,{250,350,450},{300,450,625},400,1,nil,DAMAGE_HPRM)
	elseif ID == CDOTA_Unit_Hero_Bane then
		Kill(false,me,2,{90, 160, 230, 300},nil,nil,1)
	elseif ID == CDOTA_Unit_Hero_BountyHunter then
		Kill(false,me,1,{100, 200, 250, 325},nil,700,1)
	elseif ID == CDOTA_Unit_Hero_Broodmother then
		Kill(false,me,1,{75, 150, 225, 300},nil,nil,1)
	elseif ID == CDOTA_Unit_Hero_Centaur then
		Kill(false,me,2,{175, 250, 325, 400},nil,300,1)
	elseif ID == CDOTA_Unit_Hero_Chen then
		Kill(false,me,2,{50, 100, 150, 200},nil,nil,1)
	elseif ID == CDOTA_Unit_Hero_CrystalMaiden then		
		Kill(false,me,1,{100, 150, 200, 250},nil,700,2)
	elseif ID == CDOTA_Unit_Hero_DeathProphet then		
		Kill(false,me,1,{100, 175, 250, 300},nil,nil,1)
	elseif ID == CDOTA_Unit_Hero_DragonKnight then
		Kill(false,me,1,{90, 170, 240, 300},nil,nil,1)
	elseif ID == CDOTA_Unit_Hero_Leshrac then
		Kill(false,me,3,{80, 140, 200, 260},nil,nil,1)
	elseif ID == CDOTA_Unit_Hero_Lich then		
		Kill(false,me,1,{50, 100, 150, 200},nil,nil,1)
	elseif ID == CDOTA_Unit_Hero_Lion then
		Kill(false,me,4,{600, 725, 850},{725, 875, 1025},nil,1)
	elseif ID == CDOTA_Unit_Hero_Luna then		
		Kill(false,me,1,{75, 150, 210, 260},nil,nil,1)	
	elseif ID ==CDOTA_Unit_Hero_NightStalker then
		Kill(false,me,1,{90, 160, 225, 335},nil,nil,1)
	elseif ID == CDOTA_Unit_Hero_PhantomAssassin then
		Kill(false,me,1,{30, 50, 70, 90},nil,nil,1)
	elseif ID == CDOTA_Unit_Hero_PhantomLancer then
		Kill(false,me,1,{100, 150, 200, 250},nil,nil,1)
	elseif ID == CDOTA_Unit_Hero_Puck then
		Kill(false,me,2,{70, 140, 210, 280},nil,400,3)
	elseif ID == CDOTA_Unit_Hero_QueenOfPain then
		Kill(false,me,3,{85, 165, 225, 300},nil,475,3)
	elseif ID == CDOTA_Unit_Hero_Rattletrap then
		Kill(false,me,3,{80, 120, 160, 200},nil,1000,2)
	elseif ID == CDOTA_Unit_Hero_Rubick then
		Kill(false,me,3,{70, 140, 210, 280},nil,nil,1)
	elseif ID == CDOTA_Unit_Hero_SkeletonKing then
		Kill(false,me,1,{80, 160, 230, 300},nil,nil,1)
	elseif ID == CDOTA_Unit_Hero_Shredder then
		Kill(false,me,1,{100, 150, 200, 250},nil,300,3)
	elseif ID == CDOTA_Unit_Hero_Sniper then
		Kill(false,me,4,{350, 500, 650},nil,nil,1)
	elseif ID == CDOTA_Unit_Hero_Sven then
		Kill(false,me,1,{100, 175, 250, 325},nil,650,1)
	elseif ID == CDOTA_Unit_Hero_Tidehunter then
		Kill(false,me,1,{110, 160, 210, 260},nil,750,1)
	elseif ID == CDOTA_Unit_Hero_Tinker then
		Kill(false,me,1,{80, 160, 240, 320},nil,nil,1)
	elseif ID == CDOTA_Unit_Hero_VengefulSpirit then
		Kill(false,me,1,{100, 175, 250, 325},nil,nil,1)
	elseif ID == CDOTA_Unit_Hero_Lina then
		if not me:AghanimState() then Kill(false,me,4,{450,675,950},nil,nil,1) else Kill(false,me,4,{600,925,1250},nil,900,1,nil,DAMAGE_UNIV) end	
	elseif ID == CDOTA_Unit_Hero_Alchemist then
		Kill(false,me,2,{32,47,63,78},nil,800,1,ID)
	elseif ID == CDOTA_Unit_Hero_Morphling then
		Kill(false,me,2,{20, 40, 60, 80},nil,nil,1,ID)
	elseif ID == CDOTA_Unit_Hero_Visage then
		Kill(false,me,2,20,nil,nil,1,ID)
	--complex spells
	--Kill(true,me,ability,damage,scepter damage,range,target,classId,damage type)
	elseif me.classId == CDOTA_Unit_Hero_AntiMage then
		Kill(true,me,4,{.6,.85,1.1},nil,nil,1,ID)
	elseif me.classId == CDOTA_Unit_Hero_DoomBringer then
		Kill(true,me,3,{1,1,1,1},nil,nil,1,ID)
	elseif me.classId == CDOTA_Unit_Hero_Mirana then
		Kill(true,me,1,{75,150,225,300},nil,625,3,ID)
	elseif ID == CDOTA_Unit_Hero_Necrolyte then
		Kill(true,me,4,{0.4,0.6,0.9},{0.6,0.9,1.2},nil,1,ID)	
	elseif ID == CDOTA_Unit_Hero_Nyx_Assassin then
		Kill(true,me,2,{3.5,4,4.5,5},nil,nil,1,ID)	
	elseif ID == CDOTA_Unit_Hero_Obsidian_Destroyer then
		Kill(true,me,4,{8,9,10},{9,10,11},nil,2,ID)	
	elseif ID == CDOTA_Unit_Hero_Elder_Titan then
		Kill(true,me,2,{60,100,140,180},nil,nil,2,ID)	
	elseif ID == CDOTA_Unit_Hero_Shadow_Demon then
		Kill(true,me,3,{20, 35, 60, 65},nil,nil,6,ID)		
	--prediction
	elseif ID == CDOTA_Unit_Hero_Magnataur then
		KillPrediction(me,1,{75, 150, 225, 300},0.3,1050)
	elseif ID == CDOTA_Unit_Hero_Windrunner then
		local PowerShoot = me:GetAbility(2).channelTime
		if PowerShoot ~= 0 and PowerShoot > 0.6 then me:Move(me.position) end
		KillPrediction(me,2,{108, 180, 252, 334},1.2,3000)
	--global
	elseif ID == CDOTA_Unit_Hero_Furion then
		KillGlobal(me,4,{140,180,225},{155,210,275},1)
	elseif ID == CDOTA_Unit_Hero_Zuus then
		--Kill(me,2,{100,175,275,350},nil,nil,1)
		KillGlobal(me,4,{225,350,475},{440,540,640},3)
	--other
	--------------------develop--------------------
	elseif ID == CDOTA_Unit_Hero_Invoker then
		KillGlobal(me,2,{100,162,225,287,350,412,475},nil,nil,5,nil,DAMAGE_PURE)
	elseif ID == CDOTA_Unit_Hero_Life_Stealer then
	--	Kill(me,4,{150,275,400},nil,nil,nil)
	elseif ID == CDOTA_Unit_Hero_Nevermore then
		--SmartKoils(me)
	end
	
end

function Key(msg,code)
	if client.chat then return end
	if IsKeyDown(toggleKey) then
		activ = not activ
	end
	if IsMouseOnButton(xx,yy,24,24) then
		if msg == LBUTTON_DOWN then
			activ = (not activ)
		end
	end
	if IsMouseOnButton(xx*shft, yy-18*shft,24,24) then
		if msg == LBUTTON_DOWN then
			draw = (not draw)
		end
	end
end

function Kill(COMPLEX,me,ability,damage,adamage,range,target,id,tdamage)
	local Spell = me:GetAbility(ability)
	icon.textureId = drawMgr:GetTextureId("NyanUI/spellicons/"..Spell.name)
	if Spell.level > 0 then
		local Dmg = SmartGetDmg(COMPLEX,Spell.level,me,damage,adamage,id)
		local DmgT = GetDmgType(Spell,tdamage)
		local Range = GetRange(Spell,range)
		local Target = target
		local CastPoint = Spell:GetCastPoint(Spell.level)+client.latency/1000
		if me.alive and not me:IsChanneling() then
			local enemies = entityList:GetEntities({type=LuaEntity.TYPE_HERO,team = me:GetEnemyTeam(),illusion=false})			
			for i,v in ipairs(enemies) do
				if v.healthbarOffset ~= -1 then
					if not hero[v.handle] then
						hero[v.handle] = drawMgr:CreateText(20,0-45, 0xFFFFFF99, "",F14) hero[v.handle].visible = false hero[v.handle].entity = v hero[v.handle].entityPosition = Vector(0,0,v.healthbarOffset)
					end
					if v.visible and v.alive and v.health > 1 then
						hero[v.handle].visible = draw
						local DmgM = ComplexGetDmg(COMPLEX,Spell.level,me,v,Dmg,id)
						local DmgS = math.floor(v:DamageTaken(DmgM,DmgT,me))
						local DmgF = math.floor(v.health - DmgS + CastPoint*v.healthRegen)
						hero[v.handle].text = " "..DmgF
						if activ then
							if DmgF < 0 and GetDistance2D(me,v) < Range and CanDie(v,me) then
								if NotDieFromSpell(Spell,v,me) and not v:DoesHaveModifier("modifier_nyx_assassin_spiked_carapace") and NotDieFromBM(v,me,DmgS) then
									if Target == 1 then
										me:SafeCastAbility(Spell,v)	break
									elseif Target == 2 then
										me:SafeCastAbility(Spell,v.position) break
									elseif Target == 3 then
										me:SafeCastAbility(Spell) break									
									end
								end
							end
						end
					else
						hero[v.handle].visible = false
					end
				end
			end
		end
	end
end

function KillGlobal(me,ability,damage,adamage,target)
	local Spell = me:GetAbility(ability)		
	icon.textureId = drawMgr:GetTextureId("NyanUI/spellicons/"..Spell.name)
	if Spell.level > 0 then
		local Dmg = SmartGetDmg(COMPLEX,Spell.level,me,damage,adamage)
		local DmgT = GetDmgType(Spell,tdamage)	
		local Target = target
		local CastPoint = Spell:GetCastPoint(Spell.level)+client.latency/1000
		if me.alive and not me:IsChanneling() then
			local enemies = entityList:GetEntities({type=LuaEntity.TYPE_HERO,team = me:GetEnemyTeam(),illusion=false})			
			for i,v in ipairs(enemies) do
				if v.healthbarOffset ~= -1 then
					if not hero[v.handle] then
						hero[v.handle] = drawMgr:CreateText(20,0-45, 0xFFFFFF99, "",F14) hero[v.handle].visible = false hero[v.handle].entity = v hero[v.handle].entityPosition = Vector(0,0,v.healthbarOffset)
					end
					if v.visible and v.alive and v.health > 1 then
						hero[v.handle].visible = draw
						local DmgS = math.floor(v:DamageTaken(Dmg,DmgT,me))
						local DmgF = math.floor(v.health - DmgS + CastPoint*v.healthRegen)
						hero[v.handle].text = " "..DmgF						
						if DmgF < 0 and CanDie(v,me) and NotDieFromSpell(Spell,v,me) and not v:DoesHaveModifier("modifier_nyx_assassin_spiked_carapace") and NotDieFromBM(v,me,DmgS) then
							if not note[v.handle] then
								note[v.handle] = true
								GenerateSideMessage(v.name,Spell.name)
							end
							if activ then
								if Target == 1 then
									me:SafeCastAbility(Spell,v) break
								elseif Target == 3 then
									me:SafeCastAbility(Spell) break
								end
							end
						else
							note[v.handle] = false
						end						
					else						
						hero[v.handle].visible = false
					end
				end
			end
		end
	end
end

function KillPrediction(me,ability,damage,cast,project)
	local Spell = me:GetAbility(ability)
	local Cast = cast
	local Speed = project
	icon.textureId = drawMgr:GetTextureId("NyanUI/spellicons/"..Spell.name)
	if Spell.level > 0 then
		local Dmg = SmartGetDmg(COMPLEX,Spell.level,me,damage,adamage,id)
		local DmgT = GetDmgType(Spell,tdamage)
		local CastPoint = Spell:GetCastPoint(Spell.level)+client.latency/1000
		if me.alive and not me:IsChanneling() then
			local enemies = entityList:GetEntities({type=LuaEntity.TYPE_HERO,team = me:GetEnemyTeam(),illusion=false})			
			for i,v in ipairs(enemies) do
				if v.healthbarOffset ~= -1 then
					if not hero[v.handle] then
						hero[v.handle] = drawMgr:CreateText(20,0-45, 0xFFFFFF99, "",F14) hero[v.handle].visible = false hero[v.handle].entity = v hero[v.handle].entityPosition = Vector(0,0,v.healthbarOffset)
					end
					if v.visible and v.alive and v.health > 1 then
						hero[v.handle].visible = draw
						local DmgS = math.floor(v:DamageTaken(Dmg,DmgT,me))
						local DmgF = math.floor(v.health - v:DamageTaken(DmgS,DmgT,me) + CastPoint*v.healthRegen)
						hero[v.handle].text = " "..DmgF
						if activ then
							if DmgF < 0 and CanDie(v,me) and NotDieFromSpell(Spell,v,me) and not v:DoesHaveModifier("modifier_nyx_assassin_spiked_carapace") and NotDieFromBM(v,me,DmgS) then
								local move = v.movespeed
								local pos = v.position
								local distance = GetDistance2D(v,me)
								if v.activity == LuaEntityNPC.ACTIVITY_MOVE and v:CanMove() then																		
									local range = Vector(pos.x + move * (distance/(Speed * math.sqrt(1 - math.pow(move/Speed,2))) + Cast) * math.cos(v.rotR), pos.y + move * (distance/(Speed * math.sqrt(1 - math.pow(move/Speed,2))) + Cast) * math.sin(v.rotR), pos.z)
									print()
									if GetDistance2D(me,range) < Spell.castRange + 25 then									
										me:SafeCastAbility(Spell,range)	break
									end
								elseif distance < Spell.castRange + 25 then
									me:SafeCastAbility(Spell,Vector(pos.x + move * 0.05 * math.cos(v.rotR), pos.y + move* 0.05 * math.sin(v.rotR), pos.z)) break
								end
							end
						end
					else
						hero[v.handle].visible = false
					end
				end
			end
		end
	end	
end

function SmartGetDmg(complex,lvl,me,tab1,tab2,id)
	if complex or not id then		
		if not tab2 then 
			return tab1[lvl]
		elseif me:AghanimState() then
			return tab2[lvl]
		else
			return tab1[lvl]
		end
	else	
		if id == CDOTA_Unit_Hero_Alchemist then
			local modifier = me.modifiers
			if modifier then
				for i,v in ipairs(modifier) do
					if v.name == "modifier_alchemist_unstable_concoction" then
						if v.elapsedTime < 4.6 then
							return math.floor(v.elapsedTime*tab1[lvl])
						else
							return math.floor(4.6 *tab1[lvl])
						end
					end
				end
			end	
			return 0							
		elseif id == CDOTA_Unit_Hero_Morphling then
			local dmg = math.floor(me.agilityTotal)/math.floor(me.strengthTotal)
			if dmg > 1.5 then 
				return math.floor(0.5*lvl*math.floor(me.agilityTotal) + tab1[lvl])
			elseif dmg < 0.5 then 
				return math.floor(0.25*math.floor(me.agilityTotal) + tab1[lvl])
			elseif (dmg >= 0.5 and dmg <= 1.5) then 
				return math.floor(0.25+((dmg-0.5)*(0.5*lvl-0.25))*math.floor(me.agilityTotal) + tab1[lvl])
			end			
		elseif id == CDOTA_Unit_Hero_Visage then
			local modifier = me.modifiers
			if modifier then
				for i,v in ipairs(modifier) do
					if v.name == "modifier_visage_soul_assumption" then
						return 20 + 65 * v.stacks
					end
				end
			end
			return 20
		end
	end
end

function ComplexGetDmg(complex,lvl,me,ent,damage,id)
	if not complex then
		return damage
	else
		if id == CDOTA_Unit_Hero_AntiMage then
			return  math.floor((ent.maxMana - ent.mana) * damage)
		elseif id == CDOTA_Unit_Hero_DoomBringer then
			local lvldeath = {{lvlM = 6, dmg = 125}, {lvlM = 5, dmg = 175}, {lvlM = 4, dmg = 225}, {lvlM = 3, dmg = 275}}
			return math.floor((ent.level == 25 or ent.level % lvldeath[lvl].lvlM == 0) and (ent.maxHealth * 0.20 + lvldeath[lvl].dmg) or (lvldeath[lvl].dmg))
		elseif id == CDOTA_Unit_Hero_Mirana then
			if GetDistance2D(ent,me) < 200 then 
				return damage*1.75
			else
				return damage
			end
		elseif id == CDOTA_Unit_Hero_Necrolyte then
			return  math.floor((ent.maxHealth - ent.health) * damage)		
		elseif id == CDOTA_Unit_Hero_Nyx_Assassin then
			local tempBurn =  damage * math.floor(ent.intellectTotal)
			if ent.mana < tempBurn then
				return ent.mana
			else
				return tempBurn
			end
		elseif id == CDOTA_Unit_Hero_Obsidian_Destroyer then	
			if me.intellectTotal > ent.intellectTotal then			
				return (math.floor(me.intellectTotal) - math.floor(ent.intellectTotal))*damage
			else 
				return 1
			end
		elseif id == CDOTA_Unit_Hero_Elder_Titan then
			local pasDmg = {1.08,1.16,1.25,1.33}
			local pas = me:GetAbility(3).level
			if pas ~= 0 then
				if not ent:FindModifier("modifier_elder_titan_natural_order") then
					return pasDmg[pas]*damage
				else
					return damage
				end
			else 
				return damage 
			end	
		elseif id == CDOTA_Unit_Hero_Shadow_Demon then	
			local actDmg = {1, 2, 4, 8, 16}
			local modifier = ent.modifiers
			if modifier then
				for i,v in ipairs(modifier) do
					if v.name == "modifier_shadow_demon_shadow_poison" then
						local Mod = v.stacks
						if Mod ~= 0 and Mod < 6 then 
							return (actDmg[Mod]) * damage
						elseif Mod > 5 then 
							return (damage*16) + ((Mod-5)*50)					
						end
					end
				end
			end
			return 1
		end
	end
end

function GetRange(skill,range)
	if range then
		return range
	else
		return skill.castRange + 50
	end
end

function GetDmgType(skill,tip)
	if tip then
		return tip
	else	
		local typ = skill.dmgType
		if typ == LuaEntityAbility.DAMAGE_TYPE_MAGICAL then
			return DAMAGE_MAGC	
		elseif typ == LuaEntityAbility.DAMAGE_TYPE_PHYSICAL then
			return DAMAGE_PHYS
		elseif typ == LuaEntityAbility.DAMAGE_TYPE_HPREMOVAL then
			return DAMAGE_HPRM
		elseif typ == LuaEntityAbility.DAMAGE_TYPE_PURE then
			return DAMAGE_PURE
		elseif typ == LuaEntityAbility.DAMAGE_TYPE_COMPOSITE then
			return	DAMAGE_COMP
		else
			return DAMAGE_UNIV
		end
	end
end		

function IsMouseOnButton(x,y,h,w)
	local mx = client.mouseScreenPosition.x
	local my = client.mouseScreenPosition.y
	return mx > x and mx <= x + w and my > y and my <= y + h
end

function GenerateSideMessage(heroName,spellName)
	local test = sideMessage:CreateMessage(200,60)
	test:AddElement(drawMgr:CreateRect(10,10,72,40,0xFFFFFFFF,drawMgr:GetTextureId("NyanUI/heroes_horizontal/"..heroName:gsub("npc_dota_hero_",""))))
	test:AddElement(drawMgr:CreateRect(85,16,62,31,0xFFFFFFFF,drawMgr:GetTextureId("NyanUI/other/arrow_usual")))
	test:AddElement(drawMgr:CreateRect(150,10,40,40,0xFFFFFFFF,drawMgr:GetTextureId("NyanUI/spellicons/"..spellName)))
end

function CanDie(target,id)
	if id ~= CDOTA_Unit_Hero_Axe and target:CanReincarnate() then
		return false
	end
	if id ~= CDOTA_Unit_Hero_Axe and target:DoesHaveModifier("modifier_dazzle_shallow_grave") then
		return false
	end
	return true
end

function NotDieFromSpell(skill,target,me)
	local za = {1,1.25,1.5,1.75}
	if not me:IsMagicDmgImmune() then
		if me:DoesHaveModifier("modifier_pugna_nether_ward_aura") then
			if me.health < me:DamageTaken(skill.manacost*(za[target:GetAbility(3).level]), DAMAGE_MAGC, target) then
				return false
			end
		end
	end
	return true
end

function NotDieFromBM(target,me,dmg)
	if not me:IsMagicDmgImmune() and target:DoesHaveModifier("modifier_item_blade_mail_reflect") and me.health > target:DamageTaken(dmg, DAMAGE_PURE, me) then
		return false
	end
	return true
end

function KillStealer(hero)
	local hId = hero.classId
	if hId == CDOTA_Unit_Hero_AncientApparition or hId == CDOTA_Unit_Hero_Batrider or hId == CDOTA_Unit_Hero_Beastmaster or hId == CDOTA_Unit_Hero_Brewmaster or hId == CDOTA_Unit_Hero_Bristleback or hId == CDOTA_Unit_Hero_ChaosKnight or hId == CDOTA_Unit_Hero_Clinkz or hId == CDOTA_Unit_Hero_DarkSeer or hId == CDOTA_Unit_Hero_Dazzle or hId == CDOTA_Unit_Hero_Disruptor or hId == CDOTA_Unit_Hero_DrowRanger or hId == CDOTA_Unit_Hero_EmberSpirit or hId == CDOTA_Unit_Hero_Enchantress or hId == CDOTA_Unit_Hero_Enigma or hId == CDOTA_Unit_Hero_FacelessVoid or hId == CDOTA_Unit_Hero_Gyrocopter or hId == CDOTA_Unit_Hero_Huskar or hId == CDOTA_Unit_Hero_Jakiro or hId == CDOTA_Unit_Hero_Juggernaut or hId == CDOTA_Unit_Hero_KeeperOfTheLight or hId == CDOTA_Unit_Hero_Kunkka or hId == CDOTA_Unit_Hero_Legion_Commander or hId == CDOTA_Unit_Hero_LoneDruid or hId == CDOTA_Unit_Hero_Lycan or hId == CDOTA_Unit_Hero_Medusa or hId == CDOTA_Unit_Hero_Meepo or hId == CDOTA_Unit_Hero_Meepo or hId == CDOTA_Unit_Hero_Meepo or hId == CDOTA_Unit_Hero_Oracle or hId == CDOTA_Unit_Hero_Phoenix or hId == CDOTA_Unit_Hero_Pudge or hId == CDOTA_Unit_Hero_Pugna or hId == CDOTA_Unit_Hero_Razor or hId == CDOTA_Unit_Hero_Riki or hId == CDOTA_Unit_Hero_SandKing or hId == CDOTA_Unit_Hero_Silencer or hId == CDOTA_Unit_Hero_Skywrath_Mage or hId == CDOTA_Unit_Hero_Skywrath_Mage or hId == CDOTA_Unit_Hero_Slardar or hId == CDOTA_Unit_Hero_Slark or hId == CDOTA_Unit_Hero_SpiritBreaker or hId == CDOTA_Unit_Hero_StormSpirit or hId == CDOTA_Unit_Hero_Techies or hId == CDOTA_Unit_Hero_TemplarAssassin or hId == CDOTA_Unit_Hero_Terrorblade or hId == CDOTA_Unit_Hero_Tiny or hId == CDOTA_Unit_Hero_Treant or hId == CDOTA_Unit_Hero_TrollWarlord or hId == CDOTA_Unit_Hero_Tusk or hId == CDOTA_Unit_Hero_Undying or hId == CDOTA_Unit_Hero_Ursa or hId == CDOTA_Unit_Hero_Venomancer or hId == CDOTA_Unit_Hero_Viper or hId == CDOTA_Unit_Hero_Warlock or hId == CDOTA_Unit_Hero_Weaver or hId == CDOTA_Unit_Hero_Wisp or hId == CDOTA_Unit_Hero_WitchDoctor or hId ==  CDOTA_Unit_Hero_AbyssalUnderlord then 
		return true
	else
		return false
	end
end

function GameClose()
	rect.visible = false
	icon.visible = false
	dmgCalc.visible = false
	hero = {}
	myhero = nil
	collectgarbage("collect")
	if reg then
		script:UnregisterEvent(Tick)
		script:UnregisterEvent(Key)
		script:RegisterEvent(EVENT_TICK,Load)
		reg = false
	end
end

script:RegisterEvent(EVENT_CLOSE,GameClose)
script:RegisterEvent(EVENT_TICK,Load)
