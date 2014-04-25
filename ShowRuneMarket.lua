
filename = ""
MapLeft = -8000
MapTop = 7350
MapRight = 7500
MapBottom = -7200
MapWidth = math.abs(MapLeft - MapRight)
MapHeight = math.abs(MapBottom - MapTop)

minimapRune = drawMgr:CreateRect(0,0,20,20,0x000000ff) 
minimapRune.visible = false

xx = 220
yy = 220
  
function Tick()

	if not client.connected or client.loading or client.console then return end
	
	local me = entityList:GetMyHero()
	
	if not me then return end

	local runes = entityList:GetEntities({classId=CDOTA_Item_Rune})
	if #runes == 0 then
			if minimapRune.visible == true then
			minimapRune.visible = false				
			end
		return
	end
	
		local rune = runes[1]
		local runeType = rune.runeType
		filename = ""		

		if runeType == 0 then
				filename = "doubledamage"
		elseif runeType == 1 then
				filename = "haste"
		elseif runeType == 2 then
				filename = "illusion"
		elseif runeType == 3 then
				filename = "invis"
		elseif runeType == 4 then
				filename = "regen"
		end
	
	if minimapRune.visible == false then
        local runeMinimap = MapToMinimap(rune)
		minimapRune.visible = true
        minimapRune.x = runeMinimap.x-20/2
		minimapRune.y = runeMinimap.y-20/2
		minimapRune.textureId = drawMgr:GetTextureId("NyanUI/minirunes/"..filename)         
    end	

end

function MapToMinimap(x, y)

	if y == nil then		
		if x.position then
			_x = x.position.x - MapLeft
			_y = x.position.y - MapBottom
		else
			return {x = -640, y = -640}
		end
	else
		_x = x - MapLeft
		_y = y - MapBottom
	end
	
	MinimapMapScaleX = xx / MapWidth
	MinimapMapScaleY = yy / MapHeight
	
	local scaledX = math.min(math.max(_x * MinimapMapScaleX, 0), xx)
	local scaledY = math.min(math.max(_y * MinimapMapScaleY, 0), yy)
	
	local screenX = 9 + scaledX
	local screenY = client.screenSize.y - scaledY - 9
	
	return Vector2D(math.floor(screenX),math.floor(screenY))
	
end

function GetDistance2D(a,b)
    return math.sqrt(math.pow(a.position.x-b.position.x,2)+math.pow(a.position.y-b.position.y,2))
end

function GameClose()
	collectgarbage("collect")
	minimapRune.visible = false
end

script:RegisterEvent(EVENT_CLOSE,GameClose)
script:RegisterEvent(EVENT_TICK,Tick)
