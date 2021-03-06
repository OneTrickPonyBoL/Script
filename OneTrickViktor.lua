local AUTOUPDATES = true
local version = 0.4
if myHero.charName ~= "Viktor" then return end


---//==================================================\\---
--|| > Bol Tools                                        ||--
---\\==================================================//---
assert(load(Base64Decode("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"), nil, "bt", _ENV))()
TrackerLoad("t55ReAPeSkNRXc3I")



---//==================================================\\---
--|| > Simple Lib                                       ||--
---\\==================================================//---

function CheckUpdate()
    if AUTOUPDATES then
        local ToUpdate = {}
        ToUpdate.LocalVersion = version
        ToUpdate.VersionPath = "raw.githubusercontent.com/OneTrickPonyBoL/Script/master/version/viktor.version"
        ToUpdate.ScriptPath = "raw.githubusercontent.com/OneTrickPonyBoL/Script/master/OneTrickViktor.lua"
        ToUpdate.SavePath = SCRIPT_PATH.._ENV.FILE_NAME
        ToUpdate.CallbackUpdate = function(NewVersion,OldVersion) ScriptMsg("Updated to ["..NewVersion.."] Please reload with 2x F9") end
        ToUpdate.CallbackNoUpdate = function(OldVersion) ScriptMsg("No Updates Found") end
        ToUpdate.CallbackNewVersion = function(NewVersion) ScriptMsg("New Version found ["..NewVersion.."] Please Wait..." ) end
        ToUpdate.CallbackError = function(NewVersion) ErrorMsg("Error while downloading.") end
        _ScriptUpdate(ToUpdate)
    end
end
---//==================================================\\---
--|| > Msg Functions                                    ||--
---\\==================================================//---
function ScriptMsg(msg)
  print("<b><font color=\"#FF1493\">[OneTrick Viktor][Beta]</b></font>  <font color=\"#FFFF00\">".. msg .."</font>")
end

function ErrorMsg(msg)
  print("<b><font color=\"#FF1493\">[OneTrick Viktor][Error]</b></font>  <font color=\"#FF0000\">".. msg .."</font>")
end




---//==================================================\\---
--|| > Table                                    ||--
---\\==================================================//--

local myEnemyTable = GetEnemyHeroes()
---//==================================================\\---
--|| > Script Infos                                     ||--
---\\==================================================//---

local Script_Version = "0.4"
local ScriptName = "OneTrick Viktor"
local Developer = "OneTrickPony"
local LastLevelCheck = 0
local cfg = scriptConfig("One Trick Viktor", "OneTrickViktor")
local ebuff = false

---//==================================================\\---
--|| > Draw Functions                                   ||--
---\\==================================================//---

function GetHPBarPos(enemy)
    enemy.barData = {PercentageOffset = {x = -0.05, y = 0}}
    local barPos = GetUnitHPBarPos(enemy)
    local barPosOffset = GetUnitHPBarOffset(enemy)
    local barOffset = { x = enemy.barData.PercentageOffset.x, y = enemy.barData.PercentageOffset.y }
    local barPosPercentageOffset = { x = enemy.barData.PercentageOffset.x, y = enemy.barData.PercentageOffset.y }
    local BarPosOffsetX = -50
    local BarPosOffsetY = 46
    local CorrectionY = 39
    local StartHpPos = 31
    barPos.x = math.floor(barPos.x + (barPosOffset.x - 0.5 + barPosPercentageOffset.x) * BarPosOffsetX + StartHpPos)
    barPos.y = math.floor(barPos.y + (barPosOffset.y - 0.5 + barPosPercentageOffset.y) * BarPosOffsetY + CorrectionY)
    local StartPos = Vector(barPos.x , barPos.y, 0)
    local EndPos = Vector(barPos.x + 108 , barPos.y , 0)    
    return Vector(StartPos.x, StartPos.y, 0), Vector(EndPos.x, EndPos.y, 0)
end
function DrawLifeBar()
	for i, unit in pairs(myEnemyTable) do
		if ValidTarget(unit) and GetDistance(unit) <= 3000 then
			local Center = GetUnitHPBarPos(unit)
			if Center.x > -100 and Center.x < WINDOW_W+100 and Center.y > -100 and Center.y < WINDOW_H+100 then
				local off = GetUnitHPBarOffset(unit)
				local y=Center.y + (off.y * 53) + 2
				local xOff = ({['AniviaEgg'] = -0.1,['Darius'] = -0.05,['Renekton'] = -0.05,['Sion'] = -0.05,['Thresh'] = -0.03,})[unit.charName]
				local x = Center.x + ((xOff or 0) * 140) - 66
				dmg = unit.health - GetComboDmg(unit)
				local mytrans = 350 - math.round(255*((unit.health-dmg)/unit.maxHealth))
				if mytrans >= 255 then mytrans=254 end
				local my_bluepart = math.round(400*((unit.health-dmg)/unit.maxHealth))
				if my_bluepart >= 255 then my_bluepart=254 end
				DrawLine(x + ((unit.health /unit.maxHealth) * 104),y, x+(((dmg > 0 and dmg or 0) / unit.maxHealth) * 104),y,9, GetDistance(unit) < 3000 and  ARGB(mytrans, 255, my_bluepart, 0))
			end
		end
	end
end
function DrawDebug()
	for i = 1, myHero.buffCount do
    local tBuff = myHero:getBuff(i)
	if BuffIsValid(tBuff) then
		DrawTextA(tBuff.name,20,20,20*i+20)
	end
    end
end
function FixOnScreenTarget()
	if target then
		DrawTextA("Fokus :  "..target.charName, cfg.draw.tgd.targetsize , cfg.draw.tgd.TargetX, cfg.draw.tgd.TargetY)
		
	end
end
function OnMouseTarget()
	if target then
		myMouse = GetCursorPos()
		DrawTextA("Fokus :  "..target.charName, cfg.draw.tgd.targetsize , myMouse.x-20, myMouse.y-20)
	end
end
function DrawPermashow()

	if cfg.draw.showperma then
		DelayAction(function() cfg:permaShow("info3") end, 1)
		DelayAction(function() cfg.c:permaShow("r") end, 1)
		DelayAction(function() cfg.ks:permaShow("useks") end, 1)
		DelayAction(function() cfg:permaShow("info") end, 1)
		DelayAction(function() cfg.ms.autolvl:permaShow("useal") end, 1)
		DelayAction(function() cfg.ms.autolvl:permaShow("rota") end, 1)
	end
end
---//==================================================\\---
--|| > Damage Calculation                               ||--
---\\==================================================//---

function GetQDmg(unit)
	local Qlvl = myHero:GetSpellData(_Q).level
	if Qlvl <1 then return 0 end
	local QDmg = {60,80,100,120,140}
	local QDmgMod = 0.4
	local DmgRaw = QDmg[Qlvl] + myHero.ap * QDmgMod 
	local Dmg = myHero:CalcMagicDamage(unit,DmgRaw)
	return Dmg
end
function GetQ2Dmg(unit)
	local Qlvl = myHero:GetSpellData(_Q).level
	if Qlvl <1 then return 0 end
	local QDmg = {20,40,60,80,100}
	local QDmgMod = {AP = 0.4 , AD = 1.0}
	local DmgRaw = QDmg[Qlvl] + (myHero.ap * QDmgMod.AP) + (myHero.damage * QDmgMod.AD) 
	local Dmg = myHero:CalcMagicDamage(unit, DmgRaw)
	return Dmg
end
function GetWDmg(unit)
	Dmg = 0
	return Dmg
end
function GetEDmg(unit)
	local Elvl = myHero:GetSpellData(_E).level
	if Elvl <1 then return 0 end
	local EDmg = {70,110,150,190,230}
	local EDmgMod = 0.5
	local DmgRaw = EDmg[Elvl] + myHero.ap * EDmgMod
	local Dmg = myHero:CalcMagicDamage(unit, DmgRaw)
	return Dmg
end
function GetE2Dmg(unit)
	local Elvl = myHero:GetSpellData(_E).level
	if Elvl <1 then return 0 end
	if ebuff == false then return 0 end
	local EDmg = {20,60,100,140,180}
	local EDmgMod = 0.7
	local DmgRaw = EDmg[Elvl] + myHero.ap * EDmgMod
	local Dmg = myHero:CalcMagicDamage(unit, DmgRaw)
	return Dmg
end     
function GetRDmg(unit)
	local Rlvl = myHero:GetSpellData(_R).level
	if Rlvl <1 then return 0 end
	local RDmg = {100,175,250}
	local RDmgMod = 0.5
	local RDmgSec = {150,250,350}
	local RDmgSecMod = 0.6
	local DmgRaw1 = RDmg[Rlvl] + myHero.ap * RDmgMod
	local DmgRaw2 = (RDmgSec[Rlvl] + myHero.ap * RDmgSecMod)*3
	local AllDMG = DmgRaw1 + DmgRaw2 
	local Dmg = myHero:CalcMagicDamage(unit, AllDMG)
	return Dmg
end
function GetComboDmg(unit)
	local dmg = myHero:CalcDamage(unit, myHero.totalDamage)
    if Q:IsReady() then
    	dmg = dmg + GetQDmg(unit) + GetQ2Dmg(unit)
    end
   	if E:IsReady() then
        dmg = dmg + GetEDmg(unit) + GetE2Dmg(unit)
    end
    if R:IsReady() then
    	dmg = dmg + GetRDmg(unit)
    end
    if cfg.c.usekill then
    	dmg = (dmg/100) * (100 - cfg.c.Killableover) 
    end

    return dmg
end
function GetQEDmg(unit)
	local dmg = myHero:CalcDamage(unit, myHero.totalDamage)
    if Q:IsReady() then
    	dmg = dmg + GetQDmg(unit) + GetQ2Dmg(unit)
    end
   	if E:IsReady() then
        dmg = dmg + GetEDmg(unit) + GetE2Dmg(unit)
    end
    if cfg.c.usekill then
    	dmg = (dmg/100) * (100 - cfg.c.Killableover) 
    end
    return dmg
end
---//==================================================\\---
--|| > Basic Function                                   ||--
---\\==================================================//---



function OnLoad()
	local r = _Required()
    r:Add({Name = "SimpleLib", Url = "raw.githubusercontent.com/jachicao/BoL/master/SimpleLib.lua"})
    r:Check()
    if r:IsDownloading() then return end
   
    DelayAction(function() CheckUpdate() end, 5)
	Variables()
	LoadMenu()
	FillTable()
	DrawPermashow()
	DelayAction(function()AutoBuy()end, 4)

end
function OnWndMsg(key , msg)
	
end
function OnUpdateBuff(unit, buff)
    
	if buff.name=="viktoreaug" and unit and unit.isMe then
		ebuff = true
	
	elseif buff.name=="viktorweaug" and unit and unit.isMe then
		ebuff = true
	
	elseif buff.name=="viktorqweaug" and unit and unit.isMe then
		ebuff = true
	end
end
function OnRemoveBuff(unit,buff)

	if buff.name == "recall" and unit.isMe then
		if myHero.level >= 9 then
			if cfg.ms.autoitems.switchblue then
				BuyItem(3363)
			end	
		end
	end
end
function OnDraw()


	if cfg.draw.nodraws then return end
	
	
	if cfg.draw.showdmg then
		DrawLifeBar()
		
	end
	if target and cfg.draw.tgd.target then
		DrawCircle3D(target.x, target.y, target.z, cfg.draw.tgd.circleradius, cfg.draw.tgd.circlewidth , ARGB(table.unpack(cfg.draw.tgd.circlecolor)))
	end
	if target and cfg.draw.tgd.targettext then
		if cfg.draw.tgd.targettype == 1 then
			FixOnScreenTarget()
		elseif cfg.draw.tgd.targettype == 2 then
			OnMouseTarget()
		end
	end

	
	if cfg.draw.debug then
		DrawDebug()

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
	Autozhonya()
	if cfg.Key.r then
		ForceR()
	end
	if cfg.draw.tgd.resetsettings then
    	cfg.draw.tgd.resetsettings = false
    	cfg.draw.tgd.targetsize = 20
    	cfg.draw.tgd.TargetX = 50
    	cfg.draw.tgd.TargetY = 50
    	ScriptMsg("Target Draw Settings are reset")
    end
end	
---//==================================================\\---
--|| >  Feature Function                                ||--
---\\==================================================//---

function SkinLoad()
    cfg.ms.skin:addParam('changeSkin', 'Change Skin', SCRIPT_PARAM_ONOFF, false);
    cfg.ms.skin:setCallback('changeSkin', function(nV)
        if (nV) then
            SetSkin(myHero, cfg.ms.skin.skinID)
        else
            SetSkin(myHero, -1)
        end
    end)
    cfg.ms.skin:addParam('skinID', 'Skin', SCRIPT_PARAM_LIST, 1, {"Creator", "Full Machine", "Prototype", "Classic" }) -- Here change the Numbers with Skinnames
    cfg.ms.skin:setCallback('skinID', function(nV)
        if (cfg.ms.skin.changeSkin) then
            SetSkin(myHero, nV)
        end
    end)
    
    if (cfg.ms.skin.changeSkin) then
        SetSkin(myHero, cfg.ms.skin.skinID)
    end
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
function KillSteal()
	for _, unit in pairs(GetEnemyHeroes()) do
		if GetDistance(unit) < 900 and cfg.ks.useks and not unit.dead then
				health = unit.health
				if Q:IsReady() and health < GetQDmg(unit) and cfg.ks.q and Q:ValidTarget(unit) then
					Q:Cast(unit)
				elseif E:IsReady() and health < GetEDmg(unit) and cfg.ks.e and E:ValidTarget(unit) then
					CastE(unit)
				elseif Ignite and myHero:CanUseSpell(Ignite) == READY and health < (50 + 20 * myHero.level) and cfg.ks.ignite and ValidTarget(unit, 600) then
					CastSpell(Ignite, unit)
				end
			end
		end
end
function Autozhonya()
	if cfg.ms.item.zhonya then
		for _ = ITEM_1, ITEM_7 do
			if myHero.health <= (myHero.maxHealth * cfg.ms.item.zhp / 100) and ( myHero:CanUseSpell(_) == 0 and myHero:GetSpellData(_).name == "ZhonyasHourglass" )then 
				CastSpell(_)
			end
		end
	end
end
---//==================================================\\---
--|| >  Mode Function´s                                 ||--
---\\==================================================//---

function Combo()
	
	
	
	if E:IsReady() and target ~= nil and E:ValidTarget(target) and cfg.c.e then
		CastE(target)
	end
	if W:IsReady() and target ~= nil and W:ValidTarget(target) and cfg.c.w then
		W:Cast(target)
	end
	if Q:IsReady() and target ~= nil and Q:ValidTarget(target) and cfg.c.q then 
			Q:Cast(target)
	end
	if R:IsReady() and target  ~= nil and R:ValidTarget(target) and cfg.c.r and cfg.c.killwcombo then
 		RLogicKillCombo(target)
 	end
 	if R:IsReady() and target  ~= nil and R:ValidTarget(target) and cfg.c.r and cfg.c.usehitx then
 		RLogicHitX()
 	end	
end
function Harass()
	if not CheckMana(cfg.h.mana) then return end
	
	if E:IsReady() and target ~= nil and E:ValidTarget(target) and cfg.h.e then
		CastE(target)
	end
	if W:IsReady() and target ~= nil and W:ValidTarget(target) and cfg.h.w then
		W:Cast(target)
	end
	if Q:IsReady() and target ~= nil and Q:ValidTarget(target) and cfg.h.q then 
			Q:Cast(target)
	end
end
function LaneClear()

	EnemyMinions:update()
	xMinions = EnemyMinions.iCount
	xJMinions = JungleMinions.iCount
	JungleMinions:update()
	


	if OrbwalkManager:GetClearMode() == "laneclear" then
		if not CheckMana(cfg.lc.manalc) then return end
		
		if cfg.lc.q and Q:IsReady() then
			Q:LaneClear({NumberOfHits = 1 , UseCast = true})
		end
		if cfg.lc.e and E:IsReady() then
			E:LaneClear({NumberOfHits = cfg.lc.mnMinions , UseCast = true})
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
---//==================================================\\---
--|| >  Variables                                       ||--
---\\==================================================//---

function Variables()

	Q = _Spell({Slot = _Q, DamageName = "Q", Range = 600, Width = 1, Delay = 0, Speed = 2000, Collision = false, Aoe = false, Type = SPELL_TYPE.TARGETTED}):AddDraw() 
	W = _Spell({Slot = _W, DamageName = "W", Range = 700, Width = 125, Delay = 0.5, Speed = 750, Collision = false, Aoe = true, Type = SPELL_TYPE.CIRCULAR}):AddDraw() 
	E = _Spell({Slot = _E, DamageName = "E", Range = 1200, Width = 180, Delay = 0, Speed = 1350, Collision = false, Aoe = false, Type = SPELL_TYPE.LINEAR}):AddDraw() 
	R = _Spell({Slot = _R, DamageName = "R", Range =700, Width = 0, Delay = 0.25, Speed = 1000, Collision = false, Aoe = true, Type = SPELL_TYPE.CIRCULAR}):AddDraw() 
	if myHero:GetSpellData(SUMMONER_1).name:find("SummonerDot") then Ignite = SUMMONER_1 elseif myHero:GetSpellData(SUMMONER_2).name:find("SummonerDot") then Ignite = SUMMONER_2 end
	
	EnemyMinions = minionManager(MINION_ENEMY, 700, myHero, MINION_SORT_HEALTH_ASC)
	JungleMinions = minionManager(MINION_JUNGLE, 750, myHero, MINION_SORT_HEALTH_DEC)
	DelayAction(function() _arrangePriorities() end, 10)
	ts = TargetSelector(TARGET_LESS_CAST_PRIORITY, 1500, DAMAGE_MAGIC, false, true)
	
	
	
end
function LoadMenu()
	cfg:addTS(ts)
	cfg:addSubMenu("Key Binds", "Key")
	OrbwalkManager:LoadCommonKeys(cfg.Key)
    cfg.Key:addParam("info12", "---- Other Key ----", SCRIPT_PARAM_INFO, "")
  	cfg.Key:addParam("toggle", "Harass Toogle" , SCRIPT_PARAM_ONKEYTOGGLE , false , string.byte("H"))
  	cfg.Key:addParam("r","Force R ",SCRIPT_PARAM_ONKEYDOWN, false , string.byte("R"))
  	
  	cfg:addSubMenu("Combo", "c")
  		cfg.c:addParam("q","Use Q",SCRIPT_PARAM_ONOFF,true)
		cfg.c:addParam("w","Use W",SCRIPT_PARAM_ONOFF,true)
		cfg.c:addParam("e","Use E",SCRIPT_PARAM_ONOFF,true)
		cfg.c:addParam("r", "Use R", SCRIPT_PARAM_ONOFF,true)
		cfg.c:addParam("rinfobla","",SCRIPT_PARAM_INFO,"")
		cfg.c:addParam("rinfo","----- R Settings -----", SCRIPT_PARAM_INFO,"")
		cfg.c:addParam("usehitx","Use Hit X to Cast R",SCRIPT_PARAM_ONOFF,true)
		cfg.c:addParam("hitx","Enemys to Hit",SCRIPT_PARAM_SLICE,2,1,5)
		cfg.c:addParam("info","",SCRIPT_PARAM_INFO,"")
		cfg.c:addParam("killwcombo","Use if Combo can Kill",SCRIPT_PARAM_ONOFF,true)
		cfg.c:addParam("inafo","",SCRIPT_PARAM_INFO,"")
		cfg.c:addParam("usekill", "Use Overkill", SCRIPT_PARAM_ONOFF,true)
		cfg.c:addParam("Killableover","Overkill % for Dmg Predict..",SCRIPT_PARAM_SLICE,10,0,20)

	cfg:addSubMenu("Harass","h")
		cfg.h:addParam("q","Use Q in Harass", SCRIPT_PARAM_ONOFF, true)
		cfg.h:addParam("e","Use E in Harass", SCRIPT_PARAM_ONOFF, true)
		cfg.h:addParam("mana", "Min Mana to use Spells ", SCRIPT_PARAM_SLICE,40,1,100,1)
		cfg.h:addParam("info","", SCRIPT_PARAM_INFO,"")

		cfg.h:addParam("info2","Toogle Settings", SCRIPT_PARAM_INFO,"")
		cfg.h:addParam("qh","Use Q",SCRIPT_PARAM_ONOFF,true)
		cfg.h:addParam("eh", "Use E", SCRIPT_PARAM_ONOFF,true)
		cfg.h:addParam("manah","Min Mana for Toggle", SCRIPT_PARAM_SLICE,40,1,100,1)

	cfg:addSubMenu("LastHit","lt")
		cfg.lt:addParam("q","Use Q", SCRIPT_PARAM_ONOFF, true)
		cfg.lt:addParam("qlogic","Q Logic", SCRIPT_PARAM_LIST,1,{"Smart" ,"Always"})
		cfg.lt:addParam("mana", "Min Mana to use Spells ", SCRIPT_PARAM_SLICE,40,1,100,1)

	cfg:addSubMenu("LaneClear","lc")
		cfg.lc:addParam("info","--- LaneClear Settings  ---",SCRIPT_PARAM_INFO,"")
		cfg.lc:addParam("q", "Use Q in LaneClear", SCRIPT_PARAM_ONOFF, true)
		cfg.lc:addParam("ifna","ECast in LaneClear is not very Good fix coming soon",SCRIPT_PARAM_INFO,"")
		cfg.lc:addParam("e", "Use E in LaneClear", SCRIPT_PARAM_ONOFF, false)
		cfg.lc:addParam("mnMinions", "Min. Minons to use E", SCRIPT_PARAM_SLICE,3,1,10)
		cfg.lc:addParam("manalc", "Min Mana to use Spells ",SCRIPT_PARAM_SLICE,50,1,100,1)

		cfg.lc:addParam("info2","",SCRIPT_PARAM_INFO,"")
		cfg.lc:addParam("info3","--- JungleClear Settings---",SCRIPT_PARAM_INFO,"")
		cfg.lc:addParam("qj", "Use Q in Jungle", SCRIPT_PARAM_ONOFF, true)
		cfg.lc:addParam("wj", "Use W in Jungle", SCRIPT_PARAM_ONOFF, false)
		cfg.lc:addParam("ej", "Use E in Jungle", SCRIPT_PARAM_ONOFF, true)
		cfg.lc:addParam("mana","Min Mana to use Spells",SCRIPT_PARAM_SLICE,50,1,100,1)

	cfg:addSubMenu("Draws","draw")
		cfg.draw:addSubMenu("Target Draw Settings","tgd")
			cfg.draw.tgd:addParam("target", "Draw my Target with Circle ", SCRIPT_PARAM_ONOFF, true)
			cfg.draw.tgd:addParam("circlecolor","Circle Color ",SCRIPT_PARAM_COLOR,{255, 255, 255, 255})
			cfg.draw.tgd:addParam("circleradius","Circle Radius", SCRIPT_PARAM_SLICE,70,30,100)
			cfg.draw.tgd:addParam("circlewidth","Circle Width",SCRIPT_PARAM_SLICE,3,1,15)
			cfg.draw.tgd:addParam("targettext", "Draw my Target as Text ", SCRIPT_PARAM_ONOFF, true)
			cfg.draw.tgd:addParam("targettype", "Text Position = ", SCRIPT_PARAM_LIST, 1, {"Fix on Screen","On Mouse"})
			cfg.draw.tgd:addParam("targetsize","Text Size",SCRIPT_PARAM_SLICE,25,1,65)
			cfg.draw.tgd:addParam("TargetY", "Vertical Position of the Text", SCRIPT_PARAM_SLICE, 50, 0, 1000,20)
			cfg.draw.tgd:addParam("TargetX", "Horizontal Position of the Text", SCRIPT_PARAM_SLICE, 50, 0, 1500,20)
			cfg.draw.tgd:addParam("targetcolor","Text Color ",SCRIPT_PARAM_COLOR,{255, 255, 255, 255})
			cfg.draw.tgd:addParam("resetsettings","Set Positions to default",SCRIPT_PARAM_ONOFF,false)

		cfg.draw:addParam("showdmg","Show Dmg on Hp Bar",SCRIPT_PARAM_ONOFF,true)
		cfg.draw:addParam("showperma","Show PermaBox", SCRIPT_PARAM_ONOFF,true)
		
		cfg.draw:addParam("debug","Debug Mode", SCRIPT_PARAM_ONOFF,false)
		cfg.draw:addParam("nodraws","Disable all Draws",SCRIPT_PARAM_ONOFF,false)

	cfg:addSubMenu("Miscellaneous","ms")
		cfg.ms:addSubMenu("Items","item")
			cfg.ms.item:addParam("zhonya","Use zhonya",SCRIPT_PARAM_ONOFF,true)
			cfg.ms.item:addParam("zhp","on X Hp",SCRIPT_PARAM_SLICE,10,1,100)
		cfg.ms:addSubMenu("Auto Level","autolvl")
			cfg.ms.autolvl:addParam("useal","Use Auto Level",SCRIPT_PARAM_ONOFF,false)
			cfg.ms.autolvl:addParam("rota","Order for AutoLvL",SCRIPT_PARAM_LIST,5,{"Q-W-E", "Q-E-W", "W-Q-E", "W-E-Q", "E-Q-W", "E-W-Q"})

		cfg.ms:addSubMenu("Auto Buy Items","autoitems")
			cfg.ms.autoitems:addParam("buydoran","Auto Buy Dorans",SCRIPT_PARAM_ONOFF,true)
			cfg.ms.autoitems:addParam("buypot","Auto Buy Pots",SCRIPT_PARAM_ONOFF,true)
			cfg.ms.autoitems:addParam("buytrinket","Auto Buy Trinket",SCRIPT_PARAM_ONOFF,true)
			cfg.ms.autoitems:addParam("switchblue","Switch Trinket at Lvl 9",SCRIPT_PARAM_ONOFF,true)
			
		

		cfg.ms:addSubMenu("Skinchanger", "skin")
		if VIP_USER then SkinLoad() end

	cfg:addSubMenu("Killsteal","ks")
		cfg.ks:addParam("useks","Use Killsteal",SCRIPT_PARAM_ONOFF,true)
		cfg.ks:addParam("q","Use Q",SCRIPT_PARAM_ONOFF,true)
		cfg.ks:addParam("e","Use E",SCRIPT_PARAM_ONOFF,true)
		cfg.ks:addParam("r","Use R",SCRIPT_PARAM_ONOFF,true)
		if Ignite then cfg.ks:addParam("ignite","Use Ignite",SCRIPT_PARAM_ONOFF,true) end

		cfg.ms:addSubMenu("Interrupts","inter")
				cfg.ms.inter:addSubMenu("Use W To Interrupt Channeling Spells", "W")
	 			cfg.ms.inter:addSubMenu("Use R To Interrupt Channeling Spells", "R")
	 			_Interrupter(cfg.ms.inter.W):CheckChannelingSpells():AddCallback(function(target) W:Cast(target) end)
	 			_Interrupter(cfg.ms.inter.R):CheckChannelingSpells():AddCallback(function(target) R:Cast(target) end)
	 	cfg.ms:addSubMenu("Gapclose", "gab")
	 			cfg.ms.gab:addSubMenu("Use W To Interrupt Gapclosers", "W")
	 			_Interrupter(cfg.ms.gab.W):CheckGapcloserSpells():AddCallback(function(target) W:Cast(target) end)
	cfg:addParam("info","",SCRIPT_PARAM_INFO,"")
	cfg:addParam("info2","",SCRIPT_PARAM_INFO,"")
	cfg:addParam("info3","                         OneTrickViktor",SCRIPT_PARAM_INFO,"")
	cfg:addParam("info4","Scripter OneTrickPony",SCRIPT_PARAM_INFO,"")
	cfg:addParam("info6","ScriptVerion",SCRIPT_PARAM_INFO,Script_Version)
	cfg:addParam("info67","Last Tested Patch ",SCRIPT_PARAM_INFO,"6.10")
end
function FillTable()
	Champ = { }
	for i, enemy in pairs(myEnemyTable) do
        Champ[i] = enemy.charName
    end

end
---//==================================================\\---
--|| >  Spell Logic                                     ||--
---\\==================================================//---

function RLogicKillCombo(unit)
	local health = unit.health
	if health ~= nil and (health <= GetQEDmg(unit)) then
		RLogicNoR()
	elseif health ~= nil and (health <= GetComboDmg(unit)) then
		R:Cast(unit)
	end		
end
function RLogicHitX()
	local CastPosition , WillHit , NumberOfHits = Prediction:GetPrediction(target,{Delay = 0.25 , Width = 140, Speed = 2400, Range = 700,Type = SPELL_TYPE.CIRCULAR ,Collision = false , Aoe = true})
	if CastPosition and WillHit and (NumberOfHits >= cfg.c.hitx) then
		CastSpell(_R,CastPosition.x,CastPosition.z)
	end
end
function CastE(unit)
	local CastPosition , WillHit , NumberOfHits = Prediction:GetPrediction(unit, {Range = 1200, Width = 180, Delay = 0, Speed = 1350, Collision = false, Aoe = false, Type = SPELL_TYPE.LINEAR})
	if CastPosition and WillHit then 
		CastSpell3(_E, D3DXVECTOR3(CastPosition.x, 0, CastPosition.z), D3DXVECTOR3(CastPosition.x, 0, CastPosition.z))
	end
end
function RLogicNoR()
end
function ForceR()
	if target ~= nil and R:ValidTarget(target) then
		R:Cast(target)
	end
end
---//==================================================\\---
--|| >  Other Shit                                      ||--
---\\==================================================//---

function GetTarget()
	ts:update()
	return ts.target
end
function CheckMana(mana)
  
  if not mana then mana = 100 end
  
  
  if myHero.mana / myHero.maxMana > mana / 100 then
    return true
  else 
    return false
  end
end














class "_Required"
function _Required:__init()
    self.requirements = {}
    self.downloading = {}
    return self
end

function _Required:Add(t)
    assert(t and type(t) == "table", "_Required: table is invalid!")
    local name = t.Name
    assert(name and type(name) == "string", "_Required: name is invalid!")
    local url = t.Url
    assert(url and type(url) == "string", "_Required: url is invalid!")
    local extension = t.Extension ~= nil and t.Extension or "lua"
    local usehttps = t.UseHttps ~= nil and t.UseHttps or true
    table.insert(self.requirements, {Name = name, Url = url, Extension = extension, UseHttps = usehttps})
end

function _Required:Check()
    for i, tab in pairs(self.requirements) do
        local name = tab.Name
        local url = tab.Url
        local extension = tab.Extension
        local usehttps = tab.UseHttps
        if not FileExist(LIB_PATH..name.."."..extension) then
            print("Downloading a required library called "..name.. ". Please wait...")
            local d = _Downloader(tab)
            table.insert(self.downloading, d)
        end
    end
    
    if #self.downloading > 0 then
        for i = 1, #self.downloading, 1 do 
            local d = self.downloading[i]
            AddTickCallback(function() d:Download() end)
        end
        self:CheckDownloads()
    else
        for i, tab in pairs(self.requirements) do
            local name = tab.Name
            local url = tab.Url
            local extension = tab.Extension
            local usehttps = tab.UseHttps
            if FileExist(LIB_PATH..name.."."..extension) and extension == "lua" then
                require(name)
            end
        end
    end
end

function _Required:CheckDownloads()
    if #self.downloading == 0 then 
        print("Required libraries downloaded. Please reload with 2x F9.")
    else
        for i = 1, #self.downloading, 1 do
            local d = self.downloading[i]
            if d.GotScript then
                table.remove(self.downloading, i)
                break
            end
        end
        DelayAction(function() self:CheckDownloads() end, 2) 
    end 
end

function _Required:IsDownloading()
    return self.downloading ~= nil and #self.downloading > 0 or false
end

class "_Downloader"
function _Downloader:__init(t)
    local name = t.Name
    local url = t.Url
    local extension = t.Extension ~= nil and t.Extension or "lua"
    local usehttps = t.UseHttps ~= nil and t.UseHttps or true
    self.SavePath = LIB_PATH..name.."."..extension
    self.ScriptPath = '/BoL/TCPUpdater/GetScript'..(usehttps and '5' or '6')..'.php?script='..self:Base64Encode(url)..'&rand='..math.random(99999999)
    self:CreateSocket(self.ScriptPath)
    self.DownloadStatus = 'Connect to Server'
    self.GotScript = false
end

function _Downloader:CreateSocket(url)
    if not self.LuaSocket then
        self.LuaSocket = require("socket")
    else
        self.Socket:close()
        self.Socket = nil
        self.Size = nil
        self.RecvStarted = false
    end
    self.Socket = self.LuaSocket.tcp()
    if not self.Socket then
        print('Socket Error')
    else
        self.Socket:settimeout(0, 'b')
        self.Socket:settimeout(99999999, 't')
        self.Socket:connect('sx-bol.eu', 80)
        self.Url = url
        self.Started = false
        self.LastPrint = ""
        self.File = ""
    end
end

function _Downloader:Download()
    if self.GotScript then return end
    self.Receive, self.Status, self.Snipped = self.Socket:receive(1024)
    if self.Status == 'timeout' and not self.Started then
        self.Started = true
        self.Socket:send("GET "..self.Url.." HTTP/1.1\r\nHost: sx-bol.eu\r\n\r\n")
    end
    if (self.Receive or (#self.Snipped > 0)) and not self.RecvStarted then
        self.RecvStarted = true
        self.DownloadStatus = 'Downloading Script (0%)'
    end

    self.File = self.File .. (self.Receive or self.Snipped)
    if self.File:find('</si'..'ze>') then
        if not self.Size then
            self.Size = tonumber(self.File:sub(self.File:find('<si'..'ze>')+6,self.File:find('</si'..'ze>')-1))
        end
        if self.File:find('<scr'..'ipt>') then
            local _,ScriptFind = self.File:find('<scr'..'ipt>')
            local ScriptEnd = self.File:find('</scr'..'ipt>')
            if ScriptEnd then ScriptEnd = ScriptEnd - 1 end
            local DownloadedSize = self.File:sub(ScriptFind+1,ScriptEnd or -1):len()
            self.DownloadStatus = 'Downloading Script ('..math.round(100/self.Size*DownloadedSize,2)..'%)'
        end
    end
    if self.File:find('</scr'..'ipt>') then
        self.DownloadStatus = 'Downloading Script (100%)'
        local a,b = self.File:find('\r\n\r\n')
        self.File = self.File:sub(a,-1)
        self.NewFile = ''
        for line,content in ipairs(self.File:split('\n')) do
            if content:len() > 5 then
                self.NewFile = self.NewFile .. content
            end
        end
        local HeaderEnd, ContentStart = self.NewFile:find('<sc'..'ript>')
        local ContentEnd, _ = self.NewFile:find('</scr'..'ipt>')
        if not ContentStart or not ContentEnd then
            if self.CallbackError and type(self.CallbackError) == 'function' then
                self.CallbackError()
            end
        else
            local newf = self.NewFile:sub(ContentStart+1,ContentEnd-1)
            local newf = newf:gsub('\r','')
            if newf:len() ~= self.Size then
                if self.CallbackError and type(self.CallbackError) == 'function' then
                    self.CallbackError()
                end
                return
            end
            local newf = Base64Decode(newf)
            if type(load(newf)) ~= 'function' then
                if self.CallbackError and type(self.CallbackError) == 'function' then
                    self.CallbackError()
                end
            else
                local f = io.open(self.SavePath,"w+b")
                f:write(newf)
                f:close()
                if self.CallbackUpdate and type(self.CallbackUpdate) == 'function' then
                    self.CallbackUpdate(self.OnlineVersion,self.LocalVersion)
                end
            end
        end
        self.GotScript = true
    end
end

function _Downloader:Base64Encode(data)
    local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    return ((data:gsub('.', function(x)
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end
