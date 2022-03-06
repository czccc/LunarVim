local M = {}
local colors = require "lvim.core.lualine.colors"
local kind = require "user.lsp_kind"

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand "%:t") ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  hide_small = function()
    return vim.fn.winwidth(0) > 150
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand "%:p:h"
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

local components = require "lvim.core.lualine.components"

components.filename = {
  "filename",
  file_status = true, -- Displays file status (readonly status, modified status)
  path = 1,
  shorting_target = 40, -- Shortens path to leave 40 spaces in the window
  symbols = {
    modified = "[+]", -- Text to show when the file is modified.
    readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
    unnamed = "[No Name]", -- Text to show for unnamed buffers.
  },
  cond = conditions.buffer_not_empty,
  color = { gui = "bold" },
}
components.branch1 = {
  "b:gitsigns_head",
  icon = " ",
  color = { fg = colors.blue, gui = "bold" },
  cond = function()
    return conditions.check_git_workspace() and conditions.hide_in_width()
  end,
  padding = 0,
}
components.clock = {
  function()
    return kind.icons.clock .. os.date "%H:%M"
  end,
  cond = conditions.hide_in_width,
}

components.lsp_progress = {
  function()
    local messages = vim.lsp.util.get_progress_messages()
    if #messages == 0 then
      return ""
    end
    local status = {}
    for _, msg in pairs(messages) do
      table.insert(status, (msg.percentage or 0) .. "%% " .. (msg.title or ""))
    end
    -- local spinners = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    -- local spinners = { " ", " ", " ", " ", " ", " ", " ", " ", " ", " " }
    -- local spinners = { " ", " ", " ", " ", " ", " ", " ", " ", " " }
    local spinners = {
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
    }
    local ms = vim.loop.hrtime() / 1000000
    local frame = math.floor(ms / 60) % #spinners
    return spinners[frame + 1] .. " " .. table.concat(status, " | ")
  end,
  cond = conditions.hide_small,
}

vim.cmd [[autocmd User LspProgressUpdate let &ro = &ro]]

components.mode1 = {
  function()
    local mod = vim.fn.mode()
    local _time = os.date "*t"
    local selector = math.floor(_time.hour / 8) + 1
    local normal_icons = {
      "  ",
      "  ",
      "  ",
    }
    if mod == "n" or mod == "no" or mod == "nov" then
      return normal_icons[selector]
    elseif mod == "i" or mod == "ic" or mod == "ix" then
      local insert_icons = {
        "  ",
        "  ",
        "  ",
      }
      return insert_icons[selector]
    elseif mod == "V" or mod == "v" or mod == "vs" or mod == "Vs" or mod == "cv" then
      local verbose_icons = {
        " 勇",
        "  ",
        "  ",
      }
      return verbose_icons[selector]
    elseif mod == "c" or mod == "ce" then
      local command_icons = {
        "  ",
        "  ",
        "  ",
      }

      return command_icons[selector]
    elseif mod == "r" or mod == "rm" or mod == "r?" or mod == "R" or mod == "Rc" or mod == "Rv" or mod == "Rv" then
      local replace_icons = {
        "  ",
        "  ",
        "  ",
      }
      return replace_icons[selector]
    end
    return normal_icons[selector]
  end,
  color = { fg = colors.blue, gui = "bold" },
  -- padding = { left = 1, right = 0 },
}

components.fileformat = {
  "fileformat",
  icons_enabled = true,
  symbols = {
    unix = "LF",
    dos = "CRLF",
    mac = "CR",
  },
  fmt = string.upper,
  color = { fg = colors.green },
  cond = conditions.hide_in_width,
}
components.filesize = {
  function()
    local function format_file_size(file)
      local size = vim.fn.getfsize(file)
      if size <= 0 then
        return ""
      end
      local sufixes = { "b", "k", "m", "g" }
      local i = 1
      while size > 1024 do
        size = size / 1024
        i = i + 1
      end
      return string.format("%.1f%s", size, sufixes[i])
    end
    local file = vim.fn.expand "%:p"
    if string.len(file) == 0 then
      return ""
    end
    return format_file_size(file)
  end,
  cond = conditions.hide_in_width,
}

M.config = function() -- Config
  local config = {
    options = {
      icons_enabled = true,
      -- Disable sections and component separators
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      theme = nil,
      disabled_filetypes = { "dashboard", "alpha" },
    },
    sections = {
      -- these are to remove the defaults
      lualine_a = {},
      lualine_b = {},
      lualine_c = {
        components.mode1,
        components.branch1,
        components.filename,
        components.diff,
        components.python_env,
        components.lsp_progress,
        "%=",
      },
      lualine_x = {
        components.diagnostics,
        components.treesitter,
        components.lsp,
        components.filetype,
        components.fileformat,
        components.filesize,
        components.location,
        components.clock,
        components.scrollbar,
      },
      lualine_y = {},
      lualine_z = {},
    },
    inactive_sections = {
      -- these are to remove the defaults
      lualine_a = {},
      lualine_b = {},
      lualine_c = { components.filename },
      lualine_x = { components.location },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    extensions = {
      {
        sections = {
          lualine_c = {
            {
              function()
                return vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
              end,
              color = { gui = "bold" },
            },
          },
        },
        filetypes = { "NvimTree" },
      },
      {
        sections = {
          lualine_c = {
            {
              function()
                return "ToggleTerm #" .. vim.b.toggle_number
              end,
              color = { fg = colors.blue, gui = "bold" },
            },
          },
        },
        filetypes = { "toggleterm" },
      },
      {
        sections = { lualine_c = { { "filetype", color = { gui = "bold" } } } },
        filetypes = { "Outline" },
      },
    },
  }

  -- Now don't forget to initialize lualine
  lvim.builtin.lualine.options = config.options
  lvim.builtin.lualine.sections = config.sections
  lvim.builtin.lualine.inactive_sections = config.inactive_sections
  lvim.builtin.lualine.extensions = config.extensions
end

return M
