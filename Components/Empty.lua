--[[

	The MIT License (MIT)

	Copyright (c) 2024 Lars Norberg

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.

--]]
local Addon, ns = ...

local Module = ns:NewModule("Empty")

-- Lua API
local ipairs = ipairs
local string_match = string.match

-- Suppress chat lines that contain no actual text (empty or whitespace only).
-- Some servers and cross-faction relay addons emit these "ghost" messages
-- even though players can't normally send an empty message.
Module.OnChatEvent = function(self, chatFrame, event, message, author, ...)
	if (not message) or (not string_match(message, "%S")) then
		return true
	end
end

local onChatEventProxy = function(...)
	return Module:OnChatEvent(...)
end

local events = {
	"CHAT_MSG_CHANNEL",
	"CHAT_MSG_SAY",
	"CHAT_MSG_YELL",
	"CHAT_MSG_GUILD",
	"CHAT_MSG_OFFICER",
	"CHAT_MSG_PARTY",
	"CHAT_MSG_PARTY_LEADER",
	"CHAT_MSG_RAID",
	"CHAT_MSG_RAID_LEADER",
	"CHAT_MSG_RAID_WARNING",
	"CHAT_MSG_WHISPER",
	"CHAT_MSG_WHISPER_INFORM"
}

Module.OnEnable = function(self)
	for _,event in ipairs(events) do
		self:RegisterMessageEventFilter(event, onChatEventProxy)
	end
end

Module.OnDisable = function(self)
	for _,event in ipairs(events) do
		self:UnregisterMessageEventFilter(event, onChatEventProxy)
	end
end
