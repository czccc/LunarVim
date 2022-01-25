local M = {}

M.tokyonight = function()
  vim.g.tokyonight_dev = true
  vim.g.tokyonight_style = "storm"
  vim.g.tokyonight_sidebars = {
    "qf",
    "vista_kind",
    "terminal",
    "packer",
    "spectre_panel",
    "NeogitStatus",
    "help",
  }
  vim.g.tokyonight_cterm_colors = false
  vim.g.tokyonight_terminal_colors = true
  vim.g.tokyonight_italic_comments = true
  vim.g.tokyonight_italic_keywords = true
  vim.g.tokyonight_italic_functions = false
  vim.g.tokyonight_italic_variables = false
  vim.g.tokyonight_transparent = lvim.transparent_window
  vim.g.tokyonight_hide_inactive_statusline = true
  vim.g.tokyonight_dark_sidebar = true
  vim.g.tokyonight_dark_float = true
end

M.colors = {
  tokyonight = {
    none = "NONE",
    bg_dark = "#1f2335",
    bg_alt = "#1f2335",
    bg = "#1a1b26",
    bg_highlight = "#292e42",
    terminal_black = "#414868",
    fg = "#c0caf5",
    fg_dark = "#a9b1d6",
    fg_gutter = "#3b4261",
    dark3 = "#545c7e",
    comment = "#565f89",
    dark5 = "#737aa2",
    blue0 = "#3d59a1",
    blue = "#7aa2f7",
    cyan = "#7dcfff",
    blue1 = "#2ac3de",
    blue2 = "#0db9d7",
    blue5 = "#89ddff",
    blue6 = "#B4F9F8",
    blue7 = "#394b70",
    magenta = "#bb9af7",
    magenta2 = "#ff007c",
    purple = "#9d7cd8",
    orange = "#ff9e64",
    yellow = "#e0af68",
    green = "#9ece6a",
    green1 = "#73daca",
    green2 = "#41a6b5",
    teal = "#1abc9c",
    red = "#f7768e",
    red1 = "#db4b4b",
    -- git = { change = "#6183bb", add = "#449dab", delete = "#914c54", conflict = "#bb7a61" },
    git = { change = "#6183bb", add = "#449dab", delete = "#f7768e", conflict = "#bb7a61" },
    gitSigns = { add = "#164846", change = "#394b70", delete = "#823c41" },
  },

  onedarker = {
    fg = "#abb2bf",
    bg_alt = "#1f2227",
    bg = "#282c34",
    dark = "#282c34",
    accent = "#BBBBBB",
    dark_gray = "#2a2f3e",
    context = "#4b5263",
    popup_back = "#282c34",
    search_orange = "#613214",
    search_blue = "#5e81ac",
    gray = "#5c6370",
    light_gray = "#abb2bf",
    blue = "#61AFEF",
    dark_blue = "#223E55",
    green = "#98C379",
    cyan = "#56B6C2",
    red = "#e06c75",
    orange = "#D19A66",
    light_red = "#be5046",
    yellow = "#E5C07B",
    yellow_orange = "#D7BA7D",
    purple = "#C678DD",
    magenta = "#D16D9E",
    cursor_fg = "#515052",
    cursor_bg = "#AEAFAD",
    error_red = "#F44747",
    warning_orange = "#ff8800",
    info_yellow = "#FFCC66",
    hint_blue = "#4FC1FF",
    purple_test = "#ff007c",
    cyan_test = "#00dfff",
    ui_blue = "#264F78",
    git = {
      add = "#587c0c",
      change = "#0c7d9d",
      delete = "#e06c75",
      conflict = "#ff8800",
    },
  },

}

return M
