local M = {}
-- local actions = require "telescope.actions"
-- local action_state = require "telescope.actions.state"
local themes = require "telescope.themes"
local builtin = require "telescope.builtin"

local function dropdown_opts()
  return themes.get_dropdown {
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
end

local function ivy_opts()
  return themes.get_ivy {
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
end

function M.code_actions()
  local opts = dropdown_opts()
  builtin.lsp_code_actions(themes.get_dropdown(opts))
end

function M.codelens_actions()
  local opts = dropdown_opts()
  builtin.lsp_codelens_actions(themes.get_dropdown(opts))
end

function M.lsp_definitions()
  local opts = ivy_opts()
  builtin.lsp_definitions(opts)
end
-- show refrences to this using language server
function M.lsp_references()
  local opts = ivy_opts()
  builtin.lsp_references(opts)
end
-- show implementations of the current thingy using language server
function M.lsp_implementations()
  local opts = ivy_opts()
  builtin.lsp_implementations(opts)
end

function M.installed_plugins()
  builtin.find_files {
    cwd = join_paths(get_runtime_dir(), "site", "pack", "packer"),
  }
end

function M.project_search()
  builtin.find_files {
    -- previewer = true,
    -- layout_strategy = "vertical",
    cwd = require("lspconfig/util").root_pattern ".git"(vim.fn.expand "%:p"),
  }
end

function M.find_buffers()
  local opts = dropdown_opts()
  builtin.buffers(opts)
end

function M.curbuf()
  local opts = dropdown_opts()
  builtin.current_buffer_fuzzy_find(opts)
end

function M.git_status()
  local opts = dropdown_opts()
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

  local opts = dropdown_opts()
  opts.cwd = path
  opts.file_ignore_patterns = {
    "^[.]vale/",
  }
  builtin.git_files(opts)
end

function M.live_grep()
  local opts = ivy_opts()
  opts.file_ignore_patterns = {
    "vendor/*",
    "node_modules",
    "%.jpg",
    "%.jpeg",
    "%.png",
    "%.svg",
    "%.otf",
    "%.ttf",
  }
  require("telescope.builtin").live_grep(opts)
end

function M.grep_cursor_string()
  local visual_selection = function()
    local save_previous = vim.fn.getreg "a"
    vim.api.nvim_command 'silent! normal! "ayiw'
    local selection = vim.fn.trim(vim.fn.getreg "a")
    vim.fn.setreg("a", save_previous)
    return vim.fn.substitute(selection, [[\n]], [[\\n]], "g")
  end
  local opts = ivy_opts()
  opts.default_text = visual_selection()
  opts.file_ignore_patterns = {
    "vendor/*",
    "node_modules",
    "%.jpg",
    "%.jpeg",
    "%.png",
    "%.svg",
    "%.otf",
    "%.ttf",
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
  local opts = dropdown_opts()
  require("telescope").extensions.file_browser.file_browser(opts)
end

function M.projects()
  local opts = dropdown_opts()
  opts.initial_mode = "normal"
  require("telescope").extensions.projects.projects(opts)
end

return M
