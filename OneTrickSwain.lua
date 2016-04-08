if myHero.charName ~= "Swain" then return end




--FileUpdater
if FileExist(LIB_PATH .. "/SourceLibk.lua") then
    require("SourceLibk")

else
    print_msg("Downloading SourceLibk, please don't press F9")
    DelayAction(function() DownloadFile("https://raw.githubusercontent.com/kej1191/anonym/master/Common/SourceLibk.lua".."?rand="..math.random(1,10000), LIB_PATH.."SourceLibk.lua", function () print_msg("Successfully downloaded SourceLibk. Press F9 twice.") end) end, 3) 
    return
end




local cfg = scriptConfig("Swain", "Swain")
local OrbLib = OrbWalkManager()
local STS = SimpleTS()
local CLib = DrawManager()
local Q, W, E, R, IGNITE
local Ulton = false
local ScriptVersion = 0.2
local jungleMinions = minionManager(MINION_JUNGLE, 700, myHero, MINION_SORT_HEALTH_ASC)
local enemyMinions = minionManager(MINION_ENEMY, 750, myHero,MINION_SORT_HEALTH_ASC)
--ScriptVersion Menu
local ScriptVersionDisp = "0.2"
local ScriptUpdate = "08.04.2016"
local SupportedVersion = "6.7"

SimpleUpdater("[OneTrickSwain]", ScriptVersion, "raw.github.com" , "/OneTrickPonyBoL/Script/master/OneTrickSwain.lua" , SCRIPT_PATH .. "/OneTrickSwain.lua" , "OneTrickPonyBoL/Script/master/OneTrickSwain.version" ):CheckUpdate()


function OnLoad()


	
	--Spells
	Q = Spell(_Q, 625)
	W = Spell(_W, 900)
	W:SetSkillshot(SKILLSHOT_CIRCULAR, 125, 0.850, math.huge)
	E = Spell(_E, 750)
	R = Spell(_R, 700)
	

	DrawQ = CLib:CreateCircle(myHero, Q.range, 1, {100, 255, 0, 0}, "Draw Q range")
	DrawW = CLib:CreateCircle(myHero, W.range, 1, {100, 255, 0, 0}, "Draw W range")
	DrawE = CLib:CreateCircle(myHero, E.range, 1, {100, 255, 0, 0}, "Draw E range")
	DrawR = CLib:CreateCircle(myHero, R.range, 1, {100, 255, 0, 0}, "Draw R range")


	cfg:addSubMenu("Key Binds", "Key")
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
		cfg.Combo:addParam("mnManaR", "Min. Mana for use R", SCRIPT_PARAM_SLICE,15,1,100)

			    

	cfg:addSubMenu("Harras","Harras")
		cfg.Harras:addParam("info1","Harras Settings",SCRIPT_PARAM_INFO,"")
		cfg.Harras:addParam("Q", "Use Q ",SCRIPT_PARAM_ONOFF,false)
		cfg.Harras:addParam("W", "Use W",SCRIPT_PARAM_ONOFF,false)
		cfg.Harras:addParam("E", "Use E ",SCRIPT_PARAM_ONOFF,true)
		cfg.Harras:addParam("minMana","Min. Mana to use Spells ",SCRIPT_PARAM_SLICE,50,1,100)

		cfg.Harras:addParam("info2","Harras Toggle Settings",SCRIPT_PARAM_INFO,"")
		cfg.Harras:addParam("QH", "Use Q ",SCRIPT_PARAM_ONOFF,false)
		cfg.Harras:addParam("WH", "Use W",SCRIPT_PARAM_ONOFF,false)
		cfg.Harras:addParam("EH", "Use E ",SCRIPT_PARAM_ONOFF,true)
		cfg.Harras:addParam("minManaH","Min. Mana to use Spells ",SCRIPT_PARAM_SLICE,50,1,100)
		


	cfg:addSubMenu("Clear", "Clear")
		cfg.Clear:addParam("info1","Laneclear Settings",SCRIPT_PARAM_INFO,"")
		cfg.Clear:addParam("W","Use W in LaneClear",SCRIPT_PARAM_ONOFF,false)
		cfg.Clear:addParam("R","Use R in LaneClear", SCRIPT_PARAM_ONOFF,false)
		cfg.Clear:addParam("minMana","Min. Mana to use Spells",SCRIPT_PARAM_SLICE,50,1,100)
		cfg.Clear:addParam("mnMinions", "Min. Minons to use R", SCRIPT_PARAM_SLICE,5,1,10)
		cfg.Clear:addParam("info3","",SCRIPT_PARAM_INFO,"")
		cfg.Clear:addParam("info2","Jungle Settings",SCRIPT_PARAM_INFO,"")
		cfg.Clear:addParam("QJ", "Use Q ",SCRIPT_PARAM_ONOFF,false)
		cfg.Clear:addParam("WJ", "Use W",SCRIPT_PARAM_ONOFF,true)
		cfg.Clear:addParam("EJ", "Use E ",SCRIPT_PARAM_ONOFF,true)
		cfg.Clear:addParam("RJ", "Use R", SCRIPT_PARAM_ONOFF,false)
		cfg.Clear:addParam("minManaJ","Min. Mana to use Spells",SCRIPT_PARAM_SLICE,50,1,100)

	cfg:addSubMenu("Draw Setting", "draw")
		CLib:AddToMenu(cfg.draw)

	cfg:addSubMenu("Auto Setting","auto")
		cfg.auto:addParam("autooff", "Auto Disable R if no1 in Range", SCRIPT_PARAM_ONOFF,true)
		cfg.auto:addParam("autozon", "Auto Zhonias", SCRIPT_PARAM_ONOFF, false)
		cfg.auto:addParam("autozonhp","Min Hp for Zhonias", SCRIPT_PARAM_SLICE,30,1,100)

	cfg:addParam("info1", "", SCRIPT_PARAM_INFO, "")
	cfg:addParam("info2", "Script version", SCRIPT_PARAM_INFO, ScriptVersionDisp)
	cfg:addParam("info3", "Last update", SCRIPT_PARAM_INFO, ScriptUpdate)
	cfg:addParam("info4", "Last Tested LoL Version", SCRIPT_PARAM_INFO, SupportedVersion)
	cfg:addParam("info5", "", SCRIPT_PARAM_INFO, "")
	cfg:addParam("info6", "Script developed by OneTrickPony", SCRIPT_PARAM_INFO, "")

	cfg:addSubMenu("Settings","SS")
		cfg.SS:addSubMenu("W Predicion","winfo")
			Q:AddToMenu(cfg.SS.winfo)
	DelayAction(function() print_msg("Lastset version (v".. ScriptVersion ..") loaded!") end, 2)
end
function OnDraw()
end

function OnTick()


	if (myHero.dead) then return end

	if cfg.Key.combo then
    	Combo()
 	end
  
  	if cfg.Key.harras then
    	Harras()
  	end
  	
  
  
  
  	if cfg.Key.laneclear then
    	Clear()
  	end
	if (cfg.Key.HotKey) then HarassToggle() end

  	
end	
function Combo()
	target = STS:GetTarget(W.range)
	if GetEnemyR() == 0 and Ulton and cfg.auto.autooff then
		R:Cast() 
	end
	if(target ~= nil) then
		
		if(cfg.Combo.E and GetDistance(target) < E.range and E:IsReady() ) then E:Cast(target) end
		if(cfg.Combo.Q and GetDistance(target) < Q.range and Q:IsReady() ) then Q:Cast(target) end
		if(cfg.Combo.W and GetDistance(target) < W.range and W:IsReady() ) then W:Cast(target) end
		if(cfg.Combo.R and CountEnemyHeroInRange(700) >= cfg.Combo.mnChampR and not Ulton and R:IsReady() and CheckMana(cfg.Combo.mnManaR)) then R:Cast(target) end
	end

end

function Harras()
	if not CheckMana(cfg.Harras.minMana) then return end
	target = STS:GetTarget(W.range)
	if(target ~= nil) then
		if(cfg.Harras.E and GetDistance(target) < E.range and E:IsReady() ) then E:Cast(target) end
		if(cfg.Harras.Q and GetDistance(target) < Q.range and Q:IsReady() ) then Q:Cast(target) end
		if(cfg.Harras.W and GetDistance(target) < W.range and W:IsReady() ) then W:Cast(target) end
	end
end

function Clear()
	if not CheckMana(cfg.Clear.minMana) then return end

	local minion = GetMinion()
  	local jungle = GetJungle()
  	for _, minions in pairs(enemyMinions.objects) do
  	if jungle and minion == 0 and Ulton then
  		R:Cast()
  	end
	if minion > 0 then 
		if cfg.Clear.W and W:IsReady() then
			W:Cast(minions)
		end
		if cfg.Clear.R and R:IsReady() and minion >= cfg.Clear.mnMinions and not Ulton then 
			R:Cast(minions)
		end
	end 
	end
	if jungle > 0 then
		if not CheckMana(cfg.Clear.minManaJ) then return end
		for _, jminions in pairs(jungleMinions.objects) do

		if cfg.Clear.QJ and Q:IsReady() then
			Q:Cast(jminions)
		end
		if cfg.Clear.WJ and W:IsReady() then
			W:Cast(jminions)
		end
		if cfg.Clear.EJ and E:IsReady() then 
			E:Cast(jminions)
		end
		if cfg.Clear.RJ and R:IsReady() and not Ulton then
			R:Cast(jminions)
		end
	end
	end
end

function HarassToggle()
	if not CheckMana(cfg.Harras.minManaH) then return end
	target = STS:GetTarget(W.range)
	if(target ~= nil) then
		if(cfg.Harras.EH and GetDistance(target) < E.range and E:IsReady() ) then E:Cast(target) end
		if(cfg.Harras.QH and GetDistance(target) < Q.range and Q:IsReady() ) then Q:Cast(target) end
		if(cfg.Harras.WH and GetDistance(target) < W.range and W:IsReady() ) then W:Cast(target) end
	end
end


--Check Ulti
function OnUpdateBuff(unit, buff)
    
	if buff.name=="SwainMetamorphism" and unit and unit.isMe then
		Ulton = true
		
	end

end
 
function OnRemoveBuff(unit,buff)

	if buff.name=="SwainMetamorphism" and unit and unit.isMe then
		Ulton = false
			

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



function GetEnemyR()
  
  return CountEnemyHeroInRange(700)
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
    print("<font color=\"#79E886\"><b>[OneTrick Swain]</b></font> <font color=\"#FFFFFF\">".. msg .."</font>")
  end
end
