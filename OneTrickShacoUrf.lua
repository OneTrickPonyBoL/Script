if myHero.charName ~= "Shaco" then return end

---//==================================================\\---
--|| > Script Infos                                     ||--
---\\==================================================//---

local Script_Version = "0.1"
local ScriptName = "OneTrick Shaco"
local Developer = "OneTrickPony"
local LastLevelCheck = 0

---//==================================================\\---
--|| > Simple Lib                                       ||--
---\\==================================================//---
function Simple()
    local r = _Required()
    r:Add({Name = "SimpleLib", Url = "raw.githubusercontent.com/jachicao/BoL/master/SimpleLib.lua"})
    r:Check()
    if r:IsDownloading() then return end
    
end
---//==================================================\\---
--|| > Msg Functions                                    ||--
---\\==================================================//---
function ScriptMsg(msg)
  print("<font color=\"#FF1493\"><b>[OneTrick Shaco][Beta]</b></font>  <font color=\"#FFFF00\">".. msg .."</font>")
end

function ErrorMsg(msg)
  print("<font color=\"#FF1493\"><b>[OneTrick Shaco][Error]</b></font>  <font color=\"#FF0000\">".. msg .."</font>")
end
function OnLoad()
	Simple()
	cfg = scriptConfig("OneTrick Shaco", "OneTrickShaco")
	DelayAction(function() _arrangePriorities() end, 10)
	TS = TargetSelector(TARGET_LESS_CAST_PRIORITY, 1000, DAMAGE_MAGIC)
	Minions = minionManager(MINION_ENEMY, 1000, myHero,MINION_SORT_HEALTH_ASC)
	Q = _Spell({Slot = _Q, DamageName = "Q", Range = 400, Delay = 0.25 , Collision = false, Aoe = false, Type = SPELL_TYPE.CIRCULAR}):AddDraw() 
	W = _Spell({Slot = _W, DamageName = "W", Range = 425, Width = 300, Delay = 0.5, Collision = false, Aoe = true, Type = SPELL_TYPE.CIRCULAR}):AddDraw() 
	E = _Spell({Slot = _E, DamageName = "E", Range = 625, Width = 0, Delay = 0, Collision = false, Aoe = false, Type = SPELL_TYPE.TARGETTED}):AddDraw() 
	R = _Spell({Slot = _R, DamageName = "R", Range = 400, Width = 0, Delay = 0.25, Speed = 1000, Collision = false, Aoe = true, Type = SPELL_TYPE.SELF}) 
	Ignite = _Spell({Slot = FindSummonerSlot("summonerdot"), DamageName = "IGNITE", Range = 600, Type = SPELL_TYPE.TARGETTED})

    cfg:addTS(TS)

	cfg:addSubMenu("Key Binds", "Key")
	    OrbwalkManager:LoadCommonKeys(cfg.Key)

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
	
		cfg.draw:addParam("debug","Debug Mode", SCRIPT_PARAM_ONOFF,false)
		cfg.draw:addParam("nodraws","Disable all Draws",SCRIPT_PARAM_ONOFF,false)

	cfg:addSubMenu("Miscellaneous","ms")
		cfg.ms:addSubMenu("Auto Level","autolvl")
			cfg.ms.autolvl:addParam("useal","Use Auto Level",SCRIPT_PARAM_ONOFF,false)
			cfg.ms.autolvl:addParam("rota","Order for AutoLvL",SCRIPT_PARAM_LIST,5,{"Q-W-E", "Q-E-W", "W-Q-E", "W-E-Q", "E-Q-W", "E-W-Q"})
		cfg.ms:addSubMenu("Evade","ev")
			_Evader(cfg.ms.ev):CheckCC():AddCallback(function(target) Q:Cast(target)end)

		cfg.ms:addSubMenu("Gapclose", "gab")
			cfg.ms.gab:addSubMenu("Use W To Interrupt Gapclosers", "W")
			_Interrupter(cfg.ms.gab.W):CheckGapcloserSpells():AddCallback(function(target) W:Cast(target) end)

	cfg:addParam("info","",SCRIPT_PARAM_INFO,"")
	cfg:addParam("info2","",SCRIPT_PARAM_INFO,"")
	cfg:addParam("info3","                         OneTrickShaco",SCRIPT_PARAM_INFO,"")
	cfg:addParam("info4","Scripter OneTrickPony",SCRIPT_PARAM_INFO,"")
	cfg:addParam("info6","ScriptVerion",SCRIPT_PARAM_INFO,Script_Version)
	cfg:addParam("info67","Last Tested Patch ",SCRIPT_PARAM_INFO,"6.10")


	ScriptMsg("Successfully Loaded Version: "..Script_Version)
end
function OnDraw()
	if cfg.draw.nodraws then return end
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
function Combo()
	if E:IsReady() then
		E:Cast(target)
	end
end
function OnTick()
	if myHero.dead then return end
  	target = GetTarget()
  	
  	
	if OrbwalkManager:IsCombo() then
    	Combo()
  	end
	CheckNewLevel()

	
	if cfg.draw.tgd.resetsettings then
    	cfg.draw.tgd.resetsettings = false
    	cfg.draw.tgd.targetsize = 20
    	cfg.draw.tgd.TargetX = 50
    	cfg.draw.tgd.TargetY = 50
    	ScriptMsg("Target Draw Settings are reset")
    end
end	
function GetTarget()
	TS:update()
	return TS.target
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