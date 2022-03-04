local M = {}

M.config = function()
  lvim.plugins = {
    {
      "folke/tokyonight.nvim",
      config = function()
        require("user.theme").tokyonight()
        -- lvim.colorscheme = "tokyonight"
        -- vim.cmd [[ colorscheme tokyonight ]]
      end,
    },
    {
      "lukas-reineke/indent-blankline.nvim",
      setup = function()
        vim.g.indent_blankline_char = "▏"
      end,
      config = function()
        require("user.indent_blankline").config()
      end,
      event = "BufRead",
      cmd = { "IndentBlanklineRefresh" },
    },
    {
      "nvim-telescope/telescope-frecency.nvim",
      config = function()
        require("telescope").load_extension "frecency"
        lvim.builtin.telescope.extensions["frecency"] = {
          show_scores = true,
        }
      end,
      requires = { "tami5/sqlite.lua" },
    },
    {
      "goolord/alpha-nvim",
      config = function()
        require("user.dashboard").config()
      end,
      disable = not lvim.user.fancy_dashboard.active,
    },
    {
      "karb94/neoscroll.nvim",
      config = function()
        require("neoscroll").setup { easing_function = "quadratic" }
      end,
      event = "BufRead",
      disable = not lvim.user.neoscroll.active,
    },
    {
      "yamatsum/nvim-cursorline",
      opt = true,
      event = "BufWinEnter",
      disable = not lvim.user.cursorline.active,
    },
    {
      "norcalli/nvim-colorizer.lua",
      config = function()
        require("colorizer").setup({ "*" }, { css = true })
      end,
      event = { "BufRead" },
    },
    {
      "simrat39/symbols-outline.nvim",
      setup = function()
        require("user.symbols_outline").config()
      end,
      event = "BufReadPost",
      cmd = "SymbolsOutline",
    },
    {
      "sidebar-nvim/sidebar.nvim",
      config = function()
        require("user.sidebar").config()
      end,
      event = "BufRead",
      cmd = "SidebarNvimToggle",
      disable = not lvim.user.sidebar.active,
    },
    {
      "folke/zen-mode.nvim",
      config = function()
        require("user.zen").config()
      end,
      cmd = { "ZenMode" },
    },
    {
      "gelguy/wilder.nvim",
      -- event = { "CursorHold", "CmdlineEnter" },
      rocks = { "luarocks-fetch-gitrec", "pcre2" },
      requires = { "romgrk/fzy-lua-native" },
      config = function()
        vim.cmd(string.format("source %s", get_config_dir() .. "/vimscript/wilder.vim"))
      end,
      run = ":UpdateRemotePlugins",
      disable = not lvim.user.fancy_wild_menu.active,
    },
    {
      "sindrets/diffview.nvim",
      opt = true,
      cmd = { "DiffviewOpen", "DiffviewFileHistory" },
      module = "diffview",
      -- keys = "<leader>gd",
      -- setup = function()
      --   require("which-key").register { ["<leader>gd"] = "diffview: diff HEAD" }
      -- end,
      config = function()
        require("diffview").setup {
          enhanced_diff_hl = true,
          key_bindings = {
            file_panel = { q = "<Cmd>DiffviewClose<CR>" },
            view = { q = "<Cmd>DiffviewClose<CR>" },
            file_history_panel = { q = "<Cmd>DiffviewClose<CR>" },
          },
        }
      end,
      disable = not lvim.user.fancy_diff.active,
    },
    {
      "filipdutescu/renamer.nvim",
      config = function()
        require("user.renamer").config()
      end,
      disable = not lvim.user.fancy_rename.active,
    },
    { "mtdl9/vim-log-highlighting", ft = { "text", "log" } },
    {
      "ethanholz/nvim-lastplace",
      config = function()
        require("nvim-lastplace").setup {
          lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
          lastplace_ignore_filetype = {
            "gitcommit",
            "gitrebase",
            "svn",
            "hgcommit",
          },
          lastplace_open_folds = true,
        }
      end,
      event = "BufWinEnter",
      disable = not lvim.user.lastplace.active,
    },
    {
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("user.todo_comments").config()
      end,
      event = "BufRead",
    },
    {
      "phaazon/hop.nvim",
      event = "BufRead",
      cmd = { "HopChar2", "HopWord" },
      config = function()
        require("hop").setup()
      end,
      disable = lvim.user.hop_motion.acitve,
    },
    -- {
    --   "folke/persistence.nvim",
    --   event = "BufReadPre",
    --   module = "persistence",
    --   config = function()
    --     require("persistence").setup {
    --       dir = vim.fn.expand(get_cache_dir() .. "/sessions/"), -- directory where session files are saved
    --       options = { "buffers", "curdir", "tabpages", "winsize" }, -- sessionoptions used for saving
    --     }
    --   end,
    --   disable = not lvim.user.persistence.active,
    -- },
    {
      "windwp/nvim-spectre",
      event = "BufRead",
      config = function()
        require("user.spectre").config()
      end,
    },
    {
      "rcarriga/nvim-dap-ui",
      config = function()
        require("dapui").setup()
      end,
      ft = { "python", "rust", "go" },
      event = "BufReadPost",
      requires = { "mfussenegger/nvim-dap" },
      disable = not lvim.builtin.dap.active,
    },
    {
      "ray-x/lsp_signature.nvim",
      config = function()
        require("user/lsp_signature").config()
      end,
      event = { "BufRead", "BufNew" },
    },
    {
      "folke/trouble.nvim",
      config = function()
        require("trouble").setup {
          auto_open = false,
          auto_close = true,
          padding = false,
          height = 10,
          use_diagnostic_signs = true,
          action_keys = { -- key mappings for actions in the trouble list
            close = { "q", "<esc>" }, -- close the list
            cancel = {}, -- cancel the preview and get back to your last window / buffer / cursor
            jump = "o", -- jump to the diagnostic or open / close folds
            jump_close = { "<cr>" }, -- jump to the diagnostic and close the list
            previous = { "k", "<S-tab>" }, -- preview item
            next = { "j", "<tab>" }, -- next item
          },
        }
      end,
      cmd = "Trouble",
    },
    {
      "kosayoda/nvim-lightbulb",
      config = function()
        vim.fn.sign_define(
          "LightBulbSign",
          { text = require("user.lsp_kind").icons.code_action, texthl = "DiagnosticInfo" }
        )
      end,
      event = "BufRead",
      ft = { "rust", "go", "typescript", "typescriptreact" },
    },
    {
      "simrat39/rust-tools.nvim",
      config = function()
        require("user.rust_tools").config()
      end,
      ft = { "rust", "rs" },
    },
    {
      "AckslD/nvim-neoclip.lua",
      requires = {
        { "tami5/sqlite.lua", module = "sqlite" },
        -- you'll need at least one of these
        { "nvim-telescope/telescope.nvim" },
        -- {'ibhagwan/fzf-lua'},
      },
      config = function()
        require("user.neoclip").config()
      end,
    },
    {
      "danymat/neogen",
      config = function()
        require("neogen").setup { snippet_engine = "luasnip" }
      end,
      requires = "nvim-treesitter/nvim-treesitter",
    },
    {
      "rmagatti/auto-session",
      config = function()
        require("user.auto_session").config()
      end,
      after = { "nvim-tree.lua" },
      disable = not lvim.user.auto_session.active,
    },
    {
      "nvim-telescope/telescope-file-browser.nvim",
    },
    {
      "kevinhwang91/nvim-bqf",
      config = function()
        require("user.bqf").config()
      end,
      event = "BufRead",
      disable = true,
    },
    {
      "kevinhwang91/nvim-hlslens",
      config = function()
        require("user.hlslens").config()
      end,
      event = "BufRead",
    },
    {
      "petertriho/nvim-scrollbar",
      config = function()
        require("user.scrollbar").config()
      end,
      event = "BufRead",
    },
    {
      "anuvyklack/pretty-fold.nvim",
      config = function()
        require("pretty-fold").setup {}
        require("pretty-fold.preview").setup()
      end,
      event = "BufRead",
      disable = true,
    },
    {
      "Pocco81/AutoSave.nvim",
      config = function()
        require("user.autosave").config()
      end,
      event = "BufRead",
      disable = true,
    },
    {
      "p00f/clangd_extensions.nvim",
      config = function()
        require("user.clangd_extension").config()
      end,
      ft = { "c", "cpp", "objc", "objcpp" },
    },
  }
end

return M
