--[[

	OptionsSkin.lua

	Re-skins the /cc options window (a stock AceConfigDialog "Frame" + "TreeGroup")
	into a dark, translucent "Glass" panel with the gold CleanerChat accent
	(#DFBA69), so the configuration UI matches the addon's own identity instead
	of looking like a generic Ace3 backport.

	Everything here is purely cosmetic and fully defensive: each step is guarded
	so a missing sub-frame (e.g. on a future Ace3 update) is simply skipped and
	never breaks the actual options. The underlying options table is untouched.

--]]
local Addon, ns = ...

-- Palette ------------------------------------------------------------------

-- Gold accent, matches the |cffDFBA69CleanerChat|r title in the .toc.
local GOLD = { r = 223 / 255, g = 186 / 255, b = 105 / 255 }

-- Near-black translucent glass.
local PANEL = { r = 0.035, g = 0.035, b = 0.045, a = 0.95 }
local INNER = { r = 0.065, g = 0.065, b = 0.080, a = 0.88 }
local BTN_BG = { r = 0.12, g = 0.12, b = 0.14, a = 0.90 }

local SOLID = "Interface\\Buttons\\WHITE8x8"

-- A clean 1px-bordered flat backdrop.
local GlassBackdrop = {
	bgFile = SOLID,
	edgeFile = SOLID,
	tile = false,
	edgeSize = 1,
	insets = { left = 1, right = 1, top = 1, bottom = 1 },
}

-- Lua/WoW API locals
local ipairs = ipairs
local type = type
local CLOSE = CLOSE or "Close"

-- Helpers ------------------------------------------------------------------

local function applyGlass(frame, bg, borderAlpha)
	if (not frame) or (not frame.SetBackdrop) then return end
	frame:SetBackdrop(GlassBackdrop)
	frame:SetBackdropColor(bg.r, bg.g, bg.b, bg.a)
	frame:SetBackdropBorderColor(GOLD.r, GOLD.g, GOLD.b, borderAlpha or 0.35)
end

-- Hide a button's default template textures (guarded individually).
local function stripButtonTextures(btn)
	local getters = { "GetNormalTexture", "GetPushedTexture", "GetHighlightTexture", "GetDisabledTexture" }
	for _, getter in ipairs(getters) do
		if (btn[getter]) then
			local tex = btn[getter](btn)
			if (tex and tex.SetTexture) then tex:SetTexture(nil) end
		end
	end
end

-- Flat dark button with a gold hover + gold label (used for Close).
local function styleButton(btn)
	if (not btn) or (btn.ccSkinned) then return end
	btn.ccSkinned = true

	stripButtonTextures(btn)

	if (not btn.ccBg) then
		-- Gold edge underneath (full cover), dark fill on top inset by 1px so
		-- only a 1px gold frame shows around the edges.
		local border = btn:CreateTexture(nil, "BACKGROUND")
		border:SetTexture(SOLID)
		border:SetAllPoints()
		border:SetVertexColor(GOLD.r, GOLD.g, GOLD.b, 0.40)
		btn.ccBorder = border

		local bg = btn:CreateTexture(nil, "BORDER")
		bg:SetTexture(SOLID)
		bg:SetPoint("TOPLEFT", 1, -1)
		bg:SetPoint("BOTTOMRIGHT", -1, 1)
		bg:SetVertexColor(BTN_BG.r, BTN_BG.g, BTN_BG.b, BTN_BG.a)
		btn.ccBg = bg
	end

	local label = btn.GetFontString and btn:GetFontString()
	if (label) then
		label:SetTextColor(GOLD.r, GOLD.g, GOLD.b)
	end

	btn:HookScript("OnEnter", function(self)
		if (self.ccBg) then self.ccBg:SetVertexColor(GOLD.r * 0.30, GOLD.g * 0.28, GOLD.b * 0.20, 0.95) end
		if (self.ccBorder) then self.ccBorder:SetVertexColor(GOLD.r, GOLD.g, GOLD.b, 0.85) end
	end)
	btn:HookScript("OnLeave", function(self)
		if (self.ccBg) then self.ccBg:SetVertexColor(BTN_BG.r, BTN_BG.g, BTN_BG.b, BTN_BG.a) end
		if (self.ccBorder) then self.ccBorder:SetVertexColor(GOLD.r, GOLD.g, GOLD.b, 0.40) end
	end)
end

-- Give a tree nav button a gold hover/selected highlight.
local function skinTreeButton(button)
	if (not button) or (button.ccSkinned) then return end
	button.ccSkinned = true
	local hl = button.GetHighlightTexture and button:GetHighlightTexture()
	if (hl) then
		hl:SetTexture(SOLID)
		hl:SetVertexColor(GOLD.r, GOLD.g, GOLD.b, 0.22)
	end
end

-- Skin the left category tree + its content border.
local function skinTree(tree)
	if (not tree) then return end

	applyGlass(tree.treeframe, INNER, 0.30)
	applyGlass(tree.border, INNER, 0.30)

	-- New buttons are pooled/created lazily; skin them as they appear.
	if (not tree.ccButtonHook) and (tree.CreateButton) then
		tree.ccButtonHook = true
		local orig = tree.CreateButton
		tree.CreateButton = function(self)
			local b = orig(self)
			skinTreeButton(b)
			return b
		end
	end
	if (tree.buttons) then
		for _, b in ipairs(tree.buttons) do
			skinTreeButton(b)
		end
	end
end

-- Find the TreeGroup child of the window (defensive scan).
local function findTree(widget)
	if (not widget) or (not widget.children) then return nil end
	for _, child in ipairs(widget.children) do
		if (type(child) == "table") and (child.treeframe) then
			return child
		end
	end
	return nil
end

-- Main entry ---------------------------------------------------------------

-- Re-skin the AceConfigDialog window widget. Safe to call on every open.
function ns.SkinOptionsWindow(widget)
	if (not widget) then return end
	local f = widget.frame
	if (not f) then return end

	-- Main window: dark glass + gold border.
	applyGlass(f, PANEL, 0.85)

	-- Hide the default parchment header (centre + side caps).
	if (widget.titlebg) then widget.titlebg:Hide() end
	if (not f.ccHeaderHidden) then
		f.ccHeaderHidden = true
		for _, region in ipairs({ f:GetRegions() }) do
			if (region.GetObjectType) and (region:GetObjectType() == "Texture") then
				local tex = region.GetTexture and region:GetTexture()
				if (type(tex) == "string") and (tex:find("UI%-DialogBox%-Header")) then
					region:Hide()
				end
			end
		end
	end

	-- Custom gold title bar + accent line.
	if (not f.ccTitleBar) then
		local bar = f:CreateTexture(nil, "ARTWORK")
		bar:SetTexture(SOLID)
		bar:SetPoint("TOPLEFT", 2, -2)
		bar:SetPoint("TOPRIGHT", -2, -2)
		bar:SetHeight(30)
		bar:SetVertexColor(GOLD.r * 0.16, GOLD.g * 0.14, GOLD.b * 0.09, 0.95)
		f.ccTitleBar = bar

		local line = f:CreateTexture(nil, "OVERLAY")
		line:SetTexture(SOLID)
		line:SetPoint("TOPLEFT", bar, "BOTTOMLEFT")
		line:SetPoint("TOPRIGHT", bar, "BOTTOMRIGHT")
		line:SetHeight(1)
		line:SetVertexColor(GOLD.r, GOLD.g, GOLD.b, 0.90)
		f.ccTitleLine = line
	end

	-- Title text: gold, larger, sitting on the bar.
	if (widget.titletext) then
		local tt = widget.titletext
		tt:SetParent(f)
		tt:ClearAllPoints()
		tt:SetPoint("TOP", f, "TOP", 0, -9)
		tt:SetDrawLayer("OVERLAY")
		tt:SetTextColor(GOLD.r, GOLD.g, GOLD.b)
		if (tt.GetFont and tt.SetFont) then
			local font = tt:GetFont()
			if (font) then tt:SetFont(font, 16, "OUTLINE") end
		end
	end

	-- Status text (reload notice) in gold; darken its little panel.
	if (widget.statustext) then
		widget.statustext:SetTextColor(GOLD.r, GOLD.g, GOLD.b)
		local statusbg = widget.statustext:GetParent()
		if (statusbg) and (statusbg.SetBackdrop) and (statusbg ~= f) then
			applyGlass(statusbg, INNER, 0.25)
		end
	end

	-- Close button (and any other UIPanel buttons on the frame).
	if (not f.ccButtonsSkinned) then
		f.ccButtonsSkinned = true
		for _, child in ipairs({ f:GetChildren() }) do
			if (child.GetObjectType) and (child:GetObjectType() == "Button") then
				if (child.GetText) and (child:GetText() == CLOSE) then
					styleButton(child)
				end
			end
		end
	end

	-- Left category tree + content border.
	skinTree(findTree(widget))
end
