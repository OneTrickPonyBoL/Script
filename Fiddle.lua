require("SourceLibk")
enemyMinions = minionManager(MINION_ENEMY, 1500, player, MINION_SORT_HEALTH_ASC)
JungleMinions = minionManager(MINION_JUNGLE, 1500, player, MINION_SORT_MAXHEALTH_DEC)
local cfg = scriptConfig("Fiddlesticks", "Fiddlesticks")
local OrbLib = OrbWalkManager()
local STS = SimpleTS()
local DMGLib = DamageLib()
local CLib = DrawManager()
local Q, W, E, R, IGNITE
local Drain = false
local ScriptVersion = 0.2
SimpleUpdater("[OneTrickFiddle]", ScriptVersion, "raw.github.com" , "/OneTrickPonyBoL/Script/master/Fiddle.lua" , SCRIPT_PATH .. "/Fiddle.lua" , "OneTrickPonyBoL/Script/master/Fiddle.version" ):CheckUpdate()

local ScriptVersionDisp = "1.0"
local ScriptUpdate = "06.04.2016"
local SupportedVersion = "6.6HF"




--if FileExist(LIB_PATH .. "/SourceLibk.lua") then

   
--else
  --print_msg("Downloading SourceLibk, please don't press F9")
  --DelayAction(function() DownloadFile("https://raw.githubusercontent.com/kej1191/anonym/master/Common/SourceLibk.lua".."?rand="..math.random(1,10000), LIB_PATH.."SourceLibk.lua", function () print_msg("Successfully downloaded SourceLibk. Press F9 twice.") end) end, 3) 
 -- return;
--end

function OnLoad()

	
	--Spells
	Q = Spell(_Q, 575)
	W = Spell(_W, 575)
	E = Spell(_E, 750)
	R = Spell(_R, 800)
	
	CLib:CreateCircle(myHero, Q.range, 1, {100, 255, 0, 0}, "Draw Q range")
	CLib:CreateCircle(myHero, W.range, 1, {100, 255, 0, 0}, "Draw W range")
	CLib:CreateCircle(myHero, E.range, 1, {100, 255, 0, 0}, "Draw E range")
	CLib:CreateCircle(myHero, R.range, 1, {100, 255, 0, 0}, "Draw R range")

	
	--Menu
	

	cfg:addSubMenu("[Key Binds]", "Key")
    cfg.Key:addParam("combo", "Combo", SCRIPT_PARAM_ONKEYDOWN, false, string.byte(" "))
 	cfg.Key:addParam("harras", "Harras", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
 	cfg.Key:addParam("lasthit", "Lasthit", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("X"))
  	cfg.Key:addParam("laneclear", "Laneclear/Jungleclear", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("V"))
  	cfg.Key:addParam("HotKey", "Harass Toggle Key", SCRIPT_PARAM_ONKEYTOGGLE, false, string.byte('T'))
  	cfg.Key:addParam("Cords", "Return Cords", SCRIPT_PARAM_ONKEYDOWN, false, string.byte('K'))

	
	cfg:addSubMenu("TargetSelector","TargetSelector")
		STS:AddToMenu(cfg.TargetSelector)
	cfg:addSubMenu("Combo", "Combo")
		cfg.Combo:addParam("Q","Use Q",SCRIPT_PARAM_ONOFF,true)
		cfg.Combo:addParam("W","Use W",SCRIPT_PARAM_ONOFF,true)
		cfg.Combo:addParam("E","Use E",SCRIPT_PARAM_ONOFF,true)
		cfg.Combo:addParam("R", "Use R", SCRIPT_PARAM_ONOFF,true)
		cfg.Combo:addParam("mnChampR", "Min. Champ to use R", SCRIPT_PARAM_SLICE,3,1,5)

			    

	cfg:addSubMenu("Harass","Harass")
		cfg.Harass:addParam("Q", "Use Q ",SCRIPT_PARAM_ONOFF,false)
		cfg.Harass:addParam("W", "Use W",SCRIPT_PARAM_ONOFF,false)
		cfg.Harass:addParam("E", "Use E ",SCRIPT_PARAM_ONOFF,true)
		cfg.Harass:addParam("minMana","Min. Mana to use Spells ",SCRIPT_PARAM_SLICE,50,1,100)
	cfg:addSubMenu("Harass Toggle", "HarassT")
		cfg.HarassT:addParam("Q", "Use Q ",SCRIPT_PARAM_ONOFF,false)
		cfg.HarassT:addParam("W", "Use W",SCRIPT_PARAM_ONOFF,false)
		cfg.HarassT:addParam("E", "Use E ",SCRIPT_PARAM_ONOFF,true)
		cfg.HarassT:addParam("minMana","Min. Mana to use Spells ",SCRIPT_PARAM_SLICE,50,1,100)
		


	cfg:addSubMenu("LaneClear", "LaneClear")
		cfg.LaneClear:addParam("E","Use E in LaneClear",SCRIPT_PARAM_ONOFF,true)
		cfg.LaneClear:addParam("minMana","Min. Mana to use E",SCRIPT_PARAM_SLICE,50,1,100)
	cfg:addSubMenu("JungleClear","JungleClear")
		cfg.JungleClear:addParam("Q", "Use Q ",SCRIPT_PARAM_ONOFF,false)
		cfg.JungleClear:addParam("W", "Use W",SCRIPT_PARAM_ONOFF,true)
		cfg.JungleClear:addParam("E", "Use E ",SCRIPT_PARAM_ONOFF,true)
		cfg.JungleClear:addParam("minMana","Min. Mana to use Spells",SCRIPT_PARAM_SLICE,50,1,100)

	cfg:addSubMenu("Draw Setting", "draw")
		CLib:AddToMenu(cfg.draw)

	cfg:addSubMenu("Spell Prediction","SS")
		cfg.SS:addSubMenu("R Prediction", "R")
	--		R:AddToMenu(cfg.SS.R)
	
	
	cfg:addParam("info1", "", SCRIPT_PARAM_INFO, "")
	cfg:addParam("info2", "Script version", SCRIPT_PARAM_INFO, ScriptVersionDisp)
	cfg:addParam("info3", "Last update", SCRIPT_PARAM_INFO, ScriptUpdate)
	cfg:addParam("info4", "Last Tested LoL Version", SCRIPT_PARAM_INFO, SupportedVersion)
	cfg:addParam("info5", "", SCRIPT_PARAM_INFO, "")
	cfg:addParam("info6", "Script developed by OneTrickPony", SCRIPT_PARAM_INFO, "")



	
end
function OnDraw()
    for i = 1, myHero.buffCount do
        local tBuff = myHero:getBuff(i)
        if BuffIsValid(tBuff) then
                DrawTextA(tBuff.name,12,20,20*i+20)
        end
    end

end

function OnTick()
	if (myHero.dead) then return end

	if cfg.Key.combo then
    	Combo()
 	end
  
  	if cfg.Key.harras then
    	Harras()
  	end
  	if cfg.Key.Cords then 
  		Cords()
  	end
  
  
  
  	if cfg.Key.laneclear then
    	LaneClear()
   		JungleClear()
  	end
	if (cfg.HarassT.HotKey) then HarassToggle() end

  	
end
function Cords()
end
function Combo()
	target = STS:GetTarget(E.range)
	if(target ~= nil) then
		if(cfg.Combo.E and GetDistance(target) < E.range and E:IsReady() and not Drain ) then E:Cast(target) end
		if(cfg.Combo.Q and GetDistance(target) < Q.range and Q:IsReady() and not Drain ) then Q:Cast(target) end
		if(cfg.Combo.W and GetDistance(target) < W.range and W:IsReady() and not Q:IsReady() and not E:IsReady() ) then W:Cast(target) end
	end
end
function Harass()
	if(IsManaLow(cfg.Harass.minMana)) then return end
	target = STS:GetTarget(E.range)
	if(target ~= nil) then
		if(cfg.Harass.E and GetDistance(target) < E.range and E:IsReady() and not Drain ) then E:Cast(target) end
		if(cfg.HarassHarass.Q and GetDistance(target) < Q.range and Q:IsReady() and not Drain ) then Q:Cast(target) end
		if(cfg.Harass.W and GetDistance(target) < W.range and W:IsReady() ) then W:Cast(target) end
	end
end
function HarassT()
	if(IsManaLow(cfg.Harass.minMana)) then return end
	local target = STS:GetTarget(E.range)
	if(target ~= nil ) then
		if(cfg.HarassT.E and GetDistance(target) < E.range and E:IsReady() and not Drain ) then E:Cast(target) end
		if(cfg.HarassHarassT.Q and GetDistance(target) < Q.range and Q:IsReady() and not Drain ) then Q:Cast(target) end
		if(cfg.HarassT.W and GetDistance(target) < W.range and W:IsReady() ) then W:Cast(target) end
	end
end

function LaneClear()
	
  	
	if(IsManaLow(cfg.LaneClear.minMana)) then return end
	local target = t ~= nil and t or GetTarget(700,false,true)
	if not target then return end
	if GetDistance(target) <0 then return end
	if (cfg.LaneClear.E and E:IsReady()) then
		E:Cast(target)
	
	end
end
function JungleClear()
	
	if(IsManaLow(cfg.JungleClear.minMana)) then return end
	local target = t ~= nil and t or GetTarget(700,true,false)
	if not target then return end
	if GetDistance(target) <0 then return end
	if(cfg.JungleClear.Q and not Drain) then Q:Cast(target) end
	if(cfg.JungleClear.W and not Drain) then W:Cast(target) end
	if(cfg.JungleClear.E and not Drain) then E:Cast(target) end
end

function OnUpdateBuff(unit, buff)
    
	if buff.name=="fearmonger_marker" and unit and unit.isMe then
		Drain = true
		

	end

end
 
function OnRemoveBuff(unit,buff)

		if buff.name=="fearmonger_marker" and unit and unit.isMe then
			Drain = false
			
		end
		
end
function IsManaLow(per)
	if per == nil then return false end
	return ((myHero.mana / myHero.maxMana * 100) <= per)
end


function GetEnemyMinionTarget(range)
	enemyMinions.range = range
	enemyMinions:update()
	return enemyMinions.objects[1]
end

function GetJungleTarget(range)
	JungleMinions.range = range
	JungleMinions:update()
	return JungleMinions.objects[1]
end

local targets = {}
lastrequests = {0,0,0,0}
function GetTarget(range,jungle,minion)

	local target = nil
	if jungle then
		if lastrequests[1] > os.clock() and targets[1] and targets[1].valid and not targets[1].dead and GetDistance(targets[1]) < range then
			target = targets[1]
		else
			targets[1] = target
			lastrequests[1] = os.clock()+0.1
			target = GetJungleTarget(range)
		end
		if target then return target end
	end
	
	if minion then
		if lastrequests[2] > os.clock() and targets[2] and targets[2].valid and not targets[2].dead and GetDistance(targets[2]) < range then
			target = targets[4]
		else
			targets[2] = target
			lastrequests[2] = os.clock()+0.1
			target = GetEnemyMinionTarget(range)
		end
		if target then return target end
	end
end

