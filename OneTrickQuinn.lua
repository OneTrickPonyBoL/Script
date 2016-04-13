if myHero.charName ~= "Quinn" then return end


-- Lib Downloader
if FileExist(LIB_PATH .. "/SourceLibk.lua") then
    require("SourceLibk")

else
    print_msg("Downloading SourceLibk, please don't press F9")
    DelayAction(function() DownloadFile("https://raw.githubusercontent.com/kej1191/anonym/master/Common/SourceLibk.lua".."?rand="..math.random(1,10000), LIB_PATH.."SourceLibk.lua", function () print_msg("Successfully downloaded SourceLibk. Press F9 twice.") end) end, 3) 
    return
end


-- Autoupdate
local ScriptVersion = 0.1
SimpleUpdater("[OneTrickQuinn]", ScriptVersion, "raw.github.com" , "/OneTrickPonyBoL/Script/master/OneTrickQuinn.lua" , SCRIPT_PATH .. "/Fiddle.lua" , "OneTrickPonyBoL/Script/master/OneTrickQuinn.version" ):CheckUpdate()

--Lib Shortcuts

local OrbLib = OrbWalkManager()
local STS = SimpleTS()
local DMGLib = DamageLib()
local CLib = DrawManager()
local Q, W, E, R, IGNITE

--Buffs
local PassivCheck = false
local Ultibuff = false

--Minions/Jungle
local jungleMinions = minionManager(MINION_JUNGLE, 700, myHero, MINION_SORT_HEALTH_ASC)
local enemyMinions = minionManager(MINION_ENEMY, 750, myHero,MINION_SORT_HEALTH_ASC)



--Menu 
local cfg = scriptConfig("One Trick Quinn", "OneTrickQuinn")
local ScriptVersionDisp = "0.1"
local ScriptUpdate = "13.04.2016"
local SupportedVersion = "6.7"


function OnLoad()
	
	--Spells
	
	Q = Spell(_Q, 1050)
	Q:SetSkillshot(SKILLSHOT_LINEAR, 80, 0.25, 1550, true)
	W = Spell(_W, 2100)
	E = Spell(_E, 750)
	R = Spell(_R, 700)
	--Draws
	CLib:CreateCircle(myHero, Q.range, 1, {100, 255, 0, 0}, "Draw Q range")
	CLib:CreateCircle(myHero, E.range, 1, {100, 255, 0, 0}, "Draw E range")
	

	

	--Menu
	cfg:addSubMenu("Key Binds", "Key")
    cfg.Key:addParam("combo", "Combo", SCRIPT_PARAM_ONKEYDOWN, false, string.byte(" "))
 	cfg.Key:addParam("harras", "Harras", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
 	cfg.Key:addParam("lasthit", "Lasthit", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("X"))
  	cfg.Key:addParam("laneclear", "Laneclear/Jungleclear", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("V"))
  	cfg.Key:addParam("HotKey", "Harass Toggle Key", SCRIPT_PARAM_ONKEYTOGGLE, false, string.byte('T'))

	--Target Selector
	cfg:addSubMenu("TargetSelector","TargetSelector")
		STS:AddToMenu(cfg.TargetSelector)

		--Combo
	cfg:addSubMenu("Combo", "Combo")
		cfg.Combo:addParam("Q","Use Q",SCRIPT_PARAM_ONOFF,true)
		cfg.Combo:addParam("W","Use W",SCRIPT_PARAM_ONOFF,true)
		cfg.Combo:addParam("WS","Only Use W when Enemy go in Bush",SCRIPT_PARAM_ONOFF,true)
		cfg.Combo:addParam("E","Use E",SCRIPT_PARAM_ONOFF,true)
		
		
	--Harass
	cfg:addSubMenu("Harass","Harass")
		cfg.Harass:addParam("Q", "Use Q ",SCRIPT_PARAM_ONOFF,false)
		cfg.Harass:addParam("E", "Use E ",SCRIPT_PARAM_ONOFF,true)
		cfg.Harass:addParam("minMana","Min. Mana to use Spells ",SCRIPT_PARAM_SLICE,50,1,100)
		cfg.Harass:addParam("blank","",SCRIPT_PARAM_INFO,"")
		cfg.Harass:addParam("blank2","Harass Toggle Settings",SCRIPT_PARAM_INFO,"")
		cfg.Harass:addParam("QT", "Use Q",SCRIPT_PARAM_ONOFF,false)
		cfg.Harass:addParam("ET", "Use E",SCRIPT_PARAM_ONOFF,false)
		cfg.Harass:addParam("minMana2","Min. Mana to use Spells ",SCRIPT_PARAM_SLICE,50,1,100)

		--Clear
	cfg:addSubMenu("Lane/Jungle Clear", "ClearSettings")
		cfg.ClearSettings:addParam("info","LaneClear Settings",SCRIPT_PARAM_INFO,"")
		cfg.ClearSettings:addParam("Q","Use Q in LaneClear",SCRIPT_PARAM_ONOFF,true)
		cfg.ClearSettings:addParam("info2", "Jungle Clear Settings", SCRIPT_PARAM_INFO,"")
		cfg.ClearSettings:addParam("QJ", "Use Q ",SCRIPT_PARAM_ONOFF,false)
		cfg.ClearSettings:addParam("EJ", "Use E",SCRIPT_PARAM_ONOFF,false)
		cfg.ClearSettings:addParam("minMana","Min. Mana to use Spells",SCRIPT_PARAM_SLICE,50,1,100)
		--Draws
	cfg:addSubMenu("Draw Setting", "draw")
		CLib:AddToMenu(cfg.draw)

		--Auto Settings 
	cfg:addSubMenu("Settings","SS")
	--	cfg.SS:addParam("ultbase","Auto Ult in Base", SCRIPT_PARAM_ONOFF,false)
		cfg.SS:addParam("blank1","",SCRIPT_PARAM_INFO,"")
		cfg.SS:addParam("autotrinket","Auto Buy Blue Trinket at Lvl 9 ", SCRIPT_PARAM_ONOFF,false)
		cfg.SS:addParam("blank2","",SCRIPT_PARAM_INFO,"")
		cfg.SS:addSubMenu("Interrupter","IR")
		Interrupter(cfg.SS.IR):AddCallback(function(target) self:CastE(target) end)
	--	cfg.SS:addParam("blank","",SCRIPT_PARAM_INFO,"")
		

		--Prediction for Q
		cfg.SS:addSubMenu("Q Predicion","qinfo")
		Q:AddToMenu(cfg.SS.qinfo)
		
	
	
	cfg:addParam("info1", "", SCRIPT_PARAM_INFO, "")
	cfg:addParam("info2", "Script version", SCRIPT_PARAM_INFO, ScriptVersionDisp)
	cfg:addParam("info3", "Last update", SCRIPT_PARAM_INFO, ScriptUpdate)
	cfg:addParam("info4", "Last Tested LoL Version", SCRIPT_PARAM_INFO, SupportedVersion)
	cfg:addParam("info5", "", SCRIPT_PARAM_INFO, "")
	cfg:addParam("info6", "Script developed by OneTrickPony", SCRIPT_PARAM_INFO, "")

	print_msg("Script Loaded , Have Fun Good Luck")
end


	

function OnTick()
	
	if (myHero.dead) then return end
	if InFountain() and myHero.level >= 6 and not Ultibuff and cfg.SS.ultbase then R:Cast() end
	if cfg.Key.combo then Combo() end
  	if cfg.Key.harras then Harras() end
  	if cfg.Key.laneclear then LaneClear() end
	if cfg.Key.HotKey then HarassToggle() end

  
end


function Combo()
	target = STS:GetTarget(1200)
	if(target ~= nil) then
		if PassivCheck == true then
			if OrbLib:CanAttack() then
				myHero:Attack(target)
			end
		end
		if (cfg.Combo.E and GetDistance(target) < E.range and E:IsReady() ) then E:Cast(target) end
		if (cfg.Combo.Q and GetDistance(target) < Q.range and Q:IsReady() ) then Q:Cast(target) end
		
	end
end

function Harras()
	if not CheckMana(cfg.Harras.minMana) then return end
	target = STS:GetTarget(1200)
	if(target ~= nil) then
		if PassivCheck == true then
			if OrbLib:CanAttack() then
				myHero:Attack(target)
			end
		end
		if (cfg.Harass.E and GetDistance(target) < E.range and E:IsReady() ) then E:Cast(target) end
		if (cfg.Harass.Q and GetDistance(target) < Q.range and Q:IsReady() ) then Q:Cast(target) end
		
	end
end

function LaneClear()
	if not CheckMana(cfg.ClearSettings.minMana) then return end

	local minion = GetMinion()
  	local jungle = GetJungle()
  	for _, minions in pairs(enemyMinions.objects) do
  	
	if minion > 0 then 
		if cfg.ClearSettings.Q and Q:IsReady() then
			Q:Cast(minions)
		end
	end 
	end

	if jungle > 0 then
		for _, jminions in pairs(jungleMinions.objects) do

		if cfg.ClearSettings.QJ and Q:IsReady() then
			Q:Cast(jminions)
		end
		if cfg.ClearSettings.EJ and E:IsReady() then 
			E:Cast(jminions)
		end
	end
	end



end



function HarassToggle()
	if not CheckMana(cfg.Harras.minMana2) then return end
	target = STS:GetTarget(1200)
	if(target ~= nil) then
		if(cfg.Harras.ET and GetDistance(target) < E.range and E:IsReady() ) then E:Cast(target) end
		if(cfg.Harras.QT and GetDistance(target) < Q.range and Q:IsReady() ) then Q:Cast(target) end
	end
end

function GetMinion() 
  enemyMinions:update()
  return enemyMinions.iCount
end


function GetJungle()
  jungleMinions:update()
  return jungleMinions.iCount
end

function OnUpdateBuff(unit, buff)
    
	if buff.name == "QuinnW" and unit and not unit.isMe then
		PassivCheck = true
	end

	if buff.name == "QuinnR" and unit.isMe then
		Ultibuff = true
	end

end
 
function OnRemoveBuff(unit,buff)

	if buff.name == "QuinnW" and unit and not unit.isMe then
		PassivCheck = false
	end
	
	if buff.name == "recall" and unit.isMe then
		if myHero.level >= 9 then
			if cfg.SS.autotrinket then
				BuyItem(3363)
			end
		end
	end
	if buff.name == "QuinnR" and unit.isMe then
		Ultibuff = false
	end
end
function CheckMana(mana)
  
  if not mana then mana = 100 end
  
  
  if myHero.mana / myHero.maxMana > mana / 100 then
    return true
  else 
    return false
  end
end
function print_msg(msg)
  if msg ~= nil then
    msg = tostring(msg)
    print("<font color=\"#FF2052\"><b>[OneTrick Quinn]</b></font> <font color=\"#FFFFFF\">".. msg .."</font>")
  end
end
