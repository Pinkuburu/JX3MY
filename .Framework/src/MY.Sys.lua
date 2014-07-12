---------------------------------
-- �������
-- by������@˫����@׷����Ӱ
-- ref: �����������Դ�� @haimanchajian.com
---------------------------------
-----------------------------------------------
-- ���غ����ͱ���
-----------------------------------------------
MY = MY or {}
MY.Sys = MY.Sys or {}
local _Cache, _L = {}, MY.LoadLangPack()

--[[ ��ȡ��Ϸ����
]]
MY.Sys.GetLang = function()
    local _, _, lang = GetVersion()
    return lang
end
MY.GetLang = MY.Sys.GetLang

--[[
-- Save & Load Lua Data
#######################################################################################################
        #       #             #                           #                                       
    #   #   #   #             #     # # # # # #           #               # # # # # #             
        #       #             #     #         #   # # # # # # # # # # #     #     #   # # # #     
  # # # # # #   # # # #   # # # #   # # # # # #         #                   #     #     #   #     
      # #     #     #         #     #     #           #     # # # # #       # # # #     #   #     
    #   # #     #   #         #     # # # # # #       #           #         #     #     #   #     
  #     #   #   #   #         # #   #     #         # #         #           # # # #     #   #     
      #         #   #     # # #     # # # # # #   #   #   # # # # # # #     #     #     #   #     
  # # # # #     #   #         #     # #       #       #         #           #     # #     #       
    #     #       #           #   #   #       #       #         #         # # # # #       #       
      # #       #   #         #   #   # # # # #       #         #                 #     #   #     
  # #     #   #       #     # # #     #       #       #       # #                 #   #       #  
#######################################################################################################
]]
--[[ ���������ļ��������data�ļ��У��Զ����ֿͻ�������
    MY.SaveLUAData( szFile, tData[, szLang] )
]]
MY.Sys.SaveLUAData = function(szFile, tData, szLang)
    szFile = string.gsub(szFile, '/', '\\')
    while(string.sub(szFile, 1, 1)=='\\') do
        szFile = string.sub(szFile, 2)
    end
    if type(szLang)~='string' then
        local _, _, lang = GetVersion()
        szLang = string.upper(lang)
    end
    if #szLang>0 then szLang = '_'..szLang end
    szFile = MY.GetAddonInfo().szFrameworkRoot..'data\\' .. szFile  .. '.MYDATA' .. szLang
    SaveLUAData(szFile, tData)
end
MY.SaveLUAData = MY.Sys.SaveLUAData
--[[ ���������ļ��������data�ļ��У��Զ����ֿͻ�������
    MY.LoadLUAData( szFile[, szLang] )
]]
MY.Sys.LoadLUAData = function(szFile, szLang)
    szFile = string.gsub(szFile, '/', '\\')
    while(string.sub(szFile, 1, 1)=='\\') do
        szFile = string.sub(szFile, 2)
    end
    if type(szLang)~='string' then
        local _, _, lang = GetVersion()
        szLang = string.upper(lang)
    end
    if #szLang>0 then szLang = '_'..szLang end
    szFile = MY.GetAddonInfo().szFrameworkRoot..'data\\' .. szFile  .. '.MYDATA' .. szLang
    return LoadLUAData(szFile)
end
MY.LoadLUAData = MY.Sys.LoadLUAData

--[[
-- Remote Request
#######################################################################################################
  # # # # # # # # # # #       #       #           #           #                     #     #       
  #                   #       #       # # # #       #   # # # # # # # #             #       #     
  #                   #     #       #       #                 #           # # # # # # # # # # #   
  # #       #       # #   #     # #   #   #               # # # # # #               #             
  #   #   #   #   #   #   # # #         #         # #         #             #       # #     #     
  #     #       #     #       #       #   #         #   # # # # # # # #       #     # #   #       
  #     #       #     #     #     # #       # #     #     #         #             # #   #         
  #   #   #   #   #   #   # # # #   # # # # #       #     # # # # # #           #   #   #         
  # #       #       # #             #       #       #     #         #         #     #     #       
  #                   #       # #   #       #       #     # # # # # #     # #       #       #     
  #                   #   # #       # # # # #       # #   #         #               #         #   
  #               # # #             #       #       #     #       # #             # #           
--#######################################################################################################
]]
_Cache.tRequest = {}      -- �����������
_Cache.bRequest = false   -- ��������æ��
--[[ (void) MY.RemoteRequest(string szUrl, func fnAction)       -- ����Զ�� HTTP ����
-- szUrl        -- ��������� URL������ http:// �� https://��
-- fnAction     -- ������ɺ�Ļص��������ص�ԭ�ͣ�function(szTitle, szContent)]]
MY.RemoteRequest = function(szUrl, fnSuccess, fnError, nTimeout)
    -- ��ʽ������
    if type(szUrl)~="string" then return end
    if type(fnSuccess)~="function" then return end
    if type(fnError)~="function" then fnError = function(szUrl,errMsg) MY.Debug(szUrl..' - '..errMsg.."\n",'RemoteRequest',1) end end
    if type(nTimeout)~="number" then nTimeout = 10000 end
    -- ���������β����������
    table.insert(_Cache.tRequest,{ szUrl = szUrl, fnSuccess = fnSuccess, fnError = fnError, nTimeout = nTimeout })
    -- ��ʼ�����������
    _Cache.DoRemoteRequest()
end
-- ����Զ���������
_Cache.DoRemoteRequest = function()
    -- �������Ϊ�� ���ö���״̬Ϊ���в�����
    if table.getn(_Cache.tRequest)==0 then _Cache.bRequest = false MY.Debug('Remote Request Queue Is Clear.\n','MYRR',0) return end
    -- �����ǰ������δ���������� ����Զ��������д��ڿ���״̬
    if not _Cache.bRequest then
        -- check if network plugins inited
        if not _Cache.hRequest then
            MY.DelayCall( _Cache.DoRemoteRequest, 3000 )
            MY.Debug('network plugin has not been initalized yet!\n','MYRR',1)
            _Cache.hRequest = MY.GetFrame():Lookup("Page_1")
            if _Cache.hRequest then
                -- web page complete
                _Cache.hRequest.OnDocumentComplete = function()
                    -- �ж��Ƿ���Զ������ȴ��ص� û����ֱ�ӷ���
                    if not _Cache.bRequest then return end
                    -- �����ص�
                    local szUrl, szTitle, szContent = this:GetLocationURL(), this:GetLocationName(), this:GetDocument()
                    -- ��ȡ��������ײ�Ԫ��
                    local rr = _Cache.tRequest[1]
                    -- �жϵ�ǰҳ���Ƿ��������
                    if rr.szUrl == szUrl and ( szUrl ~= szTitle or szContent ) then
                        MY.Debug(string.format("\n [RemoteRequest - OnDocumentComplete]\n [U] %s\n [T] %s\n", szUrl, szTitle),'MYRR',0)
                        -- ע����ʱ����ʱ��
                        MY.DelayCall("MY_Remote_Request_Timeout")
                        -- �ɹ��ص�����
                        pcall(rr.fnSuccess, szTitle, szContent)
                        -- �������б��Ƴ�
                        table.remove(_Cache.tRequest, 1)
                        -- ��������״̬Ϊ����
                        _Cache.bRequest = false
                        -- ������һ��Զ������
                        _Cache.DoRemoteRequest()
                    end
                end
            end
            return
        end
        -- ��ȡ���е�һ��Ԫ��
        local rr = _Cache.tRequest[1]
        -- ע������ʱ����������ʱ��
        MY.DelayCall(function()
            -- debug
            MY.Debug('Remote Request Timeout.\n','MYRR',1)
            -- ����ʱ �ص�����ʱ����
            pcall(rr.fnError, rr.szUrl, "timeout")
            -- ����������Ƴ���Ԫ��
            table.remove(_Cache.tRequest, 1)
            -- �����������״̬Ϊ����
            _Cache.bRequest = false
            -- ������һ��Զ������
            _Cache.DoRemoteRequest()
        end,rr.nTimeout,"MY_Remote_Request_Timeout")
        -- ��ʼ����������Դ
        _Cache.hRequest:Navigate(rr.szUrl)
        -- ���������״̬Ϊ��æ��
        _Cache.bRequest = true
    end
end

--[[
-- Breathe Call & Delay Call
#######################################################################################################
                    # #                     #       # # # # # # # #             #       #         
  # # # #   # # # #       # # # #           #                   #           #   #   #   #         
        #         #       #     #           #     #           #       #         #       #         
      #           #       #     #   # # # # # #   #   #     #     #   #   # # # # # #   # # # #   
    #       #     #       #     #           #     #     #   #   #     #       # #     #     #     
    # # #   #     # # #   # # # #           #     #         #         #     #   # #     #   #     
        #   #     #       #     #     #     #     #     #   #   #     #   #     #   #   #   #     
        #   #     #       #     #       #   #     #   #     #     #   #       #         #   #     
    #   #   #     #       #     #       #   #     #         #         #   # # # # #     #   #     
      #     # # # # # #   # # # #           #     #       # #         #     #     #       #       
    #   #                 #     #           #     #                   #       # #       #   #     
  #       # # # # # # #                 # # #     # # # # # # # # # # #   # #     #   #       #  
--#######################################################################################################
]]
_Cache.tDelayCall = {}    -- delay call ����
_Cache.tBreatheCall = {}  -- breathe call ����
--[[ �ӳٵ���
    (void) MY.DelayCall(func fnAction, number nDelay, string szName)
    fnAction    -- ���ú���
    nTime       -- �ӳٵ���ʱ�䣬��λ�����룬ʵ�ʵ����ӳ��ӳ��� 62.5 ��������
    szName      -- �ӳٵ���ID ����ȡ������
    ȡ������
    (void) MY.DelayCall(string szName)
    szName      -- �ӳٵ���ID
]]
MY.DelayCall = function(arg0, arg1, arg2)
    local fnAction, nDelay, szName
    if type(arg0) == "function" then fnAction = arg0 elseif type(arg1) == "function" then fnAction = arg1 elseif type(arg2) == "function" then fnAction = arg2 end
    if type(arg0) == "string"   then szName   = arg0 elseif type(arg1) == "string"   then szName   = arg1 elseif type(arg2) == "string"   then szName   = arg2 end
    if type(arg0) == "number"   then nDelay   = arg0 elseif type(arg1) == "number"   then nDelay   = arg1 elseif type(arg2) == "number"   then nDelay   = arg2 end
    if not fnAction and not szName then return nil end
    
    if szName then
        for i = #_Cache.tDelayCall, 1, -1 do
            if _Cache.tDelayCall[i].szName == szName then
                table.remove(_Cache.tDelayCall, i)
            end
        end
    end
    if fnAction and nDelay then
        table.insert(_Cache.tDelayCall, { nTime = nDelay + GetTime(), fnAction = fnAction, szName = szName })
    end
end
--[[ ע�����ѭ�����ú���
    (void) MY.BreatheCall(string szKey, func fnAction[, number nTime])
    szKey       -- ���ƣ�����Ψһ���ظ��򸲸�
    fnAction    -- ѭ���������ú�������Ϊ nil ���ʾȡ����� key �µĺ�����������
    nTime       -- ���ü������λ�����룬Ĭ��Ϊ 62.5����ÿ����� 16�Σ���ֵ�Զ��������� 62.5 ��������
]]
MY.BreatheCall = function(arg1, arg2, arg3)
    local fnAction, nInterval, szName = nil, nil, nil
    if type(arg1)=='string' then szName = StringLowerW(arg1) end
    if type(arg2)=='string' then szName = StringLowerW(arg2) end
    if type(arg3)=='string' then szName = StringLowerW(arg3) end
    if type(arg1)=='number' then nInterval = arg1 end
    if type(arg2)=='number' then nInterval = arg2 end
    if type(arg3)=='number' then nInterval = arg3 end
    if type(arg1)=='function' then fnAction = arg1 end
    if type(arg2)=='function' then fnAction = arg2 end
    if type(arg3)=='function' then fnAction = arg3 end
    if szName then
        for i = #_Cache.tBreatheCall, 1, -1 do
            if _Cache.tBreatheCall[i].szName == szName then
                table.remove(_Cache.tBreatheCall, i)
            end
        end
    end
    if fnAction then
        local nFrame = 1
        if nInterval and nInterval > 0 then
            nFrame = math.ceil(nInterval / 62.5)
        end
        table.insert( _Cache.tBreatheCall, { szName = szName, fnAction = fnAction, nNext = GetLogicFrameCount() + 1, nFrame = nFrame } )
    end
end
--[[ �ı��������Ƶ��
    (void) MY.BreatheCallDelay(string szKey, nTime)
    nTime       -- �ӳ�ʱ�䣬ÿ 62.5 �ӳ�һ֡
]]
MY.BreatheCallDelay = function(szKey, nTime)
    local t = _Cache.tBreatheCall[StringLowerW(szKey)]
    if t then
        t.nFrame = math.ceil(nTime / 62.5)
        t.nNext = GetLogicFrameCount() + t.nFrame
    end
end
--[[ �ӳ�һ�κ��������ĵ���Ƶ��
    (void) MY.BreatheCallDelayOnce(string szKey, nTime)
    nTime       -- �ӳ�ʱ�䣬ÿ 62.5 �ӳ�һ֡
]]
MY.BreatheCallDelayOnce = function(szKey, nTime)
    local t = _Cache.tBreatheCall[StringLowerW(szKey)]
    if t then
        t.nNext = GetLogicFrameCount() + math.ceil(nTime / 62.5)
    end
end
-- breathe
MY.RegisterUIEvent(MY, "OnFrameBreathe", function()
    -- run breathe calls
    local nFrame = GetLogicFrameCount()
    for i = #_Cache.tBreatheCall, 1, -1 do
        if nFrame >= _Cache.tBreatheCall[i].nNext then
            _Cache.tBreatheCall[i].nNext = nFrame + _Cache.tBreatheCall[i].nFrame
            local res, err = pcall(_Cache.tBreatheCall[i].fnAction)
            if not res then
                MY.Debug("BreatheCall#" .. (_Cache.tBreatheCall[i].szName or ('anonymous_'..i)) .." ERROR: " .. err)
            elseif err == 0 then    -- function return 0 means to stop its breathe
                table.remove(_Cache.tBreatheCall, i)
            end
        end
    end
    -- run delay calls
    local nTime = GetTime()
    for i = #_Cache.tDelayCall, 1, -1 do
        local dc = _Cache.tDelayCall[i]
        if dc.nTime <= nTime then
            local res, err = pcall(dc.fnAction)
            if not res then
                MY.Debug("DelayCall#" .. (dc.szName or 'anonymous') .." ERROR: " .. err)
            end
            table.remove(_Cache.tDelayCall, i)
        end
    end
end)

--[[
#######################################################################################################
              # # # #         #         #               #       #             #           #       
    # # # # #                 #           #       # # # # # # # # # # #         #       #         
          #                 #       # # # # # #         #       #           # # # # # # # # #     
        #         #       #     #       #                       # # #       #       #       #     
      # # # # # #         # # #       #     #     # # # # # # #             # # # # # # # # #     
            # #               #     #         #     #     #       #         #       #       #     
        # #         #       #       # # # # # #       #     #   #           # # # # # # # # #     
    # # # # # # # # # #   # # # #     #   #   #             #                       #             
            #         #               #   #       # # # # # # # # # # #   # # # # # # # # # # #   
      #     #     #           # #     #   #             #   #   #                   #             
    #       #       #     # #       #     #   #       #     #     #                 #             
  #       # #         #           #         # #   # #       #       # #             #         
#######################################################################################################
]]
_Cache.tPlayerMenu = {}   -- ���ͷ��˵�
_Cache.tTargetMenu = {}   -- Ŀ��ͷ��˵�
_Cache.tTraceMenu  = {}   -- �������˵�

-- get player addon menu
_Cache.GetPlayerAddonMenu = function()
    local menu = {}
    for i = 1, #_Cache.tPlayerMenu, 1 do
        local m = _Cache.tPlayerMenu[i].Menu
        if type(m)=="function" then m = m() end
        table.insert(menu, m)
    end
    if #menu>1 then
        table.insert(menu, 1, { bDevide = true })
        table.insert(menu, { bDevide = true })
    end
    return menu
end
-- get target addon menu
_Cache.GetTargetAddonMenu = function()
    local menu = {}
    for i = 1, #_Cache.tTargetMenu, 1 do
        local m = _Cache.tTargetMenu[i].Menu
        if type(m)=="function" then m = m() end
        table.insert(menu, m)
    end
    if #menu>1 then
        table.insert(menu, 1, { bDevide = true })
        table.insert(menu, { bDevide = true })
    end
    return menu
end
-- get trace button menu
_Cache.GetTraceButtonMenu = function()
    local menu = {}
    for i = 1, #_Cache.tTraceMenu, 1 do
        local m = _Cache.tTraceMenu[i].Menu
        if type(m)=="function" then m = m() end
        table.insert(menu, m)
    end
    if #menu>1 then
        table.insert(menu, 1, { bDevide = true })
        table.insert(menu, { bDevide = true })
    end
    return menu
end
--[[ ע�����ͷ��˵�
    -- ע��
    (void) MY.RegisterPlayerAddonMenu(szName,Menu)
    (void) MY.RegisterPlayerAddonMenu(Menu)
    -- ע��
    (void) MY.RegisterPlayerAddonMenu(szName)
]]
MY.RegisterPlayerAddonMenu = function(arg1, arg2)
    local szName, Menu
    if type(arg1)=='string' then szName = arg1 end
    if type(arg2)=='string' then szName = arg2 end
    if type(arg1)=='table' then Menu = arg1 end
    if type(arg1)=='function' then Menu = arg1 end
    if type(arg2)=='table' then Menu = arg2 end
    if type(arg2)=='function' then Menu = arg2 end
    if Menu then
        if szName then for i = #_Cache.tPlayerMenu, 1, -1 do
            if _Cache.tPlayerMenu[i].szName == szName then
                _Cache.tPlayerMenu[i] = {szName = szName, Menu = Menu}
                return nil
            end
        end end
        table.insert(_Cache.tPlayerMenu, {szName = szName, Menu = Menu})
    elseif szName then
        for i = #_Cache.tPlayerMenu, 1, -1 do
            if _Cache.tPlayerMenu[i].szName == szName then
                table.remove(_Cache.tPlayerMenu, i)
            end
        end
    end
end
--[[ ע��Ŀ��ͷ��˵�
    -- ע��
    (void) MY.RegisterTargetAddonMenu(szName,Menu)
    (void) MY.RegisterTargetAddonMenu(Menu)
    -- ע��
    (void) MY.RegisterTargetAddonMenu(szName)
]]
MY.RegisterTargetAddonMenu = function(arg1, arg2)
    local szName, Menu
    if type(arg1)=='string' then szName = arg1 end
    if type(arg2)=='string' then szName = arg2 end
    if type(arg1)=='table' then Menu = arg1 end
    if type(arg1)=='function' then Menu = arg1 end
    if type(arg2)=='table' then Menu = arg2 end
    if type(arg2)=='function' then Menu = arg2 end
    if Menu then
        if szName then for i = #_Cache.tTargetMenu, 1, -1 do
            if _Cache.tTargetMenu[i].szName == szName then
                _Cache.tTargetMenu[i] = {szName = szName, Menu = Menu}
                return nil
            end
        end end
        table.insert(_Cache.tTargetMenu, {szName = szName, Menu = Menu})
    elseif szName then
        for i = #_Cache.tTargetMenu, 1, -1 do
            if _Cache.tTargetMenu[i].szName == szName then
                table.remove(_Cache.tTargetMenu, i)
            end
        end
    end
end
--[[ ע�Ṥ�����˵�
    -- ע��
    (void) MY.RegisterTraceButtonMenu(szName,Menu)
    (void) MY.RegisterTraceButtonMenu(Menu)
    -- ע��
    (void) MY.RegisterTraceButtonMenu(szName)
]]
MY.RegisterTraceButtonMenu = function(arg1, arg2)
    local szName, Menu
    if type(arg1)=='string' then szName = arg1 end
    if type(arg2)=='string' then szName = arg2 end
    if type(arg1)=='table' then Menu = arg1 end
    if type(arg1)=='function' then Menu = arg1 end
    if type(arg2)=='table' then Menu = arg2 end
    if type(arg2)=='function' then Menu = arg2 end
    if Menu then
        if szName then for i = #_Cache.tTraceMenu, 1, -1 do
            if _Cache.tTraceMenu[i].szName == szName then
                _Cache.tTraceMenu[i] = {szName = szName, Menu = Menu}
                return nil
            end
        end end
        table.insert(_Cache.tTraceMenu, {szName = szName, Menu = Menu})
    elseif szName then
        for i = #_Cache.tTraceMenu, 1, -1 do
            if _Cache.tTraceMenu[i].szName == szName then
                table.remove(_Cache.tTraceMenu, i)
            end
        end
    end
end

pcall(function()
    -- �����˵�
    local tMenu = function() return {
        szOption = _L["mingyi plugins"],
        fnAction = MY.TogglePanel,
        bCheck = true,
        bChecked = MY.GetFrame():IsVisible(),
    } end
    MY.RegisterPlayerAddonMenu( 'MY_MAIN_MENU', tMenu)
    MY.RegisterTraceButtonMenu( 'MY_MAIN_MENU', tMenu)
end)

TraceButton_AppendAddonMenu( { _Cache.GetTraceButtonMenu } )
Player_AppendAddonMenu( { _Cache.GetPlayerAddonMenu } )
Target_AppendAddonMenu( { _Cache.GetTargetAddonMenu } )

--[[
#######################################################################################################
              # # # #         #         #             #         #                   #             
    # # # # #                 #           #           #       #   #         #       #       #     
          #                 #       # # # # # #   # # # #   #       #       #       #       #     
        #         #       #     #       #           #     #   # # #   #     #       #       #     
      # # # # # #         # # #       #     #     #   #                     # # # # # # # # #     
            # #               #     #         #   # # # # # # #       #             #             
        # #         #       #       # # # # # #       #   #   #   #   #             #             
    # # # # # # # # # #   # # # #     #   #   #       # # # # #   #   #   #         #         #   
            #         #               #   #       # # #   #   #   #   #   #         #         #   
      #     #     #           # #     #   #           #   # # #   #   #   #         #         #   
    #       #       #     # #       #     #   #       #   #   #       #   # # # # # # # # # # #   
  #       # #         #           #         # #       #   #   #     # #                       #   
#######################################################################################################
]]
--[[ ��ʾ������Ϣ
    MY.Sysmsg(oContent, oTitle)
    szContent    Ҫ��ʾ��������Ϣ
    szTitle      ��Ϣͷ��
    tContentRgbF ������Ϣ������ɫrgbf[��ѡ��Ϊ��ʹ��Ĭ����ɫ���塣]
    tTitleRgbF   ��Ϣͷ��������ɫrgbf[��ѡ��Ϊ�պ�������Ϣ������ɫ��ͬ��]
]]
MY.Sysmsg = function(oContent, oTitle)
    oTitle = oTitle or MY.GetAddonInfo().szShortName
    if type(oTitle)~='table' then oTitle = { oTitle, bNoWrap = true } end
    if type(oContent)~='table' then oContent = { oContent, bNoWrap = true } end
    oContent.r, oContent.g, oContent.b = oContent.r or 255, oContent.g or 255, oContent.b or 0

    for i = #oContent, 1, -1 do
        if type(oContent[i])=="number"  then oContent[i] = '' .. oContent[i] end
        if type(oContent[i])=="boolean" then oContent[i] = (oContent[i] and 'true') or 'false' end
        -- auto wrap each line
        if (not oContent.bNoWrap) and type(oContent[i])=="string" and string.sub(oContent[i], -1)~='\n' then
            oContent[i] = oContent[i] .. '\n'
        end
    end

    -- calc szMsg
    local szMsg = ''
    for i = 1, #oTitle, 1 do
        if oTitle[i]~='' then
            szMsg = szMsg .. '['..oTitle[i]..']'
        end
    end
    if #szMsg > 0 then
        szMsg = GetFormatText( szMsg..' ', oTitle.f or oContent.f, oTitle.r or oContent.r, oTitle.g or oContent.g, oTitle.b or oContent.b )
    end
    for i = 1, #oContent, 1 do
        szMsg = szMsg .. GetFormatText(oContent[i], oContent.f, oContent.r, oContent.g, oContent.b)
    end
    -- Output
    OutputMessage("MSG_SYS", szMsg, true)
end
--[[ Debug���
    (void)MY.Debug(szText, szHead, nLevel)
    szText  Debug��Ϣ
    szHead  Debugͷ
    nLevel  Debug����[���ڵ�ǰ����ֵ���������]
]]
MY.Debug = function(szText, szHead, nLevel)
    if type(nLevel)~="number" then nLevel = 1 end
    if type(szHead)~="string" then szHead = 'MY DEBUG' end
    local oContent = { r=255, g=255, b=0 }
    if nLevel == 0 then
        oContent = { r=0,   g=255, b=127 }
    elseif nLevel == 1 then
        oContent = { r=255, g=170, b=170 }
    elseif nLevel == 2 then
        oContent = { r=255, g=86,  b=86  }
    end
    table.insert(oContent, szText)
    if nLevel >= MY.GetAddonInfo().nDebugLevel then
        MY.Sysmsg(oContent, szHead)
    end
end