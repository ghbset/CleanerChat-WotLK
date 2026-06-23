-- Luacheck configuration for CleanerChat WoW 3.3.5 addon
-- https://luacheck.readthedocs.io/

-- Lua version
std = "lua51"

-- Maximum line length (disabled - not a style linter)
max_line_length = false

-- Exclude third-party libraries
exclude_files = {
  "Libs/**",
  "APIDocumentation/**",
}

-- Ignore certain warnings globally
ignore = {
  "212/_.*",  -- Unused argument starting with underscore (intentional)
  "213",      -- Unused loop variable (common in WoW: for i = 1, count do)
  "542",      -- Empty if branch (sometimes intentional for clarity)
  "611",      -- Line contains only whitespace
  "612",      -- Line contains trailing whitespace
  "614",      -- Trailing whitespace in comment
}

-- Allow self in methods
self = false

-- WoW Global Environment
-- These are read-only globals provided by the WoW client

read_globals = {
  -- Lua Standard (WoW provides these)
  "_G",
  "assert",
  "collectgarbage",
  "date",
  "debugstack",
  "error",
  "gcinfo",
  "getfenv",
  "getmetatable",
  "ipairs",
  "loadstring",
  "next",
  "pairs",
  "pcall",
  "print",
  "rawequal",
  "rawget",
  "rawset",
  "select",
  "setfenv",
  "setmetatable",
  "time",
  "tonumber",
  "tostring",
  "type",
  "unpack",
  "wipe",
  "xpcall",

  -- String library
  "string",
  "strbyte",
  "strchar",
  "strfind",
  "strformat",
  "strjoin",
  "strlen",
  "strlower",
  "strmatch",
  "strrep",
  "strrev",
  "strsplit",
  "strsub",
  "strtrim",
  "strupper",
  "format",
  "gsub",
  "gmatch",

  -- Table library
  "table",
  "tinsert",
  "tremove",
  "tsort",
  "tconcat",
  "sort",

  -- Math library
  "math",
  "abs",
  "ceil",
  "floor",
  "max",
  "min",
  "mod",
  "sqrt",
  "random",

  -- Bit operations
  "bit",

  -- WoW Frame API
  "CreateFrame",
  "CreateFont",
  "CreateColor",
  "CreateObjectPool",
  "getglobal",
  "setglobal",
  "UIParent",
  "WorldFrame",
  "Minimap",

  -- WoW API - Unit Functions
  "UnitName",
  "UnitClass",
  "UnitRace",
  "UnitLevel",
  "UnitHealth",
  "UnitHealthMax",
  "UnitMana",
  "UnitManaMax",
  "UnitPower",
  "UnitPowerMax",
  "UnitPowerType",
  "UnitExists",
  "UnitIsPlayer",
  "UnitIsUnit",
  "UnitIsDead",
  "UnitIsGhost",
  "UnitIsAFK",
  "UnitIsDND",
  "UnitIsConnected",
  "UnitInRaid",
  "UnitInParty",
  "UnitIsGroupLeader",
  "UnitIsGroupAssistant",
  "UnitOnTaxi",
  "UnitGUID",
  "UnitFactionGroup",
  "GetUnitName",

  -- WoW API - Player Functions
  "GetRealmName",
  "GetPlayerInfoByGUID",
  "GetNumGroupMembers",
  "GetNumSubgroupMembers",
  "IsInRaid",
  "IsInGroup",
  "IsInGuild",
  "GetGuildInfo",

  -- WoW API - Chat Functions
  "SendChatMessage",
  "GetChatTypeIndex",
  "ChatFrame_AddMessageEventFilter",
  "ChatFrame_RemoveMessageEventFilter",
  "FCF_GetCurrentChatFrame",
  "FCF_SetWindowName",
  "FCF_DockFrame",
  "FCF_GetChatWindowInfo",
  "GetChatWindowInfo",
  "SetChatWindowShown",
  "FloatingChatFrame_OnLoad",
  "ChatEdit_GetActiveWindow",
  "ChatEdit_ActivateChat",
  "ChatEdit_DeactivateChat",

  -- WoW API - Chat Frames (globals)
  "CHAT_FRAMES",
  "ChatFrame1",
  "ChatFrame2",
  "ChatFrame3",
  "ChatFrame4",
  "ChatFrame5",
  "ChatFrame6",
  "ChatFrame7",
  "ChatFrame8",
  "ChatFrame9",
  "ChatFrame10",
  "DEFAULT_CHAT_FRAME",
  "SELECTED_CHAT_FRAME",
  "GENERAL_CHAT_DOCK",
  "GeneralDockManager",
  "ChatFrame1EditBox",
  "ChatFrameEditBox",

  -- WoW API - Item Functions
  "GetItemInfo",
  "GetItemIcon",
  "GetItemQualityColor",
  "GetContainerItemLink",
  "GetContainerItemInfo",
  "GetContainerNumSlots",
  "GetInboxItem",
  "GetInboxItemLink",
  "TakeInboxItem",
  "GetCursorInfo",
  "DeleteCursorItem",
  "PickupContainerItem",
  "UseContainerItem",

  -- WoW API - Auction Functions
  "StartAuction",
  "GetAuctionSellItemInfo",
  "ClickAuctionSellItemButton",

  -- WoW API - Money Functions
  "GetMoney",
  "GetCoinText",
  "GetCoinTextureString",
  "BreakUpLargeNumbers",

  -- WoW API - Loot Functions
  "GetLootSlotInfo",
  "GetLootSlotLink",
  "GetNumLootItems",
  "LootSlot",
  "CloseLoot",

  -- WoW API - Quest Functions
  "GetNumQuestLogEntries",
  "GetQuestLogTitle",
  "GetQuestLogRewardXP",
  "GetQuestLogRewardMoney",
  "GetNumQuestLogRewards",
  "GetQuestLogRewardInfo",
  "GetNumQuestLogChoices",
  "GetQuestLogChoiceInfo",
  "QuestLogFrame",

  -- WoW API - Reputation Functions
  "GetNumFactions",
  "GetFactionInfo",
  "CollapseFactionHeader",
  "ExpandFactionHeader",
  "SetWatchedFactionIndex",

  -- WoW API - Spell Functions
  "GetSpellInfo",
  "GetSpellLink",
  "GetSpellTexture",

  -- WoW API - Talent Functions
  "GetNumTalentTabs",
  "GetTalentTabInfo",
  "GetNumTalents",
  "GetTalentInfo",

  -- WoW API - Buff/Debuff Functions
  "UnitBuff",
  "UnitDebuff",
  "UnitAura",

  -- WoW API - Combat Log
  "CombatLogGetCurrentEventInfo",
  "CombatLog_Object_IsA",

  -- WoW API - Achievement Functions
  "GetAchievementInfo",
  "GetAchievementLink",
  "GetAchievementCriteriaInfo",
  "GetNumCompletedAchievements",

  -- WoW API - Guild Functions
  "GuildRoster",
  "GetNumGuildMembers",
  "GetGuildRosterInfo",

  -- WoW API - Trade Skill Functions
  "GetTradeSkillLine",
  "GetNumTradeSkills",
  "GetTradeSkillInfo",

  -- WoW API - Addon Functions
  "GetAddOnMetadata",
  "GetAddOnInfo",
  "IsAddOnLoaded",
  "LoadAddOn",
  "EnableAddOn",
  "DisableAddOn",

  -- WoW API - System Functions
  "GetBuildInfo",
  "GetLocale",
  "GetTime",
  "GetFramerate",
  "GetNetStats",
  "GetCVar",
  "SetCVar",
  "GetCVarBool",
  "RegisterCVar",
  "ReloadUI",
  "ShowUIPanel",
  "HideUIPanel",
  "ToggleGameMenu",
  "StaticPopup_Show",
  "StaticPopup_Hide",
  "PlaySound",
  "PlaySoundFile",
  "StopSound",

  -- WoW API - Secure Functions
  "hooksecurefunc",
  "issecurevariable",
  "securecall",
  "InCombatLockdown",
  "RegisterStateDriver",
  "UnregisterStateDriver",

  -- WoW API - Event Functions
  "GetCurrentEventID",

  -- WoW API - Tooltip
  "GameTooltip",
  "ItemRefTooltip",
  "GameTooltip_SetDefaultAnchor",

  -- WoW API - Cursor
  "GetCursorPosition",
  "SetCursor",
  "ResetCursor",

  -- WoW API - Misc
  "GetScreenWidth",
  "GetScreenHeight",
  "CopyTable",
  "tContains",
  "strtrim",
  "Mixin",
  "CreateFromMixins",
  "CreateAndInitFromMixin",
  "nop",
  "ClearOverrideBindings",
  "SetOverrideBinding",
  "SetOverrideBindingClick",

  -- WoW Global Tables
  "ITEM_QUALITY_COLORS",
  "RAID_CLASS_COLORS",
  "ChatTypeInfo",
  "ChatTypeGroup",
  "CHAT_CATEGORY_LIST",
  "CHAT_CONFIG_CHAT_LEFT",
  "SlashCmdList",
  "SLASH_RELOAD1",
  "hash_SlashCmdList",
  "NUM_CHAT_WINDOWS",

  -- WoW Global Frames
  "AuctionFrame",
  "AuctionsItemButton",
  "BankFrame",
  "ClassTrainerFrame",
  "ContainerFrame1",
  "FriendsFrame",
  "GossipFrame",
  "GuildFrame",
  "LootFrame",
  "MailFrame",
  "MerchantFrame",
  "PetitionFrame",
  "PlayerFrame",
  "QuestFrame",
  "SpellBookFrame",
  "TargetFrame",
  "TradeFrame",
  "TradeSkillFrame",
  "InterfaceOptionsFrame",
  "SettingsPanel",
  "VideoOptionsFrame",

  -- WoW Template Mixins (may be nil in 3.3.5)
  "BackdropTemplateMixin",
  "SettingsListMixin",
  "SettingsSelectionPopoutMixin",

  -- WoW Backdrop
  "BACKDROP_TOOLTIP_16_16",
  "BACKDROP_DIALOG_32_32",

  -- Blizzard Chat Functions
  "FCF_OpenTemporaryWindow",
  "FCF_Close",
  "FCF_SetLocked",
  "FCF_Tab_OnClick",
  "FCF_ResetChatWindows",
  "FCFManager_GetNumDedicatedFrames",
  "ChatFrame_OnHyperlinkShow",

  -- C_* API namespaces
  "C_Timer",
  "C_ChatInfo",
  "C_Club",

  -- LibStub and Ace libraries
  "LibStub",

  -- Debugging
  "DevTools_Dump",
  "debugprofilestop",
}

-- Globals that the addon may SET (write to)
globals = {
  -- Addon namespace (set in XML/TOC)
  "CleanerChat",
  "CleanerChatDB",
  "CleanerChatGlassDB",

  -- Glass UI globals
  "Glass",

  -- Polyfills the addon creates
  "BackdropTemplateMixin",
  "Mixin",
  "CreateFromMixins",
  "nop",
  "tContains",
  "wipe",
  "CopyTable",
  "C_Timer",
  "SettingsListMixin",
  "SettingsSelectionPopoutMixin",

  -- SlashCmdList entries
  "SlashCmdList",
  "SLASH_CLEANERCHAT1",
  "SLASH_CLEANERCHAT2",
  "SLASH_CC1",
  "SLASH_CCDEBUG1",
  "SLASH_GLASS1",
}

-- Per-file overrides
files = {
  -- Locale files use L as a table that gets populated
  ["Locale/*.lua"] = {
    globals = { "L" },
    ignore = { "211" },  -- Unused local variable (L is used by AceLocale)
  },

  -- Compat layer creates global polyfills
  ["GlassUI/compat.lua"] = {
    globals = {
      "BackdropTemplateMixin",
      "Mixin",
      "CreateFromMixins",
      "CreateAndInitFromMixin",
      "nop",
      "tContains",
      "wipe",
      "CopyTable",
      "C_Timer",
      "SettingsListMixin",
      "SettingsSelectionPopoutMixin",
      "Enum",
    },
  },

  -- Core creates the addon namespace
  ["Core/Core.lua"] = {
    globals = { "ns" },
  },

  -- Private.lua sets up shared state
  ["Core/Private.lua"] = {
    globals = { "ns" },
  },

  -- Init creates Glass namespace
  ["GlassUI/init.lua"] = {
    globals = { "Glass" },
  },
}
