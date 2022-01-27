local M = {}

M.config = function()
  local kind = require "user.lsp_kind"

  -- Notify
  -- =========================================
  lvim.builtin.notify.active = true

  -- Barbar or Bufferline
  -- =========================================
  if lvim.user.fancy_bufferline.active then
    lvim.builtin.bufferline.active = false
  end

  vim.g.indent_blankline_char = "│"
  -- CMP
  -- =========================================
  lvim.builtin.cmp.sources = {
    { name = "nvim_lsp" },
    { name = "cmp_tabnine", max_item_count = 3 },
    { name = "buffer", max_item_count = 5, keyword_length = 5 },
    { name = "path", max_item_count = 5 },
    { name = "luasnip", max_item_count = 3 },
    { name = "nvim_lua" },
    { name = "calc" },
    { name = "emoji" },
    { name = "treesitter" },
    { name = "crates" },
  }
  lvim.builtin.cmp.experimental = {
    ghost_text = true,
    native_menu = false,
    -- custom_menu = true,
  }
  lvim.builtin.cmp.formatting.kind_icons = kind.cmp_kind
  lvim.builtin.cmp.formatting.source_names = {
    buffer = "(Buffer)",
    nvim_lsp = "(LSP)",
    luasnip = "(Snip)",
    treesitter = "",
    nvim_lua = "(NvLua)",
    spell = "暈",
    emoji = "",
    path = "",
    calc = "",
    cmp_tabnine = "ﮧ",
  }

  -- Comment
  -- =========================================
  -- integrate with nvim-ts-context-commentstring
  lvim.builtin.comment.pre_hook = function(ctx)
    if not vim.tbl_contains({ "typescript", "typescriptreact" }, vim.bo.ft) then
      return
    end

    local comment_utils = require "Comment.utils"
    local type = ctx.ctype == comment_utils.ctype.line and "__default" or "__multiline"

    local location
    if ctx.ctype == comment_utils.ctype.block then
      location = require("ts_context_commentstring.utils").get_cursor_location()
    elseif ctx.cmotion == comment_utils.cmotion.v or ctx.cmotion == comment_utils.cmotion.V then
      location = require("ts_context_commentstring.utils").get_visual_start_location()
    end

    return require("ts_context_commentstring.internal").calculate_commentstring {
      key = type,
      location = location,
    }
  end

  -- Dashboard
  -- =========================================
  lvim.builtin.dashboard.active = not lvim.user.fancy_dashboard.active
  if not lvim.user.fancy_dashboard.active then
    lvim.builtin.dashboard.custom_section["m"] = {
      description = { "  Marks              " },
      command = "Telescope marks",
    }
  end

  -- LSP
  -- =========================================
  lvim.lsp.automatic_servers_installation = true
  lvim.lsp.float.focusable = true
  lvim.lsp.diagnostics.update_in_insert = false
  lvim.lsp.diagnostics.float.border = "rounded"
  lvim.lsp.diagnostics.float.focusable = false
  lvim.lsp.diagnostics.signs.values = {
    { name = "DiagnosticSignError", text = kind.icons.error },
    { name = "DiagnosticSignWarn", text = kind.icons.warn },
    { name = "DiagnosticSignInfo", text = kind.icons.info },
    { name = "DiagnosticSignHint", text = kind.icons.hint },
  }

  -- Dap
  -- =========================================
  lvim.builtin.dap.active = true -- change this to enable/disable debugging

  -- Lualine
  -- =========================================
  -- lvim.builtin.lualine.active = true
  -- lvim.builtin.lualine.sections.lualine_b = { "branch" }

  -- NvimTree
  -- =========================================
  vim.g.nvim_tree_highlight_opened_files = 1
  vim.g.nvim_tree_indent_markers = 1
  vim.g.nvim_tree_group_empty = 1
  lvim.builtin.nvimtree.show_icons.git = 0
  lvim.builtin.nvimtree.setup.auto_close = true
  lvim.builtin.nvimtree.setup.diagnostics = {
    enable = true,
    icons = {
      hint = kind.icons.hint,
      info = kind.icons.info,
      warning = kind.icons.warn,
      error = kind.icons.error,
    },
  }
  lvim.builtin.nvimtree.icons = kind.nvim_tree_icons

  -- Project
  -- =========================================
  lvim.builtin.project.active = true
  lvim.builtin.project.detection_methods = { "lsp", "pattern" }

  -- Treesitter
  -- =========================================
  lvim.builtin.treesitter.highlight.enabled = true
  lvim.builtin.treesitter.ignore_install = { "haskell" }
  lvim.builtin.treesitter.indent = { enable = true, disable = { "yaml", "python" } } -- treesitter is buggy :(
  lvim.builtin.treesitter.matchup.enable = true
  -- lvim.treesitter.textsubjects.enable = true
  -- lvim.treesitter.playground.enable = true
  lvim.builtin.treesitter.textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
      },
    },
    swap = {
      enable = false,
      swap_next = {
        ["<leader><M-a>"] = "@parameter.inner",
        ["<leader><M-f>"] = "@function.outer",
        ["<leader><M-e>"] = "@element",
      },
      swap_previous = {
        ["<leader><M-A>"] = "@parameter.inner",
        ["<leader><M-F>"] = "@function.outer",
        ["<leader><M-E>"] = "@element",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]f"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]F"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[F"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  }
  -- lvim.builtin.treesitter.ensure_installed = "maintained"
  lvim.builtin.treesitter.ensure_installed = {
    "bash",
    "c",
    "javascript",
    "json",
    "lua",
    "python",
    "typescript",
    "css",
    "rust",
    "java",
    "yaml",
  }

  -- Telescope
  -- =========================================
  -- lvim.builtin.telescope.defaults.path_display = { "smart", "absolute", "truncate" }
  lvim.builtin.telescope.defaults.path_display = { shorten = 10 }
  lvim.builtin.telescope.defaults.winblend = 6
  lvim.builtin.telescope.defaults.file_ignore_patterns = {
    "vendor/*",
    "%.lock",
    "__pycache__/*",
    "%.sqlite3",
    "%.ipynb",
    "node_modules/*",
    "%.jpg",
    "%.jpeg",
    "%.png",
    "%.svg",
    "%.otf",
    "%.ttf",
    ".git/",
    "%.webp",
    ".dart_tool/",
    ".github/",
    ".gradle/",
    ".idea/",
    ".settings/",
    ".vscode/",
    "__pycache__/",
    "build/",
    "env/",
    "gradle/",
    "node_modules/",
    "target/",
    "%.pdb",
    "%.dll",
    "%.class",
    "%.exe",
    "%.cache",
    "%.ico",
    "%.pdf",
    "%.dylib",
    "%.jar",
    "%.docx",
    "%.met",
    "smalljre_*/*",
    ".vale/",
  }
  -- lvim.builtin.telescope.defaults.layout_config = require("user.telescope").layout_config()
  local actions = require "telescope.actions"
  lvim.builtin.telescope.defaults.mappings = {
    i = {
      ["<C-c>"] = actions.close,
      ["<C-y>"] = actions.which_key,
      ["<C-j>"] = actions.cycle_history_next,
      ["<C-k>"] = actions.cycle_history_prev,
      ["<C-n>"] = actions.move_selection_next,
      ["<C-p>"] = actions.move_selection_previous,
      ["<Tab>"] = actions.toggle_selection + actions.move_selection_next,
      ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_previous,
      ["<CR>"] = actions.select_default + actions.center,
      ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
    },
    n = {
      ["<Esc>"] = actions.close,
      ["<c-j>"] = actions.cycle_history_next,
      ["<c-k>"] = actions.cycle_history_prev,
      ["<C-n>"] = actions.move_selection_next,
      ["<C-p>"] = actions.move_selection_previous,
      ["<Tab>"] = actions.toggle_selection + actions.move_selection_next,
      ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_previous,
      ["<CR>"] = actions.select_default + actions.center,
      ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
    },
  }

  -- Terminal
  -- =========================================
  lvim.builtin.terminal.active = true
  lvim.builtin.terminal.open_mapping = [[<C-\>]]
  lvim.builtin.terminal.execs = {
    { "zsh", "<leader>tt", "Float", "float" },
    { "zsh", "<leader>th", "Horizontal", "horizontal" },
    { "zsh", "<leader>tv", "Vertical", "vertical" },
    { "lazygit", "<leader>tg", "LazyGit", "float" },
    { "gitui", "<leader>tG", "Git UI", "float" },
    { "python", "<leader>tp", "Python", "float" },
    { "htop", "<leader>tj", "htop", "float" },
    { "ncdu", "<leader>tn", "ncdu", "float" },
  }

  -- WhichKey
  lvim.builtin.which_key.on_config_done = require("user.whichkey").config
end

function M.rename(curr, win)
  local name = vim.trim(vim.fn.getline ".")
  vim.api.nvim_win_close(win, true)
  if #name > 0 and name ~= curr then
    local params = vim.lsp.util.make_position_params()
    params.newName = name
    vim.lsp.buf_request(0, "textDocument/rename", params)
  end
end

function M.lsp_rename()
  local name = vim.fn.expand "<cword>"
  local ok, ts = pcall(require, "nvim-treesitter-playground.hl-info")
  local tshl = ""
  if ok and ts then
    if #ts <= 0 then
      return
    end
    tshl = ts.get_treesitter_hl()
    local ind = tshl[#tshl]:match "^.*()%*%*.*%*%*"
    tshl = tshl[#tshl]:sub(ind + 2, -3)
  end

  local win = require("plenary.popup").create(name, {
    title = "New Name",
    style = "minimal",
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    relative = "cursor",
    borderhighlight = "FloatBorder",
    titlehighlight = "Title",
    highlight = tshl,
    focusable = true,
    width = 25,
    height = 1,
    line = "cursor+2",
    col = "cursor-1",
  })
  -- Move cursor to the end of the prefix
  vim.cmd "stopinsert"
  vim.cmd "startinsert!"
  vim.cmd [[lua require('cmp').setup.buffer { enabled = false }]]

  local opts = { noremap = false, silent = true }
  vim.api.nvim_buf_set_keymap(0, "i", "<Esc>", "<cmd>stopinsert | q!<CR>", opts)
  vim.api.nvim_buf_set_keymap(0, "n", "<Esc>", "<cmd>stopinsert | q!<CR>", opts)
  vim.api.nvim_buf_set_keymap(
    0,
    "i",
    "<CR>",
    "<cmd>stopinsert | lua require('user.builtin').rename(" .. name .. "," .. win .. ")<CR>",
    opts
  )
  vim.api.nvim_buf_set_keymap(
    0,
    "n",
    "<CR>",
    "<cmd>stopinsert | lua require('user.builtin').rename(" .. name .. "," .. win .. ")<CR>",
    opts
  )
end

function M.tab(fallback)
  local methods = require("lvim.core.cmp").methods
  local cmp = require "cmp"
  local luasnip = require "luasnip"
  local copilot_keys = vim.fn["copilot#Accept"]()
  if cmp.visible() then
    cmp.select_next_item()
  elseif vim.api.nvim_get_mode().mode == "c" then
    fallback()
  elseif copilot_keys ~= "" then -- prioritise copilot over snippets
    -- Copilot keys do not need to be wrapped in termcodes
    vim.api.nvim_feedkeys(copilot_keys, "i", true)
  elseif luasnip.expandable() then
    luasnip.expand()
  elseif methods.jumpable() then
    luasnip.jump(1)
  elseif methods.check_backspace() then
    fallback()
  else
    methods.feedkeys("<Plug>(Tabout)", "")
  end
end

function M.shift_tab(fallback)
  local methods = require("lvim.core.cmp").methods
  local luasnip = require "luasnip"
  local cmp = require "cmp"
  if cmp.visible() then
    cmp.select_prev_item()
  elseif vim.api.nvim_get_mode().mode == "c" then
    fallback()
  elseif methods.jumpable(-1) then
    luasnip.jump(-1)
  else
    local copilot_keys = vim.fn["copilot#Accept"]()
    if copilot_keys ~= "" then
      methods.feedkeys(copilot_keys, "i")
    else
      methods.feedkeys("<Plug>(Tabout)", "")
    end
  end
end

function M.cpmenu()
  return {
    {
      "File",
      { "entire selection", ':call feedkeys("GVgg")' },
      { "file browser", ":lua require('user.telescope').file_browser()", 1 },
      { "files", ":lua require('telescope.builtin').find_files()", 1 },
      { "git files", ":lua require('user.telescope').git_files()", 1 },
      { "last search", ":lua require('telescope.builtin').resume({cache_index=3})" },
      { "quit", ":qa" },
      { "save all files", ":wa" },
      { "save current file", ":w" },
      { "search word", ":lua require('user.telescope').find_string()", 1 },
    },
    {
      "Lsp",
      { "formatting", ":lua vim.lsp.buf.formatting_seq_sync()" },
      { "workspace diagnostics", ":Telescope diagnostics" },
      { "workspace symbols", ":Telescope lsp_workspace_symbols" },
    },
    {
      "Project",
      { "list", ":Telescope projects" },
      { "build", ":AsyncTask project-build" },
      { "run", ":AsyncTask project-run" },
    },
    {
      "Vim",
      { "buffers", ":Telescope buffers" },
      { "check health", ":checkhealth" },
      { "colorshceme", ":lua require('telescope.builtin').colorscheme()", 1 },
      { "command history", ":lua require('telescope.builtin').command_history()" },
      { "commands", ":lua require('telescope.builtin').commands()" },
      { "cursor column", ":set cursorcolumn!" },
      { "cursor line", ":set cursorline!" },
      { "jumps", ":lua require('telescope.builtin').jumplist()" },
      { "keymaps", ":lua require('telescope.builtin').keymaps()" },
      { "paste mode", ":set paste!" },
      { "registers (A-e)", ":lua require('telescope.builtin').registers()" },
      { "relative number", ":set relativenumber!" },
      { "reload vimrc", ":source $MYVIMRC" },
      { "search highlighting", ":set hlsearch!" },
      { "search history", ":lua require('telescope.builtin').search_history()" },
      { "spell checker", ":set spell!" },
      { "vim options", ":lua require('telescope.builtin').vim_options()" },
    },
    {
      "Help",
      { "cheatsheet", ":help index" },
      { "quick reference", ":help quickref" },
      { "search help", ":lua require('telescope.builtin').help_tags()", 1 },
      { "summary", ":help summary" },
      { "tips", ":help tips" },
      { "tutorial", ":help tutor" },
    },
    {
      "Dap",
      { "brakpoints", ":lua require'telescope'.extensions.dap.list_breakpoints{}" },
      { "clear breakpoints", ":lua require('dap.breakpoints').clear()" },
      { "close", ":lua require'dap'.close(); require'dap'.repl.close()" },
      { "commands", ":lua require'telescope'.extensions.dap.commands{}" },
      { "configurations", ":lua require'telescope'.extensions.dap.configurations{}" },
      { "continue", ":lua require'dap'.continue()" },
      { "current scopes floating window", ":lua ViewCurrentScopesFloatingWindow()" },
      { "current scopes", ':lua ViewCurrentScopes(); vim.cmd("wincmd w|vertical resize 40")' },
      { "current value floating window", ":lua ViewCurrentValueFloatingWindow()" },
      { "frames", ":lua require'telescope'.extensions.dap.frames{}" },
      { "pause", ":lua require'dap'.pause()" },
      { "repl", ":lua require'dap'.repl.open(); vim.cmd(\"wincmd w|resize 12\")" },
      { "run to cursor", ":lua require'dap'.run_to_cursor()" },
      { "step back", ":lua require'dap'.step_back()" },
      { "step into", ":lua require'dap'.step_into()" },
      { "step out", ":lua require'dap'.step_out()" },
      { "step over", ":lua require'dap'.step_over()" },
      { "toggle breakpoint", ":lua require'dap'.toggle_breakpoint()" },
    },
  }
end

return M
