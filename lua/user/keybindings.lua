local M = {}

M.set_terminal_keymaps = function()
  local opts = { noremap = true }
  vim.api.nvim_buf_set_keymap(0, "t", "<C-q>", "<cmd>bdelete!<CR>", opts)
  vim.api.nvim_buf_set_keymap(0, "n", "<esc>", [[<C-W>w]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, "n", "jk", [[<C-W>w]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
end

M.config = function()
  -- Additional keybindings
  -- =========================================

  -- lvim.keys.insert_mode["jk"] = "<ESC>"
  lvim.keys.normal_mode["<Esc>"] = ":noh<CR>"
  lvim.keys.normal_mode["<C-a>"] = "ggVG"
  lvim.keys.insert_mode["<C-a>"] = "<ESC>ggVG"
  lvim.keys.normal_mode["<C-s>"] = ":w<CR>"
  lvim.keys.insert_mode["<C-s>"] = "<ESC>:w<CR>"
  -- lvim.keys.normal_mode["<C-q>"] = ":q<CR>"
  -- lvim.keys.insert_mode["<C-q>"] = "<ESC>:q<CR>"
  -- lvim.keys.insert_mode["<C-Q>"] = "<ESC>:q!<CR>"

  -- lvim.keys.normal_mode["<esc><esc>"] = "<cmd>nohlsearch<cr>"
  lvim.keys.normal_mode["D"] = "d$"
  lvim.keys.normal_mode["Y"] = "y$"
  lvim.keys.visual_mode["p"] = [["_dP]]
  lvim.keys.command_mode["w!!"] = "execute 'silent! write !sudo tee % >/dev/null' <bar> edit!"

  lvim.keys.normal_mode["<S-x>"] = ":BufferKill<CR>"
  lvim.keys.normal_mode["<TAB>"] = ":BufferLineCycleNext<CR>"
  lvim.keys.normal_mode["<S-TAB>"] = ":BufferLineCyclePrev<CR>"
  lvim.keys.normal_mode["<A-<>"] = ":BufferLineMovePrev<CR>"
  lvim.keys.normal_mode["<A->>"] = ":BufferLineMoveNext<CR>"

  if lvim.user.hop_motion.active then
    lvim.builtin.which_key.mappings["j"] = {
      name = "+Hop",
      c = { "<cmd>HopChar2<cr>", "Hop Char 2" },
      w = { "<cmd>HopWord<cr>", "Hop Word" },
      f = {
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>",
        "Forward",
      },
      F = {
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>",
        "Back",
      },
      t = {
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>",
        "Forward",
      },
      T = {
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>",
        "Back",
      },
    }
  end

  -- LSP
  lvim.keys.normal_mode["g["] = "<cmd>lua vim.diagnostic.goto_next()<cr>"
  lvim.keys.normal_mode["g]"] = "<cmd>lua vim.diagnostic.goto_prev()<cr>"
  lvim.keys.normal_mode["gd"] = "<cmd>lua vim.lsp.buf.definition()<cr>"
  lvim.keys.normal_mode["gD"] = "<cmd>lua vim.lsp.buf.declaration()<cr>"
  lvim.keys.normal_mode["K"] = "<cmd>lua vim.lsp.buf.hover()<cr>"

  -- WhichKey keybindings
  -- =========================================
  -- Terminal
  lvim.builtin.which_key.mappings["t"] = {
    name = "Terminal",
    -- t = { "ToggleTerm direction=float", "Float" },
    -- h = { "ToggleTerm direction=horizontal size=10", "Horizontal" },
    -- v = { "ToggleTerm direction=vertical size=80", "Vertical" },
  }
  lvim.builtin.which_key.mappings["u"] = {
    name = "Utils",
    z = { "<cmd>ZenMode<cr>", "Zen Mode" },
    o = { "<cmd>SymbolsOutline<cr>", "Symbol Outline" },
  }
  if lvim.user.fancy_diff.active then
    lvim.builtin.which_key.mappings["ud"] = { "<cmd>DiffviewOpen<cr>", "diffview: diff HEAD" }
  end
  if lvim.user.sidebar.active then
    lvim.keys.normal_mode["E"] = ":SidebarNvimToggle<cr>"
    lvim.builtin.which_key.mappings["uE"] = { "<cmd>SidebarNvimToggle<CR>", "Sidebar" }
  end
  lvim.builtin.which_key.mappings[";"] = nil
  if lvim.user.fancy_dashboard.active then
    lvim.builtin.which_key.mappings["ua"] = { "<cmd>Alpha<CR>", "Dashboard" }
  end
  if lvim.user.persistence.active then
    lvim.builtin.which_key.mappings["uS"] = {
      name = "+Session",
      d = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
      l = { "<cmd>lua require('persistence').load(last=true)<cr>", "Restore last session" },
      s = { "<cmd>lua require('persistence').load()<cr>", "Restore for current dir" },
    }
  end
  if lvim.user.auto_session.active then
    lvim.builtin.which_key.mappings["uS"] = {
      name = "+Session",
      s = { "<cmd>SaveSession<cr>", "SaveSession" },
      r = { "<cmd>RestoreSession<cr>", "RestoreSession" },
      d = { "<cmd>DeleteSession<cr>", "DeleteSession" },
    }
  end
  lvim.builtin.which_key.mappings["uR"] = {
    name = "Replace",
    f = { "<cmd>lua require('spectre').open_file_search()<cr>", "Current Buffer" },
    p = { "<cmd>lua require('spectre').open()<cr>", "Project" },
    w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Replace Word" },
  }

  lvim.builtin.which_key.mappings["c"] = { "<cmd>BufferKill<CR>", "Close Buffer" }
  lvim.builtin.which_key.mappings["b"] = {
    name = "Buffers",
    -- f = { "<cmd>Telescope buffers<cr>", "Find Buffers" },
    b = { "<cmd>lua require('user.telescope').find_buffers()<cr>", "Find Buffers" },
    c = { "<cmd>BufferKill<cr>", "Close Current" },
    h = { "<cmd>BufferLineCloseLeft<cr>", "Close to Left" },
    l = { "<cmd>BufferLineCloseRight<cr>", "Close to Right" },
    j = { "<cmd>BufferLineMovePrev<cr>", "Move Previous" },
    k = { "<cmd>BufferLineMoveNext<cr>", "Move Next" },
    p = { "<cmd>BufferLinePick<cr>", "Buffer Pick" },
    d = { "<cmd>BufferLineSortByDirectory<cr>", "Sort by Directory" },
    L = { "<cmd>BufferLineSortByExtension<cr>", "Sort by Extension" },
    n = { "<cmd>BufferLineSortByTabs<cr>", "Sort by Tabs" },

    ["g"] = {
      name = "Buffer Goto",
      ["1"] = { "<cmd>BufferLineGoToBuffer 1<cr>", "BufferGoto 1" },
      ["2"] = { "<cmd>BufferLineGoToBuffer 2<cr>", "BufferGoto 2" },
      ["3"] = { "<cmd>BufferLineGoToBuffer 3<cr>", "BufferGoto 3" },
      ["4"] = { "<cmd>BufferLineGoToBuffer 4<cr>", "BufferGoto 4" },
      ["5"] = { "<cmd>BufferLineGoToBuffer 5<cr>", "BufferGoto 5" },
      ["6"] = { "<cmd>BufferLineGoToBuffer 6<cr>", "BufferGoto 6" },
      ["7"] = { "<cmd>BufferLineGoToBuffer 7<cr>", "BufferGoto 7" },
      ["8"] = { "<cmd>BufferLineGoToBuffer 8<cr>", "BufferGoto 8" },
      ["9"] = { "<cmd>BufferLineGoToBuffer 9<cr>", "BufferGoto 9" },
    },
  }

  lvim.builtin.which_key.mappings["f"] = {
    name = "Find Files",
    t = { "<cmd>Telescope<cr>", "Telescope" },
    b = { "<cmd>lua require('user.telescope').curbuf()<cr>", "Current Buffer" },
    e = { "<cmd>Telescope oldfiles<cr>", "History" },
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    g = { "<cmd>lua require('user.telescope').git_files()<cr>", "Git Files" },
    i = { "<cmd>lua require('user.telescope').installed_plugins()<cr>", "Installed Plugins" },
    l = { "<cmd>Telescope resume<cr>", "Last Search" },
    p = { "<cmd>lua require('user.telescope').project_search()<cr>", "Project" },
    r = { "<cmd>lua require('telescope').extensions.frecency.frecency{}<cr>", "Frecency" },
    s = { "<cmd>lua require('user.telescope').git_status()<cr>", "Git Status" },
    w = { "<cmd>Telescope live_grep theme=ivy<cr>", "Live Grep" },
    W = { "<cmd>lua require('user.telescope').grep_cursor_string()<cr>", "Live Grep" },
    z = { "<cmd>lua require('user.telescope').search_only_certain_files()<cr>", "Certain Filetype" },
  }
  lvim.builtin.which_key.mappings["s"] = {
    name = "Search",
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
    p = {
      "<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<cr>",
      "Colorscheme with Preview",
    },
  }
  lvim.builtin.which_key.mappings["n"] = {
    name = "Neogen",
    c = { "<cmd>lua require('neogen').generate({ type = 'class'})<CR>", "Class Documentation" },
    f = { "<cmd>lua require('neogen').generate({ type = 'func'})<CR>", "Function Documentation" },
    t = { "<cmd>lua require('neogen').generate({ type = 'type'})<CR>", "Type Documentation" },
    F = { "<cmd>lua require('neogen').generate({ type = 'file'})<CR>", "File Documentation" },
  }

  -- LSP
  lvim.builtin.which_key.mappings["l"] = {
    name = "LSP",

    a = { "<cmd>lua require('lvim.core.telescope').code_actions()<cr>", "Code Action" },
    f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
    j = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic" },
    k = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev Diagnostic" },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
    w = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
    W = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },

    d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Goto Definition" },
    D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Goto declaration" },
    i = { "<cmd>lua vim.lsp.buf.references()<CR>", "Goto references" },
    I = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Goto Implementation" },
    h = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "show signature help" },

    p = {
      name = "Peek",
      d = { "<cmd>lua require('lvim.lsp.peek').Peek('definition')<cr>", "Definition" },
      t = { "<cmd>lua require('lvim.lsp.peek').Peek('typeDefinition')<cr>", "Type Definition" },
      i = { "<cmd>lua require('lvim.lsp.peek').Peek('implementation')<cr>", "Implementation" },
    },
    u = {
      name = "Utils",
      i = { "<cmd>LspInfo<cr>", "Lsp Info" },
      I = { "<cmd>LspInstallInfo<cr>", "Install" },
      R = { "<cmd>LspRestart<cr>", "Restart" },
    },
  }
  if lvim.user.fancy_rename then
    lvim.builtin.which_key.mappings["lr"] = { "<cmd>lua require('renamer').rename()<cr>", "Rename" }
  end
  lvim.builtin.which_key.mappings["lt"] = {
    name = "+Trouble",
    d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnosticss" },
    f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
    l = { "<cmd>Trouble loclist<cr>", "LocationList" },
    q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
    r = { "<cmd>Trouble lsp_references<cr>", "References" },
    t = { "<cmd>TodoLocList <cr>", "Todo" },
    w = { "<cmd>Trouble workspace_diagnostics<cr>", "Diagnosticss" },
  }

  -- DAP
  if lvim.builtin.dap.active then
    lvim.builtin.which_key.mappings["de"] = { "<cmd>lua require('dapui').eval()<cr>", "Eval" }
    lvim.builtin.which_key.mappings["dU"] = { "<cmd>lua require('dapui').toggle()<cr>", "Toggle UI" }
  end
end

return M
