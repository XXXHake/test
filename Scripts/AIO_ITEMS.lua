-- hotkey - 9
-- select items - left mouse
-- support items: dragon,midas,chase,medallion,bottle
-- WIP: more items, auto-save mechanism for each, hero list for "target" items (like in rubick scripts) and support spirit bear. 

require("libs.ScriptConfig")
require("libs.Utils")

config = ScriptConfig.new()
config:SetParameter("Hotkey", "57", config.TYPE_HOTKEY)
config:Load()

local sleep = 0
local toggleKey = config.Hotkey
local activated,move = false,false
local xx,yy = 180,80
local icon = {}
local text = drawMgr:CreateText(0,0,0xFFFFFFff,"Items",drawMgr:CreateFont("manabarsFont","Arial",14,500))
text.visible = false

for i = 1,6 do
	if not icon[i] then icon[i] = {} end
	icon[i].icons = drawMgr:CreateRect(32,18,48,26,0x000000FF) icon[i].icons.visible = false
	icon[i].rect = drawMgr:CreateRect(32,18,35,28,0xFFFFFFff,true) icon[i].rect.visible = false
	icon[i].state = false
end

function Tick(tick)

	--Default Checks
	if not IsIngame() or not SleepCheck() then return end	
	local me = entityList:GetMyHero()
	if not me then return end	
	--Hero table
	local enemy = entityList:GetEntities({type=LuaEntity.TYPE_HERO,alive=true,visible=true})
	--Icons position
	if activated then
		if xx == 180 and yy == 80 then LoadGUIConfig() end
		if xx == nil and yy == nil then xx=180 yy = 80 end
		if move == true then
			xx,yy = client.mouseScreenPosition.x-20,client.mouseScreenPosition.y-25
		end
		text.x,text.y = xx+1,yy+15
	end
	
	text.visible = activated
	--Items
	for i = 1,6 do
		local item = me:GetItem(i)
		if item then
			local name = item.name:gsub("item_","")
			if string.find(name, "recipe") then
				icon[i].icons.textureId = drawMgr:GetTextureId("NyanUI/items/recipe")
			else
				icon[i].icons.textureId = drawMgr:GetTextureId("NyanUI/items/"..name)
				if icon[i].state then
					--add item and function here!
					--Dagon
					if name:sub(1,5) == "dagon" then
						Dagon(me,item,enemy)
					end
					--Medallion
					if name == "medallion_of_courage" then
						Medallion(me,item,enemy)
					end
					--Midas
					if name == "hand_of_midas" then
						Midas(me,item)
					end
					--Phase
					if name == "phase_boots" then
						PhaseBoot(me,item)
					end
					--Botle
					if name == "bottle" then
						Bottle(me,item)
					end
					---reserved ^^
					icon[i].rect.color = 0xFFFFFFff
				else
					icon[i].rect.color = 0x000000ff
				end
			end
		else
			icon[i].icons.textureId = drawMgr:GetTextureId("NyanUI/items/emptyitembg")
			icon[i].rect.color = 0x000000ff
		end
		icon[i].icons.x,icon[i].icons.y = xx,yy+38*i
		icon[i].rect.x,icon[i].rect.y = xx-1,yy+38*i-1		
		icon[i].icons.visible,icon[i].rect.visible = activated,activated
	end
	Sleep(250)
end
--Item Function
function Dagon(me,item,hero)
	local dmg = {400,500,600,700,800}
	local lvl = string.match (item.name, "%d+")
	if not lvl then lvl = 1 end
	local dmgD = dmg[lvl*1]
	if not me:IsChanneling() then
		for i,v in ipairs(hero) do
			if v.team ~=me.team and not v:IsIllusion() then
				if v.health > 0 and GetDistance2D(v,me) < item.castRange and v:CanDie() then
					if not v:DoesHaveModifier("modifier_nyx_assassin_spiked_carapace") then
						if v.health < v:DamageTaken(dmgD, DAMAGE_MAGC, me) then
							me:SafeCastAbility(item,v)
							break
						end
					end
				end
			end
		end
	end
end

function Medallion(me,item,hero)
	if not (me:IsChanneling() and me:IsInvisible()) then
		for i,v in ipairs(hero) do
			if v.team ~= me.team and v.recentDamage > 0 and not v:IsIllusion() and GetDistance2D(v,me) <= 1000 then
				me:SafeCastAbility(item,v)
				break
			end
		end
	end
end

function Midas(me,item)
	if item:CanBeCasted() and not me:IsChanneling() and not me:IsInvisible() and me:CanUseItems() then
		local creeps = entityList:GetEntities(function (v) return v.type == LuaEntity.TYPE_CREEP and v.team ~= me.team and v.alive and v.visible and v.spawned and v.health > 0 and v:GetDistance2D(me) < item.castRange + 25 end)
		if #creeps ~= 0 then
			table.sort(creeps, function (a,b) return a.health > b.health end )
			me:CastAbility(item,creeps[1])
		end
	end
end

function PhaseBoot(me,item)
	if item:CanBeCasted() and not me:IsChanneling() and not me:IsInvisible() and me:CanUseItems() then
		me:CastAbility(item)
	end
end

function Bottle(me,item)
	if item:CanBeCasted() and not me:IsChanneling() and not me:IsInvisible() and me:CanUseItems() then
		if me:DoesHaveModifier("modifier_fountain_aura_buff") and not me:DoesHaveModifier("modifier_bottle_regeneration") then
			me:CastAbility(item)
		end
	end
end
------------------
function Key(msg,code)

	if client.chat then return end

	if IsKeyDown(toggleKey) then
		activated = not activated
	end

	if activated then
		if msg == LBUTTON_UP then
			if IsMouseOnButton(xx+5,yy+15,20,50) then
				move = (not move)
				SaveGUIConfig(xx,yy)
			end			
		end
		if msg == LBUTTON_UP then
			for a = 1,6 do
				if IsMouseOnButton(xx,yy+38*a,38,38) then
					icon[a].state = (not icon[a].state)
				end
			end
		end
	end

end

function IsMouseOnButton(x,y,h,w)
	local mx = client.mouseScreenPosition.x
	local my = client.mouseScreenPosition.y
	return mx > x and mx <= x + w and my > y and my <= y + h
end

function SaveGUIConfig(xx,yy)
	local file = io.open(SCRIPT_PATH.."/config/AIO_Item_Config.txt", "w+")
	if file then
		file:write(xx.."\n"..yy)
		file:close()
	end
end

function LoadGUIConfig()
	local file = io.open(SCRIPT_PATH.."/config/AIO_Item_Config.txt", "r")
	if file then
		xx, yy = file:read("*number", "*number")
		file:close()
	end
end

function GameClose()
	text.visible = false
	for i = 1,6 do
		icon[i].icons.visible = false
		icon[i].rect.visible = false
		icon[i].state = false
	end
	activated = false 
	move = false
	collectgarbage("collect")
end

script:RegisterEvent(EVENT_CLOSE, GameClose)
script:RegisterEvent(EVENT_TICK,Tick)
script:RegisterEvent(EVENT_KEY,Key)
