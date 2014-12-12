---------------------------------
-- �������
-- by������@˫����@׷����Ӱ
-- ref: �����������Դ�� @haimanchajian.com
---------------------------------
-----------------------------------------------
-- ���غ����ͱ���
-----------------------------------------------
MY = MY or {}
MY.Player = MY.Player or {}
local _Cache, _L = {}, MY.LoadLangPack()
--[[
#######################################################################################################
              #     #       #             # #                         #             #             
  # # # #     #     #         #     # # #         # # # # # #         #             #             
  #     #   #       #               #                 #         #     #     # # # # # # # # #     
  #     #   #   # # # #             #                 #         #     #             #             
  #   #   # #       #     # # #     # # # # # #       # # # #   #     #       # # # # # # #       
  #   #     #       #         #     #     #         #       #   #     #             #             
  #     #   #   #   #         #     #     #       #   #     #   #     #   # # # # # # # # # # #   
  #     #   #     # #         #     #     #             #   #   #     #           #   #           
  #     #   #       #         #     #     #               #     #     #         #     #       #   
  # # #     #       #         #   #       #             #             #       # #       #   #     
  #         #       #       #   #                     #               #   # #   #   #     #       
  #         #     # #     #       # # # # # # #     #             # # #         # #         # #  
#######################################################################################################
]]
_Cache.tNearNpc = {}      -- ������NPC
_Cache.tNearPlayer = {}   -- ��������Ʒ
_Cache.tNearDoodad = {}   -- ���������

--[[ ��ȡ����NPC�б�
    (table) MY.GetNearNpc(void)
]]
MY.Player.GetNearNpc = function(nLimit)
    local tNpc, i = {}, 0
    for dwID, _ in pairs(_Cache.tNearNpc) do
        local npc = GetNpc(dwID)
        if not npc then
            _Cache.tNearNpc[dwID] = nil
        else
            i = i + 1
            if npc.szName=="" then
                npc.szName = string.gsub(Table_GetNpcTemplateName(npc.dwTemplateID), "^%s*(.-)%s*$", "%1")
            end
            tNpc[dwID] = npc
            if nLimit and i == nLimit then break end
        end
    end
    return tNpc, i
end
MY.GetNearNpc = MY.Player.GetNearNpc

--[[ ��ȡ��������б�
    (table) MY.GetNearPlayer(void)
]]
MY.Player.GetNearPlayer = function(nLimit)
    local tPlayer, i = {}, 0
    for dwID, _ in pairs(_Cache.tNearPlayer) do
        local player = GetPlayer(dwID)
        if not player then
            _Cache.tNearPlayer[dwID] = nil
        else
            i = i + 1
            tPlayer[dwID] = player
            if nLimit and i == nLimit then break end
        end
    end
    return tPlayer, i
end
MY.GetNearPlayer = MY.Player.GetNearPlayer

--[[ ��ȡ������Ʒ�б�
    (table) MY.GetNearPlayer(void)
]]
MY.Player.GetNearDoodad = function(nLimit)
    local tDoodad, i = {}, 0
    for dwID, _ in pairs(_Cache.tNearDoodad) do
        local dooded = GetDoodad(dwID)
        if not dooded then
            _Cache.tNearDoodad[dwID] = nil
        else
            i = i + 1
            tDoodad[dwID] = dooded
            if nLimit and i == nLimit then break end
        end
    end
    return tDoodad, i
end
MY.GetNearDoodad = MY.Player.GetNearDoodad

RegisterEvent("NPC_ENTER_SCENE",    function() _Cache.tNearNpc[arg0]    = true end)
RegisterEvent("NPC_LEAVE_SCENE",    function() _Cache.tNearNpc[arg0]    = nil  end)
RegisterEvent("PLAYER_ENTER_SCENE", function() _Cache.tNearPlayer[arg0] = true end)
RegisterEvent("PLAYER_LEAVE_SCENE", function() _Cache.tNearPlayer[arg0] = nil  end)
RegisterEvent("DOODAD_ENTER_SCENE", function() _Cache.tNearDoodad[arg0] = true end)
RegisterEvent("DOODAD_LEAVE_SCENE", function() _Cache.tNearDoodad[arg0] = nil  end)

--[[��ȡ�����б�
]]
MY.Player.GetFriendList = function(arg0)
    local t = {}
    local me = GetClientPlayer()
    local tGroup = { { id = 0, name = "" } }
    for _, group in ipairs(me.GetFellowshipGroupInfo() or {}) do
        table.insert(tGroup, group)
    end
    if type(arg0)=="number" then
        for i=#tGroup, 1, -1 do
            if arg0~=tGroup[i].id then
                table.remove(tGroup, i)
            end
        end
    elseif type(arg0)=="string" then
        for i=#tGroup, 1, -1 do
            if arg0~=tGroup[i].name then
                table.remove(tGroup, i)
            end
        end
    end
    local n = 0
    for _,group in ipairs(tGroup) do
        for _,p in ipairs(me.GetFellowshipInfo(group.id)) do
            t[p.id] = p
            n = n + 1
        end
    end
    
    return t, n
end

--[[��ȡ����
]]
MY.Player.GetFriend = function(arg0)
    if not arg0 then return nil end
    local tFriend = MY.Player.GetFriendList()
    if type(arg0) == "number" then
        return tFriend[arg0]
    elseif type(arg0) == "string" then
        for id, p in pairs(tFriend) do
            if p.name == arg0 then
                return p
            end
        end
    end
end
--[[
#######################################################################################################
                                  #                                                       #                   
  # # # # # # # # # # #         #                               # # # # # # # # #         #     # # # # #     
            #             # # # # # # # # # # #       #         #               #         #                   
          #               #                   #     #   #       #               #     # # # #                 
    # # # # # # # # # #   #                   #     #   #       # # # # # # # # #         #   # # # # # # #   
    #     #     #     #   #     # # # # #     #     # # # #     #               #       # #         #         
    #     # # # #     #   #     #       #     #   #   #   #     #               #       # # #       #         
    #     #     #     #   #     #       #     #   #   #   #     # # # # # # # # #     #   #     #   #   #     
    #     # # # #     #   #     #       #     #   #     #       #               #         #     #   #     #   
    #     #     #     #   #     # # # # #     #     # #   # #   #               #         #   #     #     #   
    # # # # # # # # # #   #                   #                 # # # # # # # # #         #         #         
    #                 #   #               # # #                 #               #         #       # #         
#######################################################################################################
]]
--[[ ȡ��Ŀ�����ͺ�ID
    (dwType, dwID) MY.GetTarget()       -- ȡ���Լ���ǰ��Ŀ�����ͺ�ID
    (dwType, dwID) MY.GetTarget(object) -- ȡ��ָ����������ǰ��Ŀ�����ͺ�ID
]]
MY.Player.GetTarget = function(object)
    if not object then
        object = GetClientPlayer()
    end
    if object then
        return object.GetTarget()
    else
        return TARGET.NO_TARGET, 0
    end
end
MY.GetTarget = MY.Player.GetTarget
--[[ ȡ�ò�������
    (KObject) MY.GetObject([number dwType, ]number dwID)
    -- dwType: [��ѡ]��������ö�� TARGET.*
    -- dwID  : ����ID
    -- return: ���� dwType ���ͺ� dwID ȡ�ò�������
    --         ������ʱ����nil
]]
MY.Player.GetObject = function(dwType, dwID)
    if not dwType then
        local me = GetClientPlayer()
        if me then
            dwType, dwID = me.GetTarget()
        else
            dwType, dwID = TARGET.NO_TARGET, 0
        end
    elseif not dwID then
        dwID, dwType = dwType, TARGET.NPC
        if IsPlayer(dwID) then
            dwType = TARGET.PLAYER
        end
    end
    if dwID <= 0 or dwType == TARGET.NO_TARGET then
        return nil
    elseif dwType == TARGET.PLAYER then
        return GetPlayer(dwID)
    elseif dwType == TARGET.DOODAD then
        return GetDoodad(dwID)
    else
        return GetNpc(dwID)
    end
end
MY.GetObject = MY.Player.GetObject

--[[ ���� dwType ���ͺ� dwID ����Ŀ��
-- (void) MY.SetTarget([number dwType, ]number dwID)
-- dwType   -- *��ѡ* Ŀ������
-- dwID     -- Ŀ�� ID]]
MY.Player.SetTarget = function(dwType, dwID)
    -- check dwType
    if type(dwType)=="userdata" then
        dwType, dwID = ( IsPlayer(dwType) and TARGET.PLAYER ) or TARGET.NPC, dwType.dwID
    elseif type(dwType)=="string" then
        dwType, dwID = 0, dwType
    end
    -- conv if dwID is string
    if type(dwID)=="string" then
        for _, p in pairs(MY.GetNearNpc()) do
            if p.szName == dwID then
                dwType, dwID = TARGET.NPC, p.dwID
            end
        end
        for _, p in pairs(MY.GetNearPlayer()) do
            if p.szName == dwID then
                dwType, dwID = TARGET.PLAYER, p.dwID
            end
        end
    end
    if not dwType or dwType <= 0 then
        dwType, dwID = TARGET.NO_TARGET, 0
    elseif not dwID then
        dwID, dwType = dwType, TARGET.NPC
        if IsPlayer(dwID) then
            dwType = TARGET.PLAYER
        end
    end
    SetTarget(dwType, dwID)
end
MY.SetTarget = MY.Player.SetTarget

--[[ ����/ȡ�� ��ʱĿ��
    -- MY.Player.SetTempTarget(dwType, dwID)
    -- MY.Player.ResumeTarget()
]]
_Cache.pTempTarget = { TARGET.NO_TARGET, 0 }
MY.Player.SetTempTarget = function(dwType, dwID)
    TargetPanel_SetOpenState(true)
    _Cache.pTempTarget = { GetClientPlayer().GetTarget() }
    MY.Player.SetTarget(dwType, dwID)
    TargetPanel_SetOpenState(false)
end
MY.SetTempTarget = MY.Player.SetTempTarget
MY.Player.ResumeTarget = function()
    TargetPanel_SetOpenState(true)
    -- ��֮ǰ��Ŀ�겻����ʱ���е���Ŀ��
    if _Cache.pTempTarget[1] ~= TARGET.NO_TARGET and not MY.GetObject(unpack(_Cache.pTempTarget)) then
        _Cache.pTempTarget = { TARGET.NO_TARGET, 0 }
    end
    MY.Player.SetTarget(unpack(_Cache.pTempTarget))
    _Cache.pTempTarget = { TARGET.NO_TARGET, 0 }
    TargetPanel_SetOpenState(false)
end
MY.ResumeTarget = MY.Player.ResumeTarget

--[[ ��ʱ����Ŀ��Ϊָ��Ŀ�겢ִ�к���
    (void) MY.Player.WithTarget(dwType, dwID, callback)
]]
_Cache.tWithTarget = {}
_Cache.lockWithTarget = false
_Cache.WithTargetHandle = function()
    if _Cache.lockWithTarget or
    #_Cache.tWithTarget == 0 then
        return
    end

    _Cache.lockWithTarget = true
    local r = table.remove(_Cache.tWithTarget, 1)
    
    MY.Player.SetTempTarget(r.dwType, r.dwID)
    local status, err = pcall(r.callback)
    if not status then
        MY.Debug(err, 'MY.Player.lua#WithTargetHandle', 2)
    end
    MY.Player.ResumeTarget()
    
    _Cache.lockWithTarget = false
    _Cache.WithTargetHandle()
end
MY.Player.WithTarget = function(dwType, dwID, callback)
    -- ��Ϊ�ͻ��˶��߳� ���Լ�����Դ�� ��ֹ������ʱĿ���ͻ
    table.insert(_Cache.tWithTarget, {
        dwType   = dwType  ,
        dwID     = dwID    ,
        callback = callback,
    })
    _Cache.WithTargetHandle()
end

--[[ ��N2��N1�������  --  ����+2
    -- ����N1���ꡢ����N2����
    (number) MY.GetFaceToTargetDegree(nX,nY,nFace,nTX,nTY)
    -- ����N1��N2
    (number) MY.GetFaceToTargetDegree(oN1, oN2)
    -- ���
    nil -- ��������
    number -- �����(0-180)
]]
MY.Player.GetFaceDegree = function(nX,nY,nFace,nTX,nTY)
    if type(nY)=="userdata" and type(nX)=="userdata" then nTX=nY.nX nTY=nY.nY nY=nX.nY nFace=nX.nFaceDirection nX=nX.nX end
    if type(nX)~="number" or type(nY)~="number" or type(nFace)~="number" or type(nTX)~="number" or type(nTY)~="number" then return nil end
    local a = nFace * math.pi / 128
    return math.acos( ( (nTX-nX)*math.cos(a) + (nTY-nY)*math.sin(a) ) / ( (nTX-nX)^2 + (nTY-nY)^2) ^ 0.5 ) * 180 / math.pi
end
--[[ ��oT2��oT1�����滹�Ǳ���
    (bool) MY.IsFaceToTarget(oT1,oT2)
    -- ���淵��true
    -- ���Է���false
    -- ��������ȷʱ����nil
]]
MY.Player.IsFaceToTarget = function(oT1,oT2)
    if type(oT1)~="userdata" or type(oT2)~="userdata" then return nil end
    local a = oT1.nFaceDirection * math.pi / 128
    return (oT2.nX-oT1.nX)*math.cos(a) + (oT2.nY-oT1.nY)*math.sin(a) > 0
end
--[[ װ����ΪszName��װ��
    (void) MY.Equip(szName)
    szName  װ������
]]
MY.Player.Equip = function(szName)
    local me = GetClientPlayer()
    for i=1,6 do
        if me.GetBoxSize(i)>0 then
            for j=0, me.GetBoxSize(i)-1 do
                local item = me.GetItem(i,j)
                if item == nil then
                    j=j+1
                elseif Table_GetItemName(item.nUiId)==szName then -- GetItemNameByItem(item)
                    local eRetCode, nEquipPos = me.GetEquipPos(i, j)
                    if szName==_L["ji guan"] or szName==_L["nu jian"] then
                        for k=0,15 do
                            if me.GetItem(INVENTORY_INDEX.BULLET_PACKAGE, k) == nil then
                                OnExchangeItem(i, j, INVENTORY_INDEX.BULLET_PACKAGE, k)
                                return
                            end
                        end
                        return
                    else
                        OnExchangeItem(i, j, INVENTORY_INDEX.EQUIP, nEquipPos)
                        return
                    end
                end
            end
        end
    end
end

--[[ ��ȡ�����buff�б�
    (table) MY.GetBuffList(obj)
]]
MY.Player.GetBuffList = function(obj)
    obj = obj or GetClientPlayer()
    local aBuffTable = {}
    local nCount = obj.GetBuffCount() or 0
    for i=1,nCount,1 do
        local dwID, nLevel, bCanCancel, nEndFrame, nIndex, nStackNum, dwSkillSrcID, bValid = obj.GetBuff(i - 1)
        if dwID then
            table.insert(aBuffTable,{dwID = dwID, nLevel = nLevel, bCanCancel = bCanCancel, nEndFrame = nEndFrame, nIndex = nIndex, nStackNum = nStackNum, dwSkillSrcID = dwSkillSrcID, bValid = bValid})
        end
    end
    return aBuffTable
end

_Cache.tPlayerSkills = {}   -- ��Ҽ����б�[����]   -- ����������ID
_Cache.tSkillCache = {}     -- �����б���         -- ����ID�鼼������ͼ��
--[[ ͨ���������ƻ�ȡ���ܶ���
    (table) MY.GetSkillByName(szName)
]]
MY.Player.GetSkillByName = function(szName)
    if table.getn(_Cache.tPlayerSkills)==0 then
        for i = 1, g_tTable.Skill:GetRowCount() do
            local tLine = g_tTable.Skill:GetRow(i)
            if tLine~=nil and tLine.dwIconID~=nil and tLine.fSortOrder~=nil and tLine.szName~=nil and tLine.dwIconID~=13 and ( (not _Cache.tPlayerSkills[tLine.szName]) or tLine.fSortOrder>_Cache.tPlayerSkills[tLine.szName].fSortOrder) then
                _Cache.tPlayerSkills[tLine.szName] = tLine
            end
        end
    end
    return _Cache.tPlayerSkills[szName]
end
--[[ �жϼ��������Ƿ���Ч
    (bool) MY.IsValidSkill(szName)
]]
MY.Player.IsValidSkill = function(szName)
    if MY.Player.GetSkillByName(szName)==nil then return false else return true end
end
--[[ �жϵ�ǰ�û��Ƿ����ĳ������
    (bool) MY.CanUseSkill(number dwSkillID[, dwLevel])
]]
MY.Player.CanUseSkill = function(dwSkillID, dwLevel)
    -- �жϼ����Ƿ���Ч ����������ת��Ϊ����ID
    if type(dwSkillID) == "string" then if MY.IsValidSkill(dwSkillID) then dwSkillID = MY.Player.GetSkillByName(dwSkillID).dwSkillID else return false end end
    local me, box = GetClientPlayer(), _Cache.hBox
    if me and box then
        if not dwLevel then
            if dwSkillID ~= 9007 then
                dwLevel = me.GetSkillLevel(dwSkillID)
            else
                dwLevel = 1
            end
        end
        if dwLevel > 0 then
            box:EnableObject(false)
            box:SetObjectCoolDown(1)
            box:SetObject(UI_OBJECT_SKILL, dwSkillID, dwLevel)
            UpdataSkillCDProgress(me, box)
            return box:IsObjectEnable() and not box:IsObjectCoolDown()
        end
    end
    return false
end
--[[ �ͷż���,�ͷųɹ�����true
    (bool)MY.UseSkill(dwSkillID, bForceStopCurrentAction, eTargetType, dwTargetID)
    dwSkillID               ����ID
    bForceStopCurrentAction �Ƿ��ϵ�ǰ�˹�
    eTargetType             �ͷ�Ŀ������
    dwTargetID              �ͷ�Ŀ��ID
]]
MY.Player.UseSkill = function(dwSkillID, bForceStopCurrentAction, eTargetType, dwTargetID)
    -- �жϼ����Ƿ���Ч ����������ת��Ϊ����ID
    if type(dwSkillID) == "string" then if MY.Player.IsValidSkill(dwSkillID) then dwSkillID = MY.Player.GetSkillByName(dwSkillID).dwSkillID else return false end end
    local me = GetClientPlayer()
    -- ��ȡ����CD
    local bCool, nLeft, nTotal = me.GetSkillCDProgress( dwSkillID, me.GetSkillLevel(dwSkillID) ) local bIsPrepare ,dwPreSkillID ,dwPreSkillLevel , fPreProgress= me.GetSkillPrepareState()
    local oTTP, oTID = me.GetTarget()
    if dwTargetID~=nil then SetTarget(eTargetType, dwTargetID) end
    if ( not bCool or nLeft == 0 and nTotal == 0 ) and not ( not bForceStopCurrentAction and dwPreSkillID == dwSkillID ) then
        me.StopCurrentAction() OnAddOnUseSkill( dwSkillID, me.GetSkillLevel(dwSkillID) )
        if dwTargetID then SetTarget(oTTP, oTID) end
        return true
    else
        if dwTargetID then SetTarget(oTTP, oTID) end
        return false
    end
end
-- ���ݼ��� ID ���ȼ���ȡ���ܵ����Ƽ�ͼ�� ID�����û��洦��
-- (string, number) MY.Player.GetSkillName(number dwSkillID[, number dwLevel])
MY.Player.GetSkillName = function(dwSkillID, dwLevel)
    if not _Cache.tSkillCache[dwSkillID] then
        local tLine = Table_GetSkill(dwSkillID, dwLevel)
        if tLine and tLine.dwSkillID > 0 and tLine.bShow
            and (StringFindW(tLine.szDesc, "_") == nil  or StringFindW(tLine.szDesc, "<") ~= nil)
        then
            _Cache.tSkillCache[dwSkillID] = { tLine.szName, tLine.dwIconID }
        else
            local szName = "SKILL#" .. dwSkillID
            if dwLevel then
                szName = szName .. ":" .. dwLevel
            end
            _Cache.tSkillCache[dwSkillID] = { szName, 13 }
        end
    end
    return unpack(_Cache.tSkillCache[dwSkillID])
end

--[[ �ǳ���Ϸ
    (void) MY.LogOff(bCompletely)
    bCompletely Ϊtrue���ص�½ҳ Ϊfalse���ؽ�ɫҳ Ĭ��Ϊfalse
]]
MY.Player.LogOff = function(bCompletely)
    if bCompletely then
        ReInitUI(LOAD_LOGIN_REASON.RETURN_GAME_LOGIN)
    else
        ReInitUI(LOAD_LOGIN_REASON.RETURN_ROLE_LIST)
    end
end

-- ���ݼ��� ID ��ȡ����֡�������������ܷ��� nil
-- (number) MY.Player.GetChannelSkillFrame(number dwSkillID)
MY.Player.GetChannelSkillFrame = function(dwSkillID)
    local t = _Cache.tSkillEx[dwSkillID]
    if t then
        return t.nChannelFrame
    end
end
-- Load skill extend data
_Cache.tSkillEx = LoadLUAData(MY.GetAddonInfo().szFrameworkRoot.."data/skill_ex") or {}