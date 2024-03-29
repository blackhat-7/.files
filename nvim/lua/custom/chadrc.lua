---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
-- local highlights = require "custom.highlights"

M.ui = {
    transparency = true,
    lsp_semantic_tokens = true, -- needs nvim v0.9, just adds highlight groups for lsp semantic tokens
	--
 --    theme = "tokyonight",
 --    theme_toggle = { "catppuccin", "one_light" },
 --    hl_override = highlights.override,
 --    hl_add = highlights.add,
 --    cmp = {
	-- style = "atom",
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
