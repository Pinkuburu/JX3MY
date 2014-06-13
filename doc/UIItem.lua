SetPosType()
{
    POSITION_BY_CUSTOM = 0,
    POSITION_LEFT_BOTTOM,     
    POSITION_LEFT_TOP,  
    POSITION_LEFT_CENTER,
    POSITION_TOP_LEFT,        
    POSITION_TOP_RIGHT,
    POSITION_TOP_CENTER,
    POSITION_RIGHT_TOP,       
    POSITION_RIGHT_BOTTOM,
    POSITION_RIGHT_CENTER,
    POSITION_BOTTOM_LEFT,     
    POSITION_BOTTOM_RIGHT,   
    POSITION_BOTTOM_CENTER,
}



	static luaL_reg const s_aItemNullMetaTable[] =
	{
		{ "Show",							LuaItemNull_Show},
		{ "Hide",							LuaItemNull_Hide},
		{ "PtInItem",						LuaItemNull_PtInItem},
		{ "SetRelPos",						LuaItemNull_SetRelPos},
		{ "GetRelPos",						LuaItemNull_GetRelPos},
		{ "SetAbsPos",						LuaItemNull_SetAbsPos},
		{ "GetAbsPos",						LuaItemNull_GetAbsPos},
		{ "SetSize",						LuaItemNull_SetSize},
		{ "GetSize",						LuaItemNull_GetSize},
		{ "SetPosType",						LuaItemNull_SetPosType},
		{ "GetPosType",						LuaItemNull_GetPosType},
		{ "IsVisible",						LuaItemNull_IsVisible},
		{ "GetName",						LuaItemNull_GetName},
		{ "SetName",						LuaItemNull_SetName},
		{ "SetTip",							LuaItemNull_SetTip},
		{ "GetTip",							LuaItemNull_GetTip},
		{ "SetUserData",					LuaItemNull_SetUserData},
		{ "GetUserData",					LuaItemNull_GetUserData},
		{ "RegisterEvent",					LuaItemNull_RegisterEvent},
		{ "ClearEvent",						LuaItemNull_ClearEvent},
		{ "EnableScale",					LuaItemNull_EnableScale},
		{ "Scale",							LuaItemNull_Scale},		
		{ "LockShowAndHide",				LuaItemNull_LockShowAndHide},
		{ "SetAlpha",						LuaItemNull_SetAlpha},
		{ "GetAlpha",						LuaItemNull_GetAlpha},
		{ "GetParent",						LuaItemNull_GetParent},
		{ "GetRoot",						LuaItemNull_GetRoot},
		{ "GetType",						LuaItemNull_GetType},
		{ "GetIndex",						LuaItemNull_GetIndex},
		{ "SetIndex",						LuaItemNull_SetIndex},
		{ "ExchangeIndex",					LuaItemNull_ExchangeIndex},
		{ "GetTreePath",					LuaItemNull_GetTreePath},
		{ "SetAreaTestFile",				LuaItemNull_SetAreaTestFile},
		
		{ "IsValid",						LuaItemNull_IsValid },
//		{ "__newindex",						LuaItemNull_NewIndex },
		{ "__eq",							LuaItemNull_Equal },
		
		{ NULL,								NULL },
	};

	static luaL_reg const s_aItemTextMetaTable[] =
	{
		//itemnull
		{ "Show",							LuaItemNull_Show},
		{ "Hide",							LuaItemNull_Hide},
		{ "PtInItem",						LuaItemNull_PtInItem},
		{ "SetRelPos",						LuaItemNull_SetRelPos},
		{ "GetRelPos",						LuaItemNull_GetRelPos},
		{ "SetAbsPos",						LuaItemNull_SetAbsPos},
		{ "GetAbsPos",						LuaItemNull_GetAbsPos},
		{ "SetSize",						LuaItemNull_SetSize},
		{ "GetSize",						LuaItemNull_GetSize},
		{ "SetPosType",						LuaItemNull_SetPosType},
		{ "GetPosType",						LuaItemNull_GetPosType},
		{ "IsVisible",						LuaItemNull_IsVisible},
		{ "GetName",						LuaItemNull_GetName},
		{ "SetName",						LuaItemNull_SetName},
		{ "SetTip",							LuaItemNull_SetTip},
		{ "GetTip",							LuaItemNull_GetTip},
		{ "SetUserData",					LuaItemNull_SetUserData},
		{ "GetUserData",					LuaItemNull_GetUserData},
		{ "RegisterEvent",					LuaItemNull_RegisterEvent},
		{ "ClearEvent",						LuaItemNull_ClearEvent},
		{ "EnableScale",					LuaItemNull_EnableScale},
		{ "Scale",							LuaItemNull_Scale},		
		{ "LockShowAndHide",				LuaItemNull_LockShowAndHide},
		{ "SetAlpha",						LuaItemNull_SetAlpha},
		{ "GetAlpha",						LuaItemNull_GetAlpha},
		{ "GetParent",						LuaItemNull_GetParent},
		{ "GetRoot",						LuaItemNull_GetRoot},
		{ "GetType",						LuaItemNull_GetType},
		{ "GetIndex",						LuaItemNull_GetIndex},
		{ "SetIndex",						LuaItemNull_SetIndex},
		{ "ExchangeIndex",					LuaItemNull_ExchangeIndex},
		{ "GetTreePath",					LuaItemNull_GetTreePath},
		{ "SetAreaTestFile",				LuaItemNull_SetAreaTestFile},
		{ "IsValid",						LuaItemNull_IsValid },
//		{ "__newindex",						LuaItemNull_NewIndex },
		{ "__eq",							LuaItemNull_Equal },

		//text
		{ "SetFontScheme",					LuaItemText_SetFontScheme},
		{ "GetFontScheme",					LuaItemText_GetFontScheme},
		{ "SetText",						LuaItemText_SetText},
		{ "GetText",						LuaItemText_GetText},
		{ "GetTextLen",						LuaItemText_GetTextLen},
		{ "SetVAlign",						LuaItemText_SetVAlign},
		{ "GetVAlign",						LuaItemText_GetVAlign},
		{ "SetHAlign",						LuaItemText_SetHAlign},
		{ "GetHAlign",						LuaItemText_GetHAlign},
		{ "SetRowSpacing",					LuaItemText_SetRowSpacing},
		{ "GetRowSpacing",					LuaItemText_GetRowSpacing},
		{ "SetMultiLine",					LuaItemText_SetMultiLine},
		{ "IsMultiLine",					LuaItemText_IsMultiLine},
		{ "FormatTextForDraw",				LuaItemText_FormatTextForDraw},
		{ "AutoSize",						LuaItemText_AutoSize},
		{ "SetCenterEachLine",				LuaItemText_SetCenterEachLine},
		{ "IsCenterEachLine",				LuaItemText_IsCenterEachLine},
		{ "SetFontSpacing",					LuaItemText_SetFontSpacing},
		{ "GetFontSpacing",					LuaItemText_GetFontSpacing},
		{ "SetRichText",					LuaItemText_SetRichText},
		{ "IsRichText",						LuaItemText_IsRichText},
		{ "GetFontScale",					LuaItemText_GetFontScale},
		{ "SetFontScale",					LuaItemText_SetFontScale},
		{ "SetFontID",						LuaItemText_SetFontID},
		{ "SetFontColor",					LuaItemText_SetFontColor},
		{ "SetFontBorder",					LuaItemText_SetFontBoder},
		{ "SetFontShadow",					LuaItemText_SetFontShadow},
		{ "GetFontID",						LuaItemText_GetFontID},
		{ "GetFontColor",					LuaItemText_GetFontColor},
		{ "GetFontBoder",					LuaItemText_GetFontBoder},
		{ "GetFontProjection",				LuaItemText_GetFontProjection},
		{ "GetTextExtent",					LuaItemText_GetTextExtent },
		{ "GetTextPosExtent",				LuaItemText_GetTextPosExtent },
		
		{ NULL,								NULL },
	};

	static luaL_reg const s_aItemImageMetaTable[] =
	{
		//itemnull
		{ "Show",							LuaItemNull_Show },
		{ "Hide",							LuaItemNull_Hide },
		{ "PtInItem",						LuaItemNull_PtInItem },
		{ "SetRelPos",						LuaItemNull_SetRelPos },
		{ "GetRelPos",						LuaItemNull_GetRelPos },
		{ "SetAbsPos",						LuaItemNull_SetAbsPos },
		{ "GetAbsPos",						LuaItemNull_GetAbsPos },
		{ "SetSize",						LuaItemNull_SetSize },
		{ "GetSize",						LuaItemNull_GetSize },
		{ "SetPosType",						LuaItemNull_SetPosType },
		{ "GetPosType",						LuaItemNull_GetPosType },
		{ "IsVisible",						LuaItemNull_IsVisible },
		{ "GetName",						LuaItemNull_GetName },
		{ "SetName",						LuaItemNull_SetName },
		{ "SetTip",							LuaItemNull_SetTip },
		{ "GetTip",							LuaItemNull_GetTip },
		{ "SetUserData",					LuaItemNull_SetUserData },
		{ "GetUserData",					LuaItemNull_GetUserData },
		{ "RegisterEvent",					LuaItemNull_RegisterEvent },
		{ "ClearEvent",						LuaItemNull_ClearEvent },
		{ "EnableScale",					LuaItemNull_EnableScale },
		{ "Scale",							LuaItemNull_Scale },		
		{ "LockShowAndHide",				LuaItemNull_LockShowAndHide },
		{ "SetAlpha",						LuaItemNull_SetAlpha },
		{ "GetAlpha",						LuaItemNull_GetAlpha },
		{ "GetParent",						LuaItemNull_GetParent },
		{ "GetRoot",						LuaItemNull_GetRoot },
		{ "GetType",						LuaItemNull_GetType },
		{ "GetIndex",						LuaItemNull_GetIndex },
		{ "SetIndex",						LuaItemNull_SetIndex },
		{ "ExchangeIndex",					LuaItemNull_ExchangeIndex },
		{ "GetTreePath",					LuaItemNull_GetTreePath },
		{ "SetAreaTestFile",				LuaItemNull_SetAreaTestFile },
		{ "IsValid",						LuaItemNull_IsValid },
//		{ "__newindex",						LuaItemNull_NewIndex },
		{ "__eq",							LuaItemNull_Equal },

		//image
		{ "SetFrame",						LuaItemImage_SetFrame },
		{ "GetFrame",						LuaItemImage_GetFrame },
		{ "AutoSize",						LuaItemImage_AutoSize },
		{ "SetImageType",					LuaItemImage_SetImageType },
		{ "GetImageType",					LuaItemImage_GetImageType },
		{ "SetPercentage",					LuaItemImage_SetPercentage },
		{ "GetPercentage",					LuaItemImage_GetPercentage },
		{ "SetRotate",						LuaItemImage_SetRotate },
		{ "GetRotate",						LuaItemImage_GetRotate },
		{ "GetImageID",						LuaItemImage_GetImageID },
		{ "FromUITex",						LuaItemImage_FromUITex },
		{ "FromTextureFile",				LuaItemImage_FromTextureFile },
		{ "FromScene",						LuaItemImage_FromScene},
		{ "FromImageID",					LuaItemImage_FromImageID },
		{ "FromIconID",						LuaItemImage_FromIconID },
		{ "ToManagedImage",					LuaItemImage_ToManagedImage },

		{ NULL,								NULL },
	};

	static luaL_reg const s_aItemShadowMetaTable[] =
	{
		//itemnull
		{ "Show",							LuaItemNull_Show},
		{ "Hide",							LuaItemNull_Hide},
		{ "PtInItem",						LuaItemNull_PtInItem},
		{ "SetRelPos",						LuaItemNull_SetRelPos},
		{ "GetRelPos",						LuaItemNull_GetRelPos},
		{ "SetAbsPos",						LuaItemNull_SetAbsPos},
		{ "GetAbsPos",						LuaItemNull_GetAbsPos},
		{ "SetSize",						LuaItemNull_SetSize},
		{ "GetSize",						LuaItemNull_GetSize},
		{ "SetPosType",						LuaItemNull_SetPosType},
		{ "GetPosType",						LuaItemNull_GetPosType},
		{ "IsVisible",						LuaItemNull_IsVisible},
		{ "GetName",						LuaItemNull_GetName},
		{ "SetName",						LuaItemNull_SetName},
		{ "SetTip",							LuaItemNull_SetTip},
		{ "GetTip",							LuaItemNull_GetTip},
		{ "SetUserData",					LuaItemNull_SetUserData},
		{ "GetUserData",					LuaItemNull_GetUserData},
		{ "RegisterEvent",					LuaItemNull_RegisterEvent},
		{ "ClearEvent",						LuaItemNull_ClearEvent},
		{ "EnableScale",					LuaItemNull_EnableScale},
		{ "Scale",							LuaItemNull_Scale},		
		{ "LockShowAndHide",				LuaItemNull_LockShowAndHide},
		{ "SetAlpha",						LuaItemNull_SetAlpha},
		{ "GetAlpha",						LuaItemNull_GetAlpha},
		{ "GetParent",						LuaItemNull_GetParent},
		{ "GetRoot",						LuaItemNull_GetRoot},
		{ "GetType",						LuaItemNull_GetType},
		{ "GetIndex",						LuaItemNull_GetIndex},
		{ "SetIndex",						LuaItemNull_SetIndex},
		{ "ExchangeIndex",					LuaItemNull_ExchangeIndex},
		{ "GetTreePath",					LuaItemNull_GetTreePath},
		{ "SetAreaTestFile",				LuaItemNull_SetAreaTestFile},
		{ "IsValid",						LuaItemNull_IsValid },
//		{ "__newindex",						LuaItemNull_NewIndex },
		{ "__eq",							LuaItemNull_Equal },

		//shadow
		{ "SetShadowColor",					LuaItemShadow_SetShadowColor},
		{ "GetShadowColor",					LuaItemShadow_GetShadowColor},
		{ "GetColorRGB",					LuaItemShadow_GetColorRGB},
		{ "SetColorRGB",					LuaItemShadow_SetColorRGB},
		{ "SetTriangleFan",					LuaItemShadow_SetTriangleFan},
		{ "IsTriangleFan",					LuaItemShadow_IsTriangleFan},
		{ "AppendTriangleFanPoint",			LuaItemShadow_AppendTriangleFanPoint},
		{ "ClearTriangleFanPoint",			LuaItemShadow_ClearTriangleFanPoint},
		
		{ NULL,								NULL },
	};

	static luaL_reg const s_aItemAnimateMetaTable[] =
	{
		//itemnull
		{ "Show",							LuaItemNull_Show},
		{ "Hide",							LuaItemNull_Hide},
		{ "PtInItem",						LuaItemNull_PtInItem},
		{ "SetRelPos",						LuaItemNull_SetRelPos},
		{ "GetRelPos",						LuaItemNull_GetRelPos},
		{ "SetAbsPos",						LuaItemNull_SetAbsPos},
		{ "GetAbsPos",						LuaItemNull_GetAbsPos},
		{ "SetSize",						LuaItemNull_SetSize},
		{ "GetSize",						LuaItemNull_GetSize},
		{ "SetPosType",						LuaItemNull_SetPosType},
		{ "GetPosType",						LuaItemNull_GetPosType},
		{ "IsVisible",						LuaItemNull_IsVisible},
		{ "GetName",						LuaItemNull_GetName},
		{ "SetName",						LuaItemNull_SetName},
		{ "SetTip",							LuaItemNull_SetTip},
		{ "GetTip",							LuaItemNull_GetTip},
		{ "SetUserData",					LuaItemNull_SetUserData},
		{ "GetUserData",					LuaItemNull_GetUserData},
		{ "RegisterEvent",					LuaItemNull_RegisterEvent},
		{ "ClearEvent",						LuaItemNull_ClearEvent},
		{ "EnableScale",					LuaItemNull_EnableScale},
		{ "Scale",							LuaItemNull_Scale},		
		{ "LockShowAndHide",				LuaItemNull_LockShowAndHide},
		{ "SetAlpha",						LuaItemNull_SetAlpha},
		{ "GetAlpha",						LuaItemNull_GetAlpha},
		{ "GetParent",						LuaItemNull_GetParent},
		{ "GetRoot",						LuaItemNull_GetRoot},
		{ "GetType",						LuaItemNull_GetType},
		{ "GetIndex",						LuaItemNull_GetIndex},
		{ "SetIndex",						LuaItemNull_SetIndex},
		{ "ExchangeIndex",					LuaItemNull_ExchangeIndex},
		{ "GetTreePath",					LuaItemNull_GetTreePath},
		{ "SetAreaTestFile",				LuaItemNull_SetAreaTestFile},
		{ "IsValid",						LuaItemNull_IsValid },
//		{ "__newindex",						LuaItemNull_NewIndex },
		{ "__eq",							LuaItemNull_Equal },

		//animate
		{ "SetGroup",						LuaItemAnimate_SetGroup},
		{ "SetLoopCount",					LuaItemAnimate_SetLoopCount},
		{ "SetImagePath",					LuaItemAnimate_SetImagePath},
		{ "SetAnimate",						LuaItemAnimate_SetAnimate},
		{ "AutoSize",						LuaItemAnimate_AutoSize},

		{ NULL,								NULL },
	};

	static luaL_reg const s_aItemSceneMetaTable[] =
	{
		//itemnull
		{ "Show",							LuaItemNull_Show},
		{ "Hide",							LuaItemNull_Hide},
		{ "PtInItem",						LuaItemNull_PtInItem},
		{ "SetRelPos",						LuaItemNull_SetRelPos},
		{ "GetRelPos",						LuaItemNull_GetRelPos},
		{ "SetAbsPos",						LuaItemNull_SetAbsPos},
		{ "GetAbsPos",						LuaItemNull_GetAbsPos},
		{ "SetSize",						LuaItemNull_SetSize},
		{ "GetSize",						LuaItemNull_GetSize},
		{ "SetPosType",						LuaItemNull_SetPosType},
		{ "GetPosType",						LuaItemNull_GetPosType},
		{ "IsVisible",						LuaItemNull_IsVisible},
		{ "GetName",						LuaItemNull_GetName},
		{ "SetName",						LuaItemNull_SetName},
		{ "SetTip",							LuaItemNull_SetTip},
		{ "GetTip",							LuaItemNull_GetTip},
		{ "SetUserData",					LuaItemNull_SetUserData},
		{ "GetUserData",					LuaItemNull_GetUserData},
		{ "RegisterEvent",					LuaItemNull_RegisterEvent},
		{ "ClearEvent",						LuaItemNull_ClearEvent},
		{ "EnableScale",					LuaItemNull_EnableScale},
		{ "Scale",							LuaItemNull_Scale},		
		{ "LockShowAndHide",				LuaItemNull_LockShowAndHide},
		{ "SetAlpha",						LuaItemNull_SetAlpha},
		{ "GetAlpha",						LuaItemNull_GetAlpha},
		{ "GetParent",						LuaItemNull_GetParent},
		{ "GetRoot",						LuaItemNull_GetRoot},
		{ "GetType",						LuaItemNull_GetType},
		{ "GetIndex",						LuaItemNull_GetIndex},
		{ "SetIndex",						LuaItemNull_SetIndex},
		{ "ExchangeIndex",					LuaItemNull_ExchangeIndex},
		{ "GetTreePath",					LuaItemNull_GetTreePath},
		{ "SetAreaTestFile",				LuaItemNull_SetAreaTestFile},
		{ "IsValid",						LuaItemNull_IsValid },
//		{ "__newindex",						LuaItemNull_NewIndex },
		{ "__eq",							LuaItemNull_Equal },

		//scene
		{ "SetScene",						LuaItemScene_SetScene},
		{ "EnableRenderTerrain",			LuaItemScene_EnableRenderTerrain},
		{ "EnableRenderSkyBox",				LuaItemScene_EnableRenderSkyBox},
		{ "EnableAlpha",					LuaItemScene_EnableAlpha},

		{ NULL,								NULL },
	};

	static luaL_reg const s_aItemBoxMetaTable[] =
	{
		//itemnull
		{ "Show",							LuaItemNull_Show},
		{ "Hide",							LuaItemNull_Hide},
		{ "PtInItem",						LuaItemNull_PtInItem},
		{ "SetRelPos",						LuaItemNull_SetRelPos},
		{ "GetRelPos",						LuaItemNull_GetRelPos},
		{ "SetAbsPos",						LuaItemNull_SetAbsPos},
		{ "GetAbsPos",						LuaItemNull_GetAbsPos},
		{ "SetSize",						LuaItemNull_SetSize},
		{ "GetSize",						LuaItemNull_GetSize},
		{ "SetPosType",						LuaItemNull_SetPosType},
		{ "GetPosType",						LuaItemNull_GetPosType},
		{ "IsVisible",						LuaItemNull_IsVisible},
		{ "GetName",						LuaItemNull_GetName},
		{ "SetName",						LuaItemNull_SetName},
		{ "SetTip",							LuaItemNull_SetTip},
		{ "GetTip",							LuaItemNull_GetTip},
		{ "SetUserData",					LuaItemNull_SetUserData},
		{ "GetUserData",					LuaItemNull_GetUserData},
		{ "RegisterEvent",					LuaItemNull_RegisterEvent},
		{ "ClearEvent",						LuaItemNull_ClearEvent},
		{ "EnableScale",					LuaItemNull_EnableScale},
		{ "Scale",							LuaItemNull_Scale},		
		{ "LockShowAndHide",				LuaItemNull_LockShowAndHide},
		{ "SetAlpha",						LuaItemNull_SetAlpha},
		{ "GetAlpha",						LuaItemNull_GetAlpha},
		{ "GetParent",						LuaItemNull_GetParent},
		{ "GetRoot",						LuaItemNull_GetRoot},
		{ "GetType",						LuaItemNull_GetType},
		{ "GetIndex",						LuaItemNull_GetIndex},
		{ "SetIndex",						LuaItemNull_SetIndex},
		{ "ExchangeIndex",					LuaItemNull_ExchangeIndex},
		{ "GetTreePath",					LuaItemNull_GetTreePath},
		{ "SetAreaTestFile",				LuaItemNull_SetAreaTestFile},
		{ "IsValid",						LuaItemNull_IsValid },
//		{ "__newindex",						LuaItemNull_NewIndex },
		{ "__eq",							LuaItemNull_Equal },

		//box
		{ "SetBoxIndex",					LuaItemBox_SetIndex},
		{ "GetBoxIndex",					LuaItemBox_GetIndex},
		{ "SetObject",						LuaItemBox_SetObject},
		{ "GetObject",						LuaItemBox_GetObject},
		{ "GetObjectType",					LuaItemBox_GetObjectType},
		{ "GetObjectData",					LuaItemBox_GetObjectData},
		{ "ClearObject",					LuaItemBox_ClearObject},
		{ "IsEmpty",						LuaItemBox_IsEmpty},
		{ "EnableObject",					LuaItemBox_EnableObject},
		{ "IsObjectEnable",					LuaItemBox_IsObjectEnable},
		{ "EnableObjectEquip",				LuaItemBox_EnableObjectEquip},
		{ "IsObjectEquipable",				LuaItemBox_IsObjectEquipable},
		{ "SetObjectCoolDown",				LuaItemBox_SetObjectCoolDown},
		{ "IsObjectCoolDown",				LuaItemBox_IsObjectCoolDown},
		{ "SetObjectSparking",				LuaItemBox_SetObjectSparking},
		{ "SetObjectInUse",					LuaItemBox_SetObjectInUse},
		{ "SetObjectStaring",				LuaItemBox_SetObjectStaring},
		{ "SetObjectSelected",				LuaItemBox_SetObjectSelected},
		{ "IsObjectSelected",				LuaItemBox_IsObjectSelected},
		{ "SetObjectMouseOver",				LuaItemBox_SetObjectMouseOver},
		{ "IsObjectMouseOver",				LuaItemBox_IsObjectMouseOver},
		{ "SetObjectPressed",				LuaItemBox_SetObjectPressed},
		{ "IsObjectPressed",				LuaItemBox_IsObjectPressed},
		{ "SetCoolDownPercentage",			LuaItemBox_SetCoolDownPercentage},
		{ "GetCoolDownPercentage",			LuaItemBox_GetCoolDownPercentage},
		{ "SetObjectIcon",					LuaItemBox_SetObjectIcon},
		{ "GetObjectIcon",					LuaItemBox_GetObjectIcon},
		{ "ClearObjectIcon",				LuaItemBox_ClearObjectIcon},
		{ "SetOverText",					LuaItemBox_SetOverText},
		{ "GetOverText",					LuaItemBox_GetOverText},
		{ "SetOverTextFontScheme",			LuaItemBox_SetOverTextFontScheme},
		{ "GetOverTextFontScheme",			LuaItemBox_GetOverTextFontScheme},
		{ "SetOverTextPosition",			LuaItemBox_SetOverTextPosition},
		{ "GetOverTextPosition",			LuaItemBox_GetOverTextPosition},

		{ NULL,								NULL },
	};

	static luaL_reg const s_aItemHandleMetaTable[] =
	{
		//itemnull
		{ "Show",							LuaItemNull_Show},
		{ "Hide",							LuaItemNull_Hide},
		{ "PtInItem",						LuaItemNull_PtInItem},
		{ "SetRelPos",						LuaItemNull_SetRelPos},
		{ "GetRelPos",						LuaItemNull_GetRelPos},
		{ "SetAbsPos",						LuaItemNull_SetAbsPos},
		{ "GetAbsPos",						LuaItemNull_GetAbsPos},
		{ "SetSize",						LuaItemNull_SetSize},
		{ "GetSize",						LuaItemNull_GetSize},
		{ "SetPosType",						LuaItemNull_SetPosType},
		{ "GetPosType",						LuaItemNull_GetPosType},
		{ "IsVisible",						LuaItemNull_IsVisible},
		{ "GetName",						LuaItemNull_GetName},
		{ "SetName",						LuaItemNull_SetName},
		{ "SetTip",							LuaItemNull_SetTip},
		{ "GetTip",							LuaItemNull_GetTip},
		{ "SetUserData",					LuaItemNull_SetUserData},
		{ "GetUserData",					LuaItemNull_GetUserData},
		{ "RegisterEvent",					LuaItemNull_RegisterEvent},
		{ "ClearEvent",						LuaItemNull_ClearEvent},
		{ "EnableScale",					LuaItemNull_EnableScale},
		{ "Scale",							LuaItemNull_Scale},		
		{ "LockShowAndHide",				LuaItemNull_LockShowAndHide},
		{ "SetAlpha",						LuaItemNull_SetAlpha},
		{ "GetAlpha",						LuaItemNull_GetAlpha},
		{ "GetParent",						LuaItemNull_GetParent},
		{ "GetRoot",						LuaItemNull_GetRoot},
		{ "GetType",						LuaItemNull_GetType},
		{ "GetIndex",						LuaItemNull_GetIndex},
		{ "SetIndex",						LuaItemNull_SetIndex},
		{ "ExchangeIndex",					LuaItemNull_ExchangeIndex},
		{ "GetTreePath",					LuaItemNull_GetTreePath},
		{ "SetAreaTestFile",				LuaItemNull_SetAreaTestFile},
		{ "IsValid",						LuaItemNull_IsValid },
//		{ "__newindex",						LuaItemNull_NewIndex },
		{ "__eq",							LuaItemNull_Equal },

		//handle
		{ "AppendItemFromString",			LuaItemHandle_AppendItemFromString},
		{ "AppendItemFromIni",				LuaItemHandle_AppendItemFromIni},
		{ "AdjustItemShowInfo",				LuaItemHandle_AdjustItemShowInfo},
		{ "InsertItemFromString",			LuaItemHandle_InsertItemFromString},
		{ "InsertItemFromIni",				LuaItemHandle_InsertItemFromIni},
		{ "FormatAllItemPos",				LuaItemHandle_FormatAllItemPos},
		{ "SetHandleStyle",					LuaItemHandle_SetHandleStyle},
		{ "SetMinRowHeight",				LuaItemHandle_SetMinRowHeight},
		{ "SetMaxRowHeight",				LuaItemHandle_SetMaxRowHeight},
		{ "SetRowHeight",					LuaItemHandle_SetRowHeight},
		{ "SetRowSpacing",					LuaItemHandle_SetRowSpacing},
		{ "RemoveItem",						LuaItemHandle_RemoveItem},
		{ "Clear",							LuaItemHandle_Clear},
		{ "GetItemStartRelPos",				LuaItemHandle_GetItemStartRelPos},
		{ "SetItemStartRelPos",				LuaItemHandle_SetItemStartRelPos},
		{ "SetSizeByAllItemSize",			LuaItemHandle_SetSizeByAllItemSize},
		{ "GetAllItemSize",					LuaItemHandle_GetAllItemSize},
		{ "GetItemCount",					LuaItemHandle_GetItemCount},
		{ "GetVisibleItemCount",			LuaItemHandle_GetVisibleItemCount},
		{ "Lookup",							LuaItemHandle_Lookup},
		{ "EnableFormatWhenAppend",			LuaItemHandle_EnableFormatWhenAppend},
		{ "RemoveItemUntilNewLine",			LuaItemHandle_RemoveItemUntilNewLine},
		{ "ExchangeItemIndex",				LuaItemHandle_ExchangeItemIndex},
		{ "Sort",							LuaItemHandle_Sort },
		
		
		{ NULL,								NULL },
	};

	static luaL_reg const s_aItemTreeLeafMetaTable[] =
	{
		//itemnull
		{ "Show",							LuaItemNull_Show},
		{ "Hide",							LuaItemNull_Hide},
		{ "PtInItem",						LuaItemNull_PtInItem},
		{ "SetRelPos",						LuaItemNull_SetRelPos},
		{ "GetRelPos",						LuaItemNull_GetRelPos},
		{ "SetAbsPos",						LuaItemNull_SetAbsPos},
		{ "GetAbsPos",						LuaItemNull_GetAbsPos},
		{ "SetSize",						LuaItemNull_SetSize},
		{ "GetSize",						LuaItemNull_GetSize},
		{ "SetPosType",						LuaItemNull_SetPosType},
		{ "GetPosType",						LuaItemNull_GetPosType},
		{ "IsVisible",						LuaItemNull_IsVisible},
		{ "GetName",						LuaItemNull_GetName},
		{ "SetName",						LuaItemNull_SetName},
		{ "SetTip",							LuaItemNull_SetTip},
		{ "GetTip",							LuaItemNull_GetTip},
		{ "SetUserData",					LuaItemNull_SetUserData},
		{ "GetUserData",					LuaItemNull_GetUserData},
		{ "RegisterEvent",					LuaItemNull_RegisterEvent},
		{ "ClearEvent",						LuaItemNull_ClearEvent},
		{ "EnableScale",					LuaItemNull_EnableScale},
		{ "Scale",							LuaItemNull_Scale},		
		{ "LockShowAndHide",				LuaItemNull_LockShowAndHide},
		{ "SetAlpha",						LuaItemNull_SetAlpha},
		{ "GetAlpha",						LuaItemNull_GetAlpha},
		{ "GetParent",						LuaItemNull_GetParent},
		{ "GetRoot",						LuaItemNull_GetRoot},
		{ "GetType",						LuaItemNull_GetType},
		{ "GetIndex",						LuaItemNull_GetIndex},
		{ "SetIndex",						LuaItemNull_SetIndex},
		{ "ExchangeIndex",					LuaItemNull_ExchangeIndex},
		{ "GetTreePath",					LuaItemNull_GetTreePath},
		{ "SetAreaTestFile",				LuaItemNull_SetAreaTestFile},
		{ "IsValid",						LuaItemNull_IsValid },
//		{ "__newindex",						LuaItemNull_NewIndex },
		{ "__eq",							LuaItemNull_Equal },

		//handle
		{ "AppendItemFromString",			LuaItemHandle_AppendItemFromString},
		{ "AppendItemFromIni",				LuaItemHandle_AppendItemFromIni},
		{ "AdjustItemShowInfo",				LuaItemHandle_AdjustItemShowInfo},
		{ "InsertItemFromString",			LuaItemHandle_InsertItemFromString},
		{ "InsertItemFromIni",				LuaItemHandle_InsertItemFromIni},
		{ "FormatAllItemPos",				LuaItemHandle_FormatAllItemPos},
		{ "SetHandleStyle",					LuaItemHandle_SetHandleStyle},
		{ "SetMinRowHeight",				LuaItemHandle_SetMinRowHeight},
		{ "SetMaxRowHeight",				LuaItemHandle_SetMaxRowHeight},
		{ "SetRowHeight",					LuaItemHandle_SetRowHeight},
		{ "SetRowSpacing",					LuaItemHandle_SetRowSpacing},
		{ "RemoveItem",						LuaItemHandle_RemoveItem},
		{ "Clear",							LuaItemHandle_Clear},
		{ "GetItemStartRelPos",				LuaItemHandle_GetItemStartRelPos},
		{ "SetItemStartRelPos",				LuaItemHandle_SetItemStartRelPos},
		{ "SetSizeByAllItemSize",			LuaItemHandle_SetSizeByAllItemSize},
		{ "GetAllItemSize",					LuaItemHandle_GetAllItemSize},
		{ "GetItemCount",					LuaItemHandle_GetItemCount},
		{ "GetVisibleItemCount",			LuaItemHandle_GetVisibleItemCount},
		{ "Lookup",							LuaItemHandle_Lookup},
		{ "EnableFormatWhenAppend",			LuaItemHandle_EnableFormatWhenAppend},
		{ "RemoveItemUntilNewLine",			LuaItemHandle_RemoveItemUntilNewLine},
		{ "ExchangeItemIndex",				LuaItemHandle_ExchangeItemIndex},
		{ "Sort",							LuaItemHandle_Sort },
		

		//treeleaf
		{ "IsExpand",						LuaItemTreeLeaf_IsExpand},
		{ "ExpandOrCollapse",				LuaItemTreeLeaf_ExpandOrCollapse},
		{ "Expand",							LuaItemTreeLeaf_Expand},
		{ "Collapse",						LuaItemTreeLeaf_Collapse},
		{ "SetIndent",						LuaItemTreeLeaf_SetIndent},
		{ "GetIndent",						LuaItemTreeLeaf_GetIndent},
		{ "SetEachIndentWidth",				LuaItemTreeLeaf_SetEachIndentWidth},
		{ "GetEachIndentWidth",				LuaItemTreeLeaf_GetEachIndentWidth},
		{ "SetNodeIconSize",				LuaItemTreeLeaf_SetNodeIconSize},
		{ "SetIconImage",					LuaItemTreeLeaf_SetIconImage},
		{ "PtInIcon",						LuaItemTreeLeaf_PtInIcon},
		{ "AdjustNodeIconPos",				LuaItemTreeLeaf_AdjustNodeIconPos},
		{ "AutoSetIconSize",				LuaItemTreeLeaf_AutoSetIconSize},
		{ "SetShowIndex",					LuaItemTreeLeaf_SetShowIndex},
		{ "GetShowIndex",					LuaItemTreeLeaf_GetShowIndex},

		{ NULL,								NULL },
	};