--Credits To remembermyhentai

if myHero.charName ~= "Swain" then return end

if FileExist(LIB_PATH .. "/SimpleLib.lua") then
    require("SimpleLib")
    
else
  	print_msg("Downloading SimpleLib, please don't press F9")
    DelayAction(function() DownloadFile("https://raw.githubusercontent.com/jachicao/BoL/master/SimpleLib.lua".."?rand="..math.random(1,10000), LIB_PATH.."SimpleLib.lua", function () print_msg("Successfully downloaded SimpleLib. Press F9 twice.") end) end, 3) 
end


function ScriptMsg(msg)
  print("<font color=\"#FF1493\">[OneTrick Swain][Beta]</b></font>  <font color=\"#FFFF00\">".. msg .."</font>")
end

function ErrorMsg(msg)
  print("<font color=\"#FF1493\">[OneTrick Swain][Beta]</b></font>  <font color=\"#FF0000\">".. msg .."</font>")
end




local cfg = scriptConfig("One Trick Swain", "OneTrickSwain")
local Ulton = false


--ScriptVersion Menu
local Script_Version = "0.4"
local ScriptName = "OneTrick Swain"
local Developer = "OneTrickPony"
local LastLevelCheck = 0


function OnLoad()

	Q = _Spell({Slot = _Q, DamageName = "Q", Range = 625 , Width = 275 , Delay = 0.5, Speed = math.huge,  Type = SPELL_TYPE.CIRCULAR }):AddDraw() 
	W = _Spell({Slot = _W, DamageName = "W", Range = 900 , Width = 125, Delay = 1.1, Speed = math.huge , Type = SPELL_TYPE.CIRCULAR }):AddDraw()
	E = _Spell({Slot = _E, DamageName = "E", Range = 625 , Speed = math.huge , Type = SPELL_TYPE.TARGETTED }):AddDraw()
	R = _Spell({Slot = _R, DamageName = "R", Range = 700 , Delay = 0.1, Speed = math.huge , Type = SPELL_TYPE.SELF }):AddDraw()

	if myHero:GetSpellData(SUMMONER_1).name:find("SummonerDot") then Ignite = SUMMONER_1 elseif myHero:GetSpellData(SUMMONER_2).name:find("SummonerDot") then Ignite = SUMMONER_2 end
	
	EnemyMinions = minionManager(MINION_ENEMY, 700, myHero, MINION_SORT_HEALTH_ASC)
	JungleMinions = minionManager(MINION_JUNGLE, 750, myHero, MINION_SORT_HEALTH_DEC)

	ts = TargetSelector(TARGET_LESS_CAST_PRIORITY, 1000, DAMAGE_MAGIC, false, true)


	cfg:addSubMenu("Key Binds", "Key")
	OrbwalkManager:LoadCommonKeys(cfg.Key)
    cfg.Key:addParam("info12", "---- Other Key ----", SCRIPT_PARAM_INFO, "")
  	cfg.Key:addParam("toggle", "Harass Toogle" , SCRIPT_PARAM_ONKEYTOGGLE , false , string.byte("H"))
  	
  	cfg:addSubMenu("Combo", "c")
  		cfg.c:addParam("q","Use Q",SCRIPT_PARAM_ONOFF,true)
		cfg.c:addParam("w","Use W",SCRIPT_PARAM_ONOFF,true)
		cfg.c:addParam("e","Use E",SCRIPT_PARAM_ONOFF,true)
		cfg.c:addParam("r", "Use R", SCRIPT_PARAM_ONOFF,true)
		cfg.c:addParam("champsr", "Min. Champ to use R", SCRIPT_PARAM_SLICE,1,1,5)
		cfg.c:addParam("manar", "Min. Mana for use R", SCRIPT_PARAM_SLICE,11,1,100)

	cfg:addSubMenu("Harass","h")
		cfg.h:addParam("q","Use Q in Harass", SCRIPT_PARAM_ONOFF, true)
		cfg.h:addParam("w","Use W in Harass", SCRIPT_PARAM_ONOFF, true)
		cfg.h:addParam("e","Use E in Harass", SCRIPT_PARAM_ONOFF, true)
		cfg.h:addParam("mana", "Min Mana to use Spells ", SCRIPT_PARAM_SLICE,40,1,100,1)
		cfg.h:addParam("info","", SCRIPT_PARAM_INFO,"")

		cfg.h:addParam("info2","Toogle Settings", SCRIPT_PARAM_INFO,"")
		cfg.h:addParam("qh","Use Q",SCRIPT_PARAM_ONOFF,true)
		cfg.h:addParam("eh", "Use E", SCRIPT_PARAM_ONOFF,true)
		cfg.h:addParam("manah","Min Mana for Toggle", SCRIPT_PARAM_SLICE,40,1,100,1)

	cfg:addSubMenu("LaneClear","lc")
		cfg.lc:addParam("info","--- LaneClear Settings  ---",SCRIPT_PARAM_INFO,"")
		cfg.lc:addParam("q", "Use Q in LaneClear", SCRIPT_PARAM_ONOFF, true)
		cfg.lc:addParam("qh","only use if Hit X Minions",SCRIPT_PARAM_SLICE,3,1,5)
		cfg.lc:addParam("w", "Use W in LaneClear", SCRIPT_PARAM_ONOFF, true)
		cfg.lc:addParam("wh","only use if Hit X Minions ",SCRIPT_PARAM_SLICE,3,1,5)
		cfg.lc:addParam("e", "Use E in LaneClear", SCRIPT_PARAM_ONOFF, true)
		cfg.lc:addParam("r", "Use R in LaneClear",SCRIPT_PARAM_ONOFF,false)
		cfg.lc:addParam("mnMinions", "Min. Minons to use R", SCRIPT_PARAM_SLICE,5,1,10)
		cfg.lc:addParam("manalc", "Min Mana to use Spells ",SCRIPT_PARAM_SLICE,50,1,100,1)

		cfg.lc:addParam("info2","",SCRIPT_PARAM_INFO,"")
		cfg.lc:addParam("info3","--- JungleClear Settings---",SCRIPT_PARAM_INFO,"")
		cfg.lc:addParam("qj", "Use Q in Jungle", SCRIPT_PARAM_ONOFF, true)
		cfg.lc:addParam("wj", "Use W in Jungle", SCRIPT_PARAM_ONOFF, true)
		cfg.lc:addParam("ej", "Use E in Jungle", SCRIPT_PARAM_ONOFF, true)
		cfg.lc:addParam("rj", "Use R in Jungle", SCRIPT_PARAM_ONOFF, true)
		cfg.lc:addParam("mana","Min Mana to use Spells",SCRIPT_PARAM_SLICE,50,1,100,1)

	cfg:addSubMenu("Draws","draw")
		cfg.draw:addParam("nodraws","Disable all Draws",SCRIPT_PARAM_ONOFF,false)
		cfg.draw:addParam("showperma","Show PermaBox", SCRIPT_PARAM_ONOFF,true)
		cfg.draw:addParam("target", "Draw my Target ", SCRIPT_PARAM_ONOFF, true)
		cfg.draw:addParam("showdmg","Show Dmg on Hp Bar",SCRIPT_PARAM_ONOFF,true)
		cfg.draw:addParam("debug","Debug Mode", SCRIPT_PARAM_ONOFF,false)

	cfg:addSubMenu("Miscellaneous","ms")
		cfg.ms:addParam("autooff", "Auto Disable R", SCRIPT_PARAM_ONOFF,true)
		cfg.ms:addSubMenu("Auto Level","autolvl")
			cfg.ms.autolvl:addParam("useal","Use Auto Level",SCRIPT_PARAM_ONOFF,false)
			cfg.ms.autolvl:addParam("rota","Order for AutoLvL",SCRIPT_PARAM_LIST,5,{"Q-W-E", "Q-E-W", "W-Q-E", "W-E-Q", "E-Q-W", "E-W-Q"})

		cfg.ms:addSubMenu("Auto Buy Items","autoitems")
			cfg.ms.autoitems:addParam("buydoran","Auto Buy Dorans",SCRIPT_PARAM_ONOFF,false)
			cfg.ms.autoitems:addParam("buypot","Auto Buy Pots",SCRIPT_PARAM_ONOFF,false)
			cfg.ms.autoitems:addParam("buytrinket","Auto Buy Trinket",SCRIPT_PARAM_ONOFF,false)
			cfg.ms.autoitems:addParam("switchblue","Switch Trinket at Lvl 9",SCRIPT_PARAM_ONOFF,false)
			
		cfg.ms:addSubMenu("Skinchanger", "skin")
		if VIP_USER then SkinLoad() end

	cfg:addSubMenu("Killsteal","ks")
		cfg.ks:addParam("useks","Use KillStealer",SCRIPT_PARAM_ONOFF,true)
		cfg.ks:addParam("q","Use Q",SCRIPT_PARAM_ONOFF,true)
		cfg.ks:addParam("w","Use W",SCRIPT_PARAM_ONOFF,true)
		cfg.ks:addParam("e","Use E",SCRIPT_PARAM_ONOFF,true)
		if Ignite then cfg.ks:addParam("ignite","Use Ignite",SCRIPT_PARAM_ONOFF,true) end

	cfg:addParam("info","",SCRIPT_PARAM_INFO,"")
	cfg:addParam("info2","",SCRIPT_PARAM_INFO,"")
	cfg:addParam("info3","                        OneTrickBundle",SCRIPT_PARAM_INFO,"")
	cfg:addParam("info4","Scripter OneTrickPony",SCRIPT_PARAM_INFO,"")
	cfg:addParam("info6","ScriptVerion",SCRIPT_PARAM_INFO,Script_Version)
	cfg:addParam("info67","Last Tested Patch ",SCRIPT_PARAM_INFO,"6.9")


	if cfg.draw.showperma then
		DelayAction(function() cfg:permaShow("info3") end, 1)
		DelayAction(function() cfg.ms:permaShow("autooff") end, 1)
		DelayAction(function() cfg.ks:permaShow("useks") end, 1)
		DelayAction(function() cfg:permaShow("info") end, 1)
		DelayAction(function() cfg.ms.autolvl:permaShow("useal") end, 1)
		DelayAction(function() cfg.ms.autolvl:permaShow("rota") end, 1)
		
	end

	ScriptMsg("Successfully Loaded Version: "..Script_Version)
	DelayAction(function()AutoBuy()end, 4)
end
function OnDraw()

	if cfg.draw.nodraws then return end
	
	if target and cfg.draw.target then

		DrawCircle3D(target.x, target.y, target.z, 20, 2, ARGB(255, 255, 0, 188))
	end
	if cfg.draw.showdmg then
		DrawHPbar()
		
	end

	if cfg.draw.debug then
		for i = 1, myHero.buffCount do
        local tBuff = myHero:getBuff(i)
	       	if BuffIsValid(tBuff) then
	               DrawTextA(tBuff.name,20,20,20*i+20)
	       	end
    	end
    	
	end
end

function OnTick()
	if myHero.dead then return end

  	target = GetTarget()
  	
	if OrbwalkManager:IsCombo() then
    	Combo()
  	end
  	if OrbwalkManager:IsHarass() then
  		Harass()
  	end
  	if OrbwalkManager:IsClear() then
  		LaneClear()
  	end
 	if cfg.Key.toggle then 
 		HarassToggl()
 	end
	CheckNewLevel()
	KillSteal()
end	
function Combo()
	if GetEnemyR() == 0 and Ulton and cfg.ms.autooff then
		R:Cast()
	end
	if target ~= nil then
		if E:IsReady() and W:ValidTarget(target) and cfg.c.e then
			E:Cast(target)
		end
		if W:IsReady() and W:ValidTarget(target) and cfg.c.w then
			W:Cast(target)
		end
		if Q:IsReady() and Q:ValidTarget(target) and cfg.c.q then 
			Q:Cast(target)
		end
		if not Ulton and R:IsReady() and R:ValidTarget(target) and cfg.c.r then
			if not CheckMana(cfg.c.manar) then return end
			if GetEnemyR() >= cfg.c.champsr then 
				R:Cast(target)
			end
		end
	end	
end

function Harass()
	if not CheckMana(cfg.h.mana) then return end
	if target ~= nil then
		if cfg.h.q and Q:IsReady() and Q:ValidTarget(target) then
			Q:Cast(target)
		end
		if cfg.h.w and W:IsReady() and W:ValidTarget(target) then
			W:Cast(target)
		end
		if cfg.h.e and E:IsReady() and E:ValidTarget(target) then
			E:Cast(target)
		end
	end
end

function LaneClear()

	EnemyMinions:update()
	xMinions = EnemyMinions.iCount
	xJMinions = JungleMinions.iCount
	JungleMinions:update()
	if xMinions and xJMinions == 0 and Ulton and cfg.ms.autooff then
		CastSpell(_R)
	end


	if OrbwalkManager:GetClearMode() == "laneclear" then
		if not CheckMana(cfg.lc.manalc) then return end
		
		if cfg.lc.q and Q:IsReady() then
			Q:LaneClear({NumberOfHits = cfg.lc.qh , UseCast = true})
		end
		if cfg.lc.w and W:IsReady() then
			W:LaneClear({NumberOfHits = cfg.lc.wh , UseCast = true})
		end
		if cfg.lc.e and E:IsReady() then
			E:LaneClear({NumberOfHits = 1 , UseCast = true})
		end
		if cfg.lc.r and R:IsReady() and (xMinions >= cfg.lc.mnMinions) and not Ulton then
			R:Cast()
		end
	end
	
	if OrbwalkManager:GetClearMode() == "jungleclear" then
		if not CheckMana(cfg.lc.mana) then return end
		
		if cfg.lc.qj and Q:IsReady() then
			Q:JungleClear({UseCast = true})
		end
		if cfg.lc.wj and W:IsReady() then
			W:JungleClear({UseCast = true})
		end
		if cfg.lc.ej and E:IsReady() then
			E:JungleClear({UseCast = true})
		end
		if cfg.lc.rj and R:IsReady() and not Ulton then
			R:JungleClear({UseCast = true})
		end
	end

end

function HarassToggl()

	if not CheckMana(cfg.h.manah) then return end
	if target ~= nil then
		if cfg.h.qh and Q:IsReady() and Q:ValidTarget(target) then
			Q:Cast(target)
		end
		if cfg.h.eh and E:IsReady() and E:ValidTarget(target) then
			E:Cast(target)
		end
	end
end

function OnUpdateBuff(unit, buff)
    
	if buff.name=="SwainMetamorphism" and unit and unit.isMe then
		Ulton = true
	end

end
function OnRemoveBuff(unit,buff)

	if buff.name=="SwainMetamorphism" and unit and unit.isMe then
		Ulton = false
	end	
	if buff.name == "recall" and unit.isMe then
		if myHero.level >= 9 then
			if cfg.ms.autoitems.switchblue then
				BuyItem(3363)
			end	
		end
	end
end
function GetTarget()
	ts:update()
    return ts.target
end
function GetEnemyR()
  
  return CountEnemyHeroInRange(800)
end
function CheckMana(mana)
  
  if not mana then mana = 100 end
  
  
  if myHero.mana / myHero.maxMana > mana / 100 then
    return true
  else 
    return false
  end
end
function SkinLoad()
    cfg.ms.skin:addParam('changeSkin', 'Change Skin', SCRIPT_PARAM_ONOFF, false);
    cfg.ms.skin:setCallback('changeSkin', function(nV)
        if (nV) then
            SetSkin(myHero, cfg.ms.skin.skinID)
        else
            SetSkin(myHero, -1)
        end
    end)
    cfg.ms.skin:addParam('skinID', 'Skin', SCRIPT_PARAM_LIST, 1, {"Tyrant", "Northern Front", "Bilgewater","Classic" }) -- Here change the Numbers with Skinnames
    cfg.ms.skin:setCallback('skinID', function(nV)
        if (cfg.ms.skin.changeSkin) then
            SetSkin(myHero, nV)
        end
    end)
    
    if (cfg.ms.skin.changeSkin) then
        SetSkin(myHero, cfg.ms.skin.skinID)
    end
end
function DrawHPbar()
  for i, HPbarEnemyChamp in pairs(GetEnemyHeroes()) do
    if not HPbarEnemyChamp.dead and HPbarEnemyChamp.visible then
      local dmg = myHero:CalcDamage(HPbarEnemyChamp, myHero.totalDamage)
      if myHero:CanUseSpell(_Q) == READY and not HPbarEnemyChamp.dead then
        dmg = dmg + GetQDmg(HPbarEnemyChamp)
      end
      if myHero:CanUseSpell(_W) == READY and not HPbarEnemyChamp.dead then
      	dmg = dmg + GetEDmg(HPbarEnemyChamp)
      end
      if myHero:CanUseSpell(_E) == READY and not HPbarEnemyChamp.dead then
        dmg = dmg + GetEDmg(HPbarEnemyChamp)
      end
      if myHero:CanUseSpell(_R) == READY and not HPbarEnemyChamp.dead then
      	dmg = dmg + GetRDmg(HPbarEnemyChamp)
      end
      DrawLineHPBar(dmg, "", HPbarEnemyChamp, HPbarEnemyChamp.team)
    end
  end
end
function GetQDmg(unit)
	local Qlvl = myHero:GetSpellData(_Q).level
	if Qlvl <1 then return 0 end
	local QDmg = {100,160,220,280,340}
	local QDmgMod = 0.3
	local DmgRaw = QDmg[Qlvl] + myHero.ap * QDmgMod
	local Dmg = myHero:CalcMagicDamage(unit, DmgRaw)
	return Dmg
end
function GetWDmg(unit)
	local Wlvl = myHero:GetSpellData(_Q).level
	if Wlvl <1 then return 0 end
	local WDmg = {80,120,160,200,240}
	local WDmgMod = 0.7
	local DmgRaw = WDmg[Wlvl] + myHero.ap * WDmgMod
	local Dmg = myHero:CalcMagicDamage(unit, DmgRaw)
	return Dmg
end
function GetEDmg(unit)
	local Elvl = myHero:GetSpellData(_E).level
	if Elvl <1 then return 0 end
	local EDmg = {60,96,132,168,204}
	local EDmgMod = 0.7
	local DmgRaw = EDmg[Elvl] + myHero.ap * EDmgMod
	local Dmg = myHero:CalcMagicDamage(unit, DmgRaw)
	return Dmg
end
function GetRDmg(unit)
	local Rlvl = myHero:GetSpellData(_R).level
	if Rlvl <1 then return 0 end
	local RDmg = {50,70,90}
	local RDmgMod = 0.2
	local DmgRaw = RDmg[Rlvl] + myHero.ap * RDmgMod
	local Dmg = myHero:CalcMagicDamage(unit, DmgRaw)
	return Dmg
end
function CheckNewLevel()
    if LastLevelCheck + 250 < GetTickCount() and myHero.level < 19 then
        LastLevelCheck = GetTickCount()
        if myHero.level ~= LastHeroLevel then
            DelayAction(function() LevelUpSpell() end, 0.25)
            LastHeroLevel = myHero.level
        end
    end
end
function LevelUpSpell()
    if cfg.ms.autolvl.useal and myHero.level > 3 then
    	if cfg.ms.autolvl.rota == 1 then
    		levelSequence =  { nil,nil,nil,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3}
    		autoLevelSetSequence(levelSequence)
    		ScriptMsg("Used AutoLevel")

    	end
    	if cfg.ms.autolvl.rota == 2 then
    		levelSequence =  { nil,nil,nil,1,1,4,1,3,1,2,4,3,3,2,2,4,2,2}
    		autoLevelSetSequence(levelSequence)
    		ScriptMsg("Used AutoLevel")
    	end
    	if cfg.ms.autolvl.rota == 3 then
    		levelSequence =  { nil,nil,nil,2,2,4,2,1,2,1,4,1,1,3,3,4,3,3}
    		autoLevelSetSequence(levelSequence)
    		ScriptMsg("Used AutoLevel")
    	end
    	if cfg.ms.autolvl.rota == 4 then
    		levelSequence =  { nil,nil,nil,2,2,4,2,3,2,3,4,3,3,1,1,4,1,1}
    		autoLevelSetSequence(levelSequence)
    		ScriptMsg("Used AutoLevel")
    	end
    	if cfg.ms.autolvl.rota == 5 then
    		levelSequence =  { nil,nil,nil,3,3,4,3,1,3,1,4,1,1,2,2,4,2,2}
    		autoLevelSetSequence(levelSequence)
    		ScriptMsg("Used AutoLevel")
    	end
    	if cfg.ms.autolvl.rota == 6 then
    		levelSequence =  { nil,nil,nil,3,3,4,3,2,3,2,4,2,2,1,1,4,1,1}
    		autoLevelSetSequence(levelSequence)
    		ScriptMsg("Used AutoLevel")
    	end
    end
end
function DrawLineHPBar(damage, text, unit, enemyteam)
  if unit.dead or not unit.visible then return end
  local p = WorldToScreen(D3DXVECTOR3(unit.x, unit.y, unit.z))
  if not OnScreen(p.x, p.y) then return end
  local thedmg = 0
  local line = 2
  local linePosA  = {x = 0, y = 0 }
  local linePosB  = {x = 0, y = 0 }
  local TextPos   = {x = 0, y = 0 }

  if damage >= unit.health then
    thedmg = unit.health - 1
    text = "KILLABLE!"
  else
    thedmg = damage
    text = "Possible Damage"
  end

  thedmg = math.round(thedmg)

  local StartPos, EndPos = GetHPBarPos(unit)
  local Real_X = StartPos.x + 24
  local Offs_X = (Real_X + ((unit.health - thedmg) / unit.maxHealth) * (EndPos.x - StartPos.x - 2))
  if Offs_X < Real_X then Offs_X = Real_X end 
  local mytrans = 350 - math.round(255*((unit.health-thedmg)/unit.maxHealth))
  if mytrans >= 255 then mytrans=254 end
  local my_bluepart = math.round(400*((unit.health-thedmg)/unit.maxHealth))
  if my_bluepart >= 255 then my_bluepart=254 end

  if enemyteam then
    linePosA.x = Offs_X-150
    linePosA.y = (StartPos.y-(30+(line*15)))    
    linePosB.x = Offs_X-150
    linePosB.y = (StartPos.y-10)
    TextPos.x = Offs_X-148
    TextPos.y = (StartPos.y-(30+(line*15)))
  else
    linePosA.x = Offs_X-125
    linePosA.y = (StartPos.y-(30+(line*15)))    
    linePosB.x = Offs_X-125
    linePosB.y = (StartPos.y-15)

    TextPos.x = Offs_X-122
    TextPos.y = (StartPos.y-(30+(line*15)))
  end

  DrawLine(linePosA.x, linePosA.y, linePosB.x, linePosB.y , 2, ARGB(mytrans, 255, my_bluepart, 0))
  DrawText(tostring(thedmg).." "..tostring(text), 15, TextPos.x, TextPos.y , ARGB(mytrans, 255, my_bluepart, 0))
end
function KillSteal()
	for _, unit in pairs(GetEnemyHeroes()) do
		if GetDistance(unit) < 900 and cfg.ks.useks and not unit.dead then
				health = unit.health
				if Q:IsReady() and health < GetQDmg(unit) and cfg.ks.q and Q:ValidTarget(unit) then
					Q:Cast(unit)
				elseif W:IsReady() and health < GetWDmg(unit) and cfg.ks.w and W:ValidTarget(unit) then
					W:Cast(unit)
				elseif E:IsReady() and health < GetEDmg(unit) and cfg.ks.e and E:ValidTarget(unit) then
					E:Cast(unit)
				elseif Ignite and myHero:CanUseSpell(Ignite) == READY and health < (50 + 20 * myHero.level) and cfg.ks.ignite and ValidTarget(unit, 600) then
					CastSpell(Ignite, unit)
				end
			end
		end
	--
end
function AutoBuy()
  
  if GetGameTimer() < 60 then
    if cfg.ms.autoitems.buydoran then
      BuyItem(1056)
    end
    if cfg.ms.autoitems.buypot then
      BuyItem(2003)
    end
    if cfg.ms.autoitems.buytrinket then
      BuyItem(3340)
    end
  end
end
