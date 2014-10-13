--
-- ���촰������Ⱦɫ���
-- By ����@˫����@ݶ����
-- ZhaiYiMing.CoM
-- 2014��5��19��05:07:02
--
local _L = MY.LoadLangPack(MY.GetAddonInfo().szRoot.."Farbnamen/lang/")
local _SUB_ADDON_FOLDER_NAME_ = "Farbnamen"
---------------------------------------------------------------
-- ���ú�����
---------------------------------------------------------------
MY_Farbnamen = MY_Farbnamen or {
    bEnabled = true,
}
RegisterCustomData("Account\\MY_Farbnamen.bEnabled")
local SZ_CONFIG_PATH = "config/PLAYER_FORCE_COLOR"
local SZ_CACHE_PATH = "cache/PLAYER_INFO/" .. (MY.Game.GetServer())
local Config_Default = {
    nMaxCache= 200,
    tForceColor  = MY.LoadLUAData(SZ_CONFIG_PATH, true) or {
        [0]  = { 255, 255, 255 },       --����
        [1]  = { 255, 178, 95  },       --����
        [2]  = { 196, 152, 255 },       --��
        [3]  = { 255, 111, 83  },       --���
        [4]  = { 89 , 224, 232 },       --����
        [5]  = { 255, 129, 176 },       --����
        [6]  = { 55 , 147, 255 },       --�嶾
        [7]  = { 121, 183, 54  },       --����
        [8]  = { 214, 249, 93  },       --�ؽ�
        [9]  = { 205, 133, 63  },       --ؤ��
        [10] = { 240, 70 , 96  },       --����
    },
}
local Config = clone(Config_Default)
local _MY_Farbnamen = {
    tForceString = {
        [0]  = _L['JiangHu'],
        [1]  = _L['ShaoLin'],
        [2]  = _L['WanHua'],
        [3]  = _L['TianCe'],
        [4]  = _L['ChunYang'],
        [5]  = _L['QiXiu'],
        [6]  = _L['WuDu'],
        [7]  = _L['TangMen'],
        [8]  = _L['CangJian'],
        [9]  = _L['GaiBang'],
        [10] = _L['MingJiao'],
    },
    tRoleType    = {
        [1] = _L['man'],
        [2] = _L['woman'],
        [5] = _L['boy'],
        [6] = _L['girl'],
    },
    tCampString  = {
        [0] = _L['ZhongLi'],
        [1] = _L['HaoQiMeng'],
        [2] = _L['ERenGu'],
    },
    tPlayerCache = {},
    aPlayerQueu = {},
}
setmetatable(_MY_Farbnamen.tForceString, { __index = function(t, k) return k end, __call = function(t, k, ...) return string.format(t[k], ...) end, })
setmetatable(_MY_Farbnamen.tRoleType,    { __index = function(t, k) return k end, __call = function(t, k, ...) return string.format(t[k], ...) end, })
setmetatable(_MY_Farbnamen.tCampString,  { __index = function(t, k) return k end, __call = function(t, k, ...) return string.format(t[k], ...) end, })
---------------------------------------------------------------
-- ���츴�ƺ�ʱ����ʾ���
---------------------------------------------------------------
-- �����������ݵ� HOOK �����ˡ�����ʱ�� ��
MY.Chat.HookChatPanel(function(h, szMsg)
    if not MY_Farbnamen.bEnabled then
        return nil
    end
    szMsg = MY_Farbnamen.Render(szMsg)
    
    return szMsg
end)
--[[ ���ŵ�����Ⱦɫ�ӿ�
    (userdata) MY_Farbnamen.Render(userdata namelink)    ����namelinkȾɫ namelink��һ������TextԪ��
    (string) MY_Farbnamen.Render(string szMsg)           ��ʽ��szMsg �������������
]]
MY_Farbnamen.Render = function(szMsg)
    if type(szMsg) == 'string' then
        -- <text>text="[���Ǹ�����]" font=10 r=255 g=255 b=255  name="namelink_4662931" eventid=515</text><text>text="˵��" font=10 r=255 g=255 b=255 </text><text>text="[����]" font=10 r=255 g=255 b=255  name="namelink_4662931" eventid=771</text><text>text="\n" font=10 r=255 g=255 b=255 </text>
        szMsg = string.gsub( szMsg, '<text>([^<]-)text="([^<]-)"([^<]-name="namelink_%d-"[^<]-)eventid=515([^<]-)</text>', function (szExtra1, szName, szExtra2, szExtra3)
            szName = string.gsub(szName, '[%[%]]', '')
            local tInfo = MY_Farbnamen.GetAusName(szName)
            if tInfo then
                szExtra1 = string.gsub(szExtra1, ' [rgb]=%d+', '')
                szExtra2 = string.gsub(szExtra2, ' [rgb]=%d+', '')
                szExtra3 = string.gsub(szExtra3, ' [rgb]=%d+', '')
                return string.format(
                    '<text>%stext="[%s]"%seventid=771 script="this.OnItemMouseEnter=function() MY_Farbnamen.ShowTip(this) end\nthis.OnItemMouseLeave=function() HideTip() end"%s r=%d g=%d b=%d</text>',
                    szExtra1, szName, szExtra2, szExtra3, tInfo.rgb[1], tInfo.rgb[2], tInfo.rgb[3]
                )
            end
        end)
    elseif type(szMsg) == 'userdata' then
        local namelink = szMsg
        local szName = string.gsub(namelink:GetText(), '[%[%]]', '')
        local tInfo = MY_Farbnamen.GetAusName(szName)
        if tInfo then
            -- ���� �ȼ�
            local szTip = string.format('%s(%d)', tInfo.szName, tInfo.nLevel)
            -- �ƺ�
            if tInfo.szTitle and #tInfo.szTitle > 0 then
                szTip = string.format('%s\n%s', szTip, tInfo.szTitle)
            end
            -- ���
            if tInfo.szTongID and #tInfo.szTongID > 0 then
                szTip = string.format('%s\n[%s]', szTip, tInfo.szTongID)
            end
            -- ���� ���� ��Ӫ
            szTip = string.format('%s\n%s��%s��%s', szTip, _MY_Farbnamen.tForceString[tInfo.dwForceID], _MY_Farbnamen.tRoleType[tInfo.nRoleType], _MY_Farbnamen.tCampString[tInfo.nCamp])
            -- ��tip��ʾ
            MY.UI(namelink):tip(szTip, MY.Const.UI.Tip.POS_TOP):color(tInfo.rgb)
        end
    end
    
    return szMsg
end
-- ��ʾTip
MY_Farbnamen.ShowTip = function(namelink)
    local x, y, w, h = 0, 0, 0, 0
    namelink = namelink or this
    if not namelink then
        return
    end
    local szName = string.gsub(namelink:GetText(), '[%[%]]', '')
    x, y = namelink:GetAbsPos()
    w, h = namelink:GetSize()
    
    local tInfo = MY_Farbnamen.GetAusName(szName)
    if tInfo then
        -- ���� �ȼ�
        local szTip = string.format('%s(%d)', tInfo.szName, tInfo.nLevel)
        -- �ƺ�
        if tInfo.szTitle and #tInfo.szTitle > 0 then
            szTip = string.format('%s\n%s', szTip, tInfo.szTitle)
        end
        -- ���
        if tInfo.szTongID and #tInfo.szTongID > 0 then
            szTip = string.format('%s\n[%s]', szTip, tInfo.szTongID)
        end
        -- ���� ���� ��Ӫ
        szTip = string.format('%s\n%s��%s��%s', szTip, _MY_Farbnamen.tForceString[tInfo.dwForceID], _MY_Farbnamen.tRoleType[tInfo.nRoleType], _MY_Farbnamen.tCampString[tInfo.nCamp])
        
        szTip = GetFormatText(szTip, 136, nil, nil, nil)
        OutputTip(szTip, 450, {x, y, w, h}, MY.Const.UI.Tip.POS_TOP)
    end
end
-- ��������ͻ
function MY_Farbnamen.DoConflict()
    if MY_Farbnamen.bEnabled and Chat and Chat.bColor then
        Chat.bColor = false
        MY.Sysmsg({_L['plugin conflict detected,duowan force color has been forced down.'], r=255, g=0, b=0},_L['MingYiPlugin - Farbnamen'])
    end
end
---------------------------------------------------------------
-- ���ݴ洢
---------------------------------------------------------------
-- ͨ��szName��ȡ��Ϣ
function MY_Farbnamen.GetAusName(szName)
    return MY_Farbnamen.GetAusID(_MY_Farbnamen.tPlayerCache[szName])
end
-- ͨ��dwID��ȡ��Ϣ
function MY_Farbnamen.GetAusID(dwID)
    MY_Farbnamen.AddAusID(dwID)
    -- deal with return data
    local result =  clone(_MY_Farbnamen.tPlayerCache[dwID])
    if result then
        result.rgb = Config.tForceColor[result.dwForceID]
    end
    return result
end
-- ����ָ��dwID�����
function MY_Farbnamen.AddAusID(dwID)
    local player = GetPlayer(dwID)
    if player and player.szName and player.szName~='' then
        local tPlayer = {
            dwID      = player.dwID,
            dwForceID = player.dwForceID,
            szName    = player.szName,
            nRoleType = player.nRoleType,
            nLevel    = player.nLevel,
            szTitle   = player.szTitle,
            nCamp     = player.nCamp,
            szTongID  = GetTongClient().ApplyGetTongName(player.dwTongID),
            dwTime    = GetCurrentTime(),
        }
        
        _MY_Farbnamen.tPlayerCache[player.dwID  ] = tPlayer
        _MY_Farbnamen.tPlayerCache[player.szName] = player.dwID
    end
end
-- �����û�����
function _MY_Farbnamen.SaveCustomData()
    local t = {}
    t.tForceColor = Config.tForceColor
    MY.Sys.SaveUserData(SZ_CONFIG_PATH, t)
end
-- �����û�����
function _MY_Farbnamen.LoadCustomData()
    local t = MY.Sys.LoadUserData(SZ_CONFIG_PATH) or {}
    if t.tForceColor then
        Config.tForceColor = t.tForceColor
    end
end
-- ��������
function MY_Farbnamen.SaveData()
    local t = {
        ['aCached']   = {}                      ,     -- ������û���
        ['nMaxCache'] = Config.nMaxCache        ,     -- ��󻺴�����
    }
    for dwID, data in pairs(_MY_Farbnamen.tPlayerCache) do
        if type(dwID)=='number' then
            table.insert(t.aCached, data)
        end
    end
    if #t.aCached > t.nMaxCache then
        table.sort(t.aCached, function(a, b) return a.dwTime < b.dwTime end)
        for i=t.nMaxCache+1, #t.aCached, 1 do
            table.remove(t.aCached)
        end
    end
    MY.SaveLUAData(SZ_CACHE_PATH, MY.Json.Encode(t))
end
-- ��������
function MY_Farbnamen.LoadData()
    -- ��ȡ�����ļ�
    local data = MY.LoadLUAData(SZ_CACHE_PATH) or {}
    -- �����Json��ʽ������ �����
    if type(data)=="string" then
        data = MY.Json.Decode(data) or {}
    end
    -- ��������
    local t = {
        ['aCached']   = data.aCached   or {} ,    -- ������û���
        ['nMaxCache'] = data.nMaxCache or 100,    -- ��󻺴�����
    }
    -- ת�ƾɰ汾����
    for i=1, #data, 1 do
        -- ���뻺���б�
        table.insert(t.aCached, data[i])
    end
    
    -- ��Ӽ��ص�����
    for _, p in ipairs(t.aCached) do
        _MY_Farbnamen.tPlayerCache[p.dwID] = p
    end
    Config.nMaxCache = t.nMaxCache or Config.nMaxCache
end
--------------------------------------------------------------
-- ����ͳ��
--------------------------------------------------------------
function MY_Farbnamen.AnalyseForceInfo()
	local t = { }
    -- ͳ�Ƹ���������
	for k, v in pairs(_MY_Farbnamen.tPlayerCache) do
		if type(v)=='table' and type(v.dwForceID)=='number' then
			t[v.dwForceID] = ( t[v.dwForceID] or 0 ) + 1
		end
	end
	-- ��tableֵ��������
	local t2, nCount = {}, 0
	for k, v in pairs(t) do
		table.insert(t2, {K = k, V = v})
        nCount = nCount + v
	end
	table.sort (t2, function(a, b) return a.V > b.V end)

    -- ���
	MY.Sysmsg({_L('%d player(s) data cached:', nCount)}, _L['Farbnamen'])
	for k, v in pairs(t2) do
		if type(v.K) == "number" then
			MY.Sysmsg({string.format("%s\t(%s)\t%d", GetForceTitle(v.K), string.format("%02d%%", 100 * (v.V / nCount)), v.V)}, '')
		end
	end
end

--------------------------------------------------------------
-- �˵�
--------------------------------------------------------------
MY_Farbnamen.GetMenu = function()
    local t = {
        szOption = _L["Farbnamen"],
        fnAction = function()
            MY_Farbnamen.bEnabled = not MY_Farbnamen.bEnabled
        end,
        bCheck = true,
        bChecked = MY_Farbnamen.bEnabled
    }
    table.insert(t, {
        szOption = _L['customize color'],
    })
    for nForce, szForce in pairs(_MY_Farbnamen.tForceString) do
        table.insert(t[#t], {
            szOption = szForce,
            rgb = Config.tForceColor[nForce],
            bColorTable = true,
            fnChangeColor = function(_,r,g,b)
                Config.tForceColor[nForce] = {r,g,b}
                _MY_Farbnamen.SaveCustomData()
            end
            
        })
    end
    table.insert(t[#t], { bDevide = true })
    table.insert(t[#t], {
        szOption = _L['load default setting'],
        fnAction = function()
            Config.tForceColor = clone(Config_Default.tForceColor)
        end,
    })
    table.insert(t, {
        szOption = _L["set max cache count"],
        fnAction = function()
            GetUserInputNumber(Config.nMaxCache, 10000, nil, function(num) Config.nMaxCache = num end, function() end, function() end)
        end,
    })
    table.insert(t, {
        szOption = _L["analyse data"],
        fnAction = MY_Farbnamen.AnalyseForceInfo,
    })
    table.insert(t, {
        szOption = _L["reset data"],
        fnAction = function()
            _MY_Farbnamen.tPlayerCache = {}
            MY.Sysmsg({_L['cache data deleted.']}, _L['Farbnamen'])
        end,
    })
    return t
end
MY.RegisterPlayerAddonMenu( 'MY_Farbenamen', MY_Farbnamen.GetMenu )
MY.RegisterTraceButtonMenu( 'MY_Farbenamen', MY_Farbnamen.GetMenu )
--------------------------------------------------------------
-- ע���¼�
--------------------------------------------------------------
MY.RegisterEvent('LOGIN_GAME', MY_Farbnamen.LoadData)
MY.RegisterEvent('PLAYER_ENTER_GAME', MY_Farbnamen.LoadData)
MY.RegisterEvent('LOGIN_GAME', _MY_Farbnamen.LoadCustomData)
MY.RegisterEvent('PLAYER_ENTER_GAME', _MY_Farbnamen.LoadCustomData)
MY.RegisterEvent('GAME_EXIT', MY_Farbnamen.SaveData)
MY.RegisterEvent('PLAYER_EXIT_GAME', MY_Farbnamen.SaveData)
MY.RegisterEvent("PLAYER_ENTER_SCENE", MY_Farbnamen.DoConflict)
MY.RegisterEvent("PLAYER_ENTER_SCENE", function(...)
    if MY_Farbnamen.bEnabled then
        local dwID = arg0
        MY.DelayCall( function() MY_Farbnamen.AddAusID(dwID) end, 500 )
    end
end)