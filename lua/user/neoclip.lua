local M = {}
local Log = require "lvim.core.log"

local function is_whitespace(line)
  return vim.fn.match(line, [[^\s*$]]) ~= -1
end

local function all(tbl, check)
  for _, entry in ipairs(tbl) do
    if not check(entry) then
      return false
    end
  end
  return true
end

M.config = function()
  local status_ok, neoclip = pcall(require, "neoclip")
  if not status_ok then
    Log:warn "neoclip: not found"
    return
  end

  neoclip.setup {
    history = 50,
    enable_persistent_history = true,
    db_path = vim.fn.stdpath "data" .. "/neoclip.sqlite3",
    default_register = { '"', "+", "*" },
    filter = function(data)
      return not all(data.event.regcontents, is_whitespace)
    end,
    -- keys = {
    --   telescope = {
    --     i = { select = "<c-p>", paste = "<CR>", paste_behind = "<c-k>" },
    --     n = { select = "p", paste = "<CR>", paste_behind = "P" },
    --   },
    -- },
  }
  local function clip()
    local opts = {
      winblend = 10,
      layout_strategy = "flex",
      layout_config = {
        prompt_position = "top",
        width = 0.8,
        height = 0.6,
        horizontal = { width = { padding = 0.15 } },
        vertical = { preview_height = 0.70 },
      },
      borderchars = {
        prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
        results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
        preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      },
      border = {},
      shorten_path = false,
    }
    local dropdown = require("telescope.themes").get_dropdown(opts)
    require("telescope").extensions.neoclip.default(dropdown)
  end
  local whk_status, whk = pcall(require, "which-key")
  if not whk_status then
    Log:warn "neoclip: whichkey not found"
    return
  end
  whk.register {
    ["<leader>y"] = { clip, "Neoclip" },
  }
end

return M
