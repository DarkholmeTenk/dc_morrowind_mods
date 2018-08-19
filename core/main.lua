local debug = require("darkcraft/core/debug")
local mod = require("darkcraft/core/mod")
local ui = require("darkcraft/core/ui")

local dc = {}

dc.debug = debug

dc.getMod = mod

dc.ui = ui

_G.darkcraft = dc

return dc