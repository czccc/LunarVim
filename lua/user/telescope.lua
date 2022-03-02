local M = {}
-- local actions = require "telescope.actions"
-- local action_state = require "telescope.actions.state"
local themes = require "telescope.themes"
local builtin = require "telescope.builtin"

-- beautiful default layout for telescope prompt
function M.layout_config()
  return {
    width = 0.90,
    height = 0.85,
    preview_cutoff = 120,
    prompt_position = "bottom",
    horizontal = {
      preview_width = function(_, cols, _)
        if cols > 200 then
          return math.floor(cols * 0.5)
        else
          return math.floor(cols * 0.6)
        end
      end,
    },
    vertical = {
      width = 0.9,
      height = 0.95,
      preview_height = 0.5,
    },

    flex = {
      horizontal = {
        preview_width = 0.9,
      },
    },
  }
end

-- another file string search
function M.find_string()
  local opts = {
    border = true,
    previewer = false,
    shorten_path = false,
    layout_strategy = "flex",
    layout_config = {
      width = 0.9,
      height = 0.8,
      horizontal = { width = { padding = 0.15 } },
      vertical = { preview_height = 0.75 },
    },
    file_ignore_patterns = {
      "vendor/*",
      "node_modules",
      "%.jpg",
      "%.jpeg",
      "%.png",
      "%.svg",
      "%.otf",
      "%.ttf",
    },
  }
  builtin.live_grep(opts)
end

-- show code actions in a fancy floating window
function M.code_actions()
  local opts = {
    winblend = 15,
    layout_config = {
      prompt_position = "top",
      width = 80,
      height = 12,
    },
    borderchars = {
      prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
      results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
      preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    },
    border = {},
    previewer = false,
    shorten_path = false,
  }
  builtin.lsp_code_actions(themes.get_dropdown(opts))
end

function M.codelens_actions()
  local opts = {
    winblend = 15,
    layout_config = {
      prompt_position = "top",
      width = 80,
      height = 12,
    },
    borderchars = {
      prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
      results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
      preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    },
    border = {},
    previewer = false,
    shorten_path = false,
  }
  builtin.lsp_codelens_actions(themes.get_dropdown(opts))
end

-- show definitions to this using language server
function M.lsp_definitions()
  local opts = {
    layout_strategy = "bottom_pane",
    layout_config = {
      height = 25,
    },
    border = true,
    borderchars = {
      prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
      results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
      preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    },
    sorting_strategy = "ascending",
    ignore_filename = false,
  }
  builtin.lsp_definitions(opts)
end
-- show refrences to this using language server
function M.lsp_references()
  local opts = {
    layout_strategy = "bottom_pane",
    layout_config = {
      height = 25,
    },
    border = true,
    borderchars = {
      prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
      results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
      preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    },
    sorting_strategy = "ascending",
    ignore_filename = false,
  }
  builtin.lsp_references(opts)
end
-- show implementations of the current thingy using language server
function M.lsp_implementations()
  local opts = {
    layout_strategy = "bottom_pane",
    layout_config = {
      height = 25,
    },
    border = true,
    borderchars = {
      prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
      results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
      preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    },
    sorting_strategy = "ascending",
    ignore_filename = false,
  }
  builtin.lsp_implementations(opts)
end

function M.installed_plugins()
  builtin.find_files {
    cwd = join_paths(os.getenv "LUNARVIM_RUNTIME_DIR", "site", "pack", "packer"),
  }
end

function M.project_search()
  builtin.find_files {
    previewer = false,
    layout_strategy = "vertical",
    cwd = require("lspconfig/util").root_pattern ".git"(vim.fn.expand "%:p"),
  }
end

function M.project_oldfiles()
  builtin.oldfiles {
    previewer = false,
    layout_strategy = "vertical",
    cwd = require("lspconfig/util").root_pattern ".git"(vim.fn.expand "%:p"),
  }
end

function M.find_buffers()
  local opts = themes.get_dropdown {
    winblend = 10,
    previewer = false,
    shorten_path = false,
    border = {},
    layout_config = {
      width = 0.45,
      prompt_position = "top",
    },
  }
  builtin.buffers(opts)
end

function M.curbuf()
  local opts = themes.get_dropdown {
    winblend = 10,
    previewer = false,
    shorten_path = false,
    borderchars = {
      prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
      results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
      preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    },
    border = {},
    layout_config = {
      width = 0.45,
      prompt_position = "top",
    },
  }
  builtin.current_buffer_fuzzy_find(opts)
end

function M.git_status()
  local opts = themes.get_dropdown {
    winblend = 10,
    previewer = false,
    shorten_path = false,
    borderchars = {
      prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
      results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
      preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    },
    border = {},
    layout_config = {
      width = 0.45,
      prompt_position = "top",
    },
  }

  -- Can change the git icons using this.
  -- opts.git_icons = {
  --   changed = "M"
  -- }

  builtin.git_status(opts)
end

function M.search_only_certain_files()
  builtin.find_files {
    find_command = {
      "rg",
      "--files",
      "--type",
      vim.fn.input "Type: ",
    },
  }
end

function M.git_files()
  local path = vim.fn.expand "%:h"
  if path == "" then
    path = nil
  end

  local width = 0.45
  if path and string.find(path, "sourcegraph.*sourcegraph", 1, false) then
    width = 0.6
  end

  local opts = themes.get_dropdown {
    winblend = 5,
    previewer = false,
    shorten_path = false,
    borderchars = {
      prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
      results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
      preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    },
    border = {},
    cwd = path,
    layout_config = {
      width = width,
      prompt_position = "top",
    },
  }

  opts.file_ignore_patterns = {
    "^[.]vale/",
  }
  builtin.git_files(opts)
end

function M.grep_cursor_string()
  local visual_selection = function()
    local save_previous = vim.fn.getreg "a"
    vim.api.nvim_command 'silent! normal! "ayiw'
    local selection = vim.fn.trim(vim.fn.getreg "a")
    vim.fn.setreg("a", save_previous)
    return vim.fn.substitute(selection, [[\n]], [[\\n]], "g")
  end
  local opts = require("telescope.themes").get_ivy {
    default_text = visual_selection(),
    file_ignore_patterns = {
      "vendor/*",
      "node_modules",
      "%.jpg",
      "%.jpeg",
      "%.png",
      "%.svg",
      "%.otf",
      "%.ttf",
    },
  }
  require("telescope.builtin").live_grep(opts)
end

function M.workspace_frequency()
  local opts = {
    default_text = ":CWD:",
  }
  require("telescope").extensions.frecency.frecency(opts)
end

function M.file_browser()
  local opts = {}
  require("telescope").extensions.file_browser.file_browser(opts)
end

return M
