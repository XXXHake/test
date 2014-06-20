require("libs.Utils")

local key = string.byte("1")
local stage = 0
local sleep = nil
local remnants = {}

function Key(msg,code)

    if msg ~= KEY_UP or code ~= key or client.chat or not client.connected or client.loading or client.console then	return end

	local me = entityList:GetMyHero() if not me then return end

	if me.classId ~= CDOTA_Unit_Hero_EarthSpirit then
		script:Disable()
	elseif not start then
		sleep = nil
		start = true
		script:RegisterEvent(EVENT_TICK,Combo)
		script:RegisterEvent(EVENT_TICK,Track)
	else
		sleep,start = nil
		stage = 0
		script:UnregisterEvent(Combo)
	end

end

function Combo()

	local me = entityList:GetMyHero()
	local remnant = me:GetAbility(4)
	local grip = me:GetAbility(3)
	local roll = me:GetAbility(2)
	local smash = me:GetAbility(1)
	
	local stunned = entityList:GetEntities(function (ent) return ent.type == LuaEntity.TYPE_HERO and ent:DoesHaveModifier("modifier_stunned") == true end)[1]

	if me:CanCast() then
		if stage == 0 then			
			if me.activity == LuaEntityNPC.ACTIVITY_MOVE then
				me:Stop()
				sleep = GetTick() + client.latency + 25
			end	
			stage = 1
		elseif stage == 1 then
			if remnant:CanBeCasted() and smash:CanBeCasted() then
				local t_ = client.mousePosition
				me:CastAbility(remnant,(t_ - me.position) * 150 / GetDistance2D(t_,me) + me.position,false)
				me:CastAbility(smash,(t_ - me.position) * 150 / GetDistance2D(t_,me) + me.position,true)	
				sleep = GetTick() + 1000
				stage = 2
			end
		elseif stage == 2 and stunned and grip:CanBeCasted() and GetDistance2D(stunned,me) < grip.castRange then
			local last = Last()
			me:CastAbility(grip,last.position)
			stage = 3
			sleep = GetTick() + 500
		elseif stage == 3 and roll:CanBeCasted() and stunned and stunned:DoesHaveModifier("modifier_earth_spirit_boulder_smash_silence") then			
			me:CastAbility(roll,stunned.position)
			stage = 0
			start = nil
			script:UnregisterEvent(Combo)
		end			
	end
	
	if sleep and GetTick() > sleep then
		sleep,start = nil
		stage = 0
		script:UnregisterEvent(Combo)
	end
	
end

function Last()
	local remn = entityList:GetEntities({classId = CDOTA_Unit_Earth_Spirit_Stone})
	if #remn > 0 then
		table.sort(remn, function(a,b) return remnants[a.handle]>remnants[b.handle] end)
		return remn[1]
	end
end

function Track()
	if not SleepCheck() then return end Sleep(200)
	local remn = entityList:GetEntities({classId = CDOTA_Unit_Earth_Spirit_Stone})
	for i,v in ipairs(remn) do
		if not remnants[v.handle] then
			remnants[v.handle] = client.totalGameTime
		end
	end
end

function GameClose()
	stage = 0
	sleep,start = nil,nil
	remnants = {}	
end

script:RegisterEvent(EVENT_CLOSE,GameClose)
script:RegisterEvent(EVENT_KEY,Key)
