local M = {}

M.config = function()
  local disabled_plugins = {
    "2html_plugin",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "matchit",
    "tar",
    "tarPlugin",
    "rrhelper",
    "spellfile_plugin",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
  }
  for _, plugin in pairs(disabled_plugins) do
    vim.g["loaded_" .. plugin] = 1
  end

  vim.opt.number = true
  vim.opt.relativenumber = false
  vim.opt.wrap = true
  vim.opt.termguicolors = true
  vim.opt.updatetime = 100
  vim.opt.timeoutlen = 250
  vim.opt.redrawtime = 1500
  vim.opt.ttimeoutlen = 10
  vim.opt.wrapscan = true -- Searches wrap around the end of the file
  vim.wo.foldmethod = "expr"
  vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
  vim.wo.foldlevel = 4
  vim.wo.foldtext =
    [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
  vim.wo.foldnestmax = 3
  vim.wo.foldminlines = 1
  vim.opt.guifont = "FiraCode Nerd Font:h13"
  vim.opt.cmdheight = 1
  vim.opt.pumblend = 10
  vim.opt.joinspaces = false
  vim.opt.list = true
  -- vim.opt.confirm = false -- make vim prompt me to save before doing destructive things
  -- vim.opt.autowriteall = true -- automatically :write before running commands and changing files
  -- vim.opt.fillchars = {
  --   vert = "▕", -- alternatives │
  --   fold = " ",
  --   eob = " ", -- suppress ~ at EndOfBuffer
  --   diff = "╱", -- alternatives = ⣿ ░ ─
  --   msgsep = "‾",
  --   foldopen = "▾",
  --   foldsep = "│",
  --   foldclose = "▸",
  -- }
  vim.opt.listchars = {
    -- space = "⋅",
    -- eol = "↴",
    tab = "»·",
    extends = "›", -- Alternatives: … »
    precedes = "‹", -- Alternatives: … «
    trail = "•", -- BULLET (U+2022, UTF-8: E2 80 A2)
  }
  vim.opt.wildignorecase = true
  vim.opt.wildignore = {
    "*.aux,*.out,*.toc",
    "*.o,*.obj,*.dll,*.jar,*.pyc,__pycache__,*.rbc,*.class",
    -- media
    "*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp",
    "*.avi,*.m4a,*.mp3,*.oga,*.ogg,*.wav,*.webm",
    "*.eot,*.otf,*.ttf,*.woff",
    "*.doc,*.pdf",
    -- archives
    "*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz",
    -- temp/system
    "*.*~,*~ ",
    "*.swp,.lock,.DS_Store,._*,tags.lock",
    -- version control
    ".git,.svn",
  }
  vim.opt.viewoptions = "folds,cursor,curdir,slash,unix"
  vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,localoptions,options,tabpages,winsize,winpos,globals"
end

return M
