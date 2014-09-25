--
-- �ƾ�����
-- by ���� @ ˫���� @ ݶ����
-- Build 20140730
--
-- ��Ҫ����: �ƾ�����
-- 
local _L = MY.LoadLangPack(MY.GetAddonInfo().szRoot.."ExamTip/lang/")
local _Cache = {
    szQueryUrl = "http://jx3-my.aliapp.com/exam/?p=%s",
    tCached = {},
    tLastQA = {},
    szTipContent = nil,
}
MY_ExamTip = {}
MY_ExamTip.bAutoTip = false
RegisterCustomData("MY_ExamTip.bAutoTip")

-- ��ȡ��Ŀ�ʹ�
_Cache.BeginQueryData = function(szQues, callback)
    _Cache.szTipContent = _L["Querying, please wait..."]
    MY.RemoteRequest(string.format(szQueryUrl, MY.String.UrlEncode(szQues)), function(szTitle, szContent)
        if szTitle == "F" then
            _Cache.szTipContent = _L["No result found. Here's from open search engine:"].."\n"
        end
        _Cache.szTipContent = _Cache.szTipContent..szContent
    end, function()
        _Cache.szTipContent = _L['Loading failed.']
    end, 10000)
end
-- �ύ�����ȷ�� -- ��������Դ
_Cache.BeginSubmitData = function(szQues, szAnsw, callback)
    Station.Lookup("Normal/ExaminationPanel/","Handle_ExamContents"):Lookup(0):GetText()
end
-- ��ʾ���
_Cache.ShowTip = function()
    
end
-- ע��INIT�¼�
MY.RegisterInit(function()
    -- �����˵�
    local tMenu = function() return {
        szOption = _L["exam tip"],
        bCheck = true,
        bChecked = MY_ExamTip.bAutoTip,
    } end
    MY.RegisterPlayerAddonMenu( 'MY_EXAMTIP_MENU', tMenu)
    MY.RegisterTraceButtonMenu( 'MY_EXAMTIP_MENU', tMenu)
end)