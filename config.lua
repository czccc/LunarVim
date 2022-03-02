-- general
lvim.leader = "space"
-- lvim.format_on_save = false
lvim.format_on_save = true
lvim.colorscheme = "onedarker"
require("user.options").config()

lvim.log.level = "warn"
vim.lsp.set_log_level "warn"

-- user plugins
lvim.user = {}
lvim.user.lastplace = { active = true } -- change to false if you are jumping to future
lvim.user.persistence = { active = false } -- change to false if you don't want persistence
lvim.user.auto_session = { active = true }
lvim.user.fancy_statusline = { active = true } -- enable/disable fancy statusline
lvim.user.fancy_dashboard = { active = true } -- enable/disable fancy dashboard
lvim.user.fancy_wild_menu = { active = true } -- enable/disable use wilder.nvim
lvim.user.fancy_rename = { active = true } -- enable/disable custom rename
lvim.user.fancy_diff = { active = true } -- enable/disable fancier git diff
lvim.user.neoscroll = { active = true } -- smooth scrolling
lvim.user.nonumber_unfocus = false -- diffrentiate between focused and non focused windows
lvim.user.cursorline = { active = false } -- use a bit fancier cursorline
lvim.user.hop_motion = { active = true } -- use hop motion providers
lvim.user.sidebar = { active = true } -- enable/disable sidebar

-- Builtin
-- =========================================
require("user.builtin").config()

-- StatusLine
-- =========================================
if lvim.user.fancy_statusline.active then
  require("user.lualine").config()
else
  lvim.builtin.lualine.style = "lvim"
end

-- Debugging
-- =========================================
if lvim.builtin.dap.active then
  require("user.dap").config()
end

-- Language Specific
-- =========================================
vim.list_extend(lvim.lsp.override, { "rust_analyzer", "tsserver", "pyright", "sumneko_lua", "jsonls" })
require("user.null_ls").config()

-- Additional Plugins
-- =========================================
require("user.plugins").config()

-- Autocommands
-- =========================================
require("user.autocommands").config()

-- Additional keybindings
-- =========================================
require("user.keybindings").config()
-- require("user.whichkey").config()
