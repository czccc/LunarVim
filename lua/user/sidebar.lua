local M = {}

M.config = function()
  local status_ok, sidebar = pcall(require, "sidebar-nvim")
  if not status_ok then
    return
  end
  sidebar.setup {
    disable_default_keybindings = 0,
    bindings = {
      ["q"] = function()
        require("sidebar-nvim").close()
      end,
    },
    open = false,
    side = "right",
    initial_width = 30,
    hide_statusline = true,
    update_interval = 1000,
    sections = { "git", "diagnostics", "todos", "symbols" },
    section_separator = { "", "-----", "" },
    containers = {
      attach_shell = "/bin/sh",
      show_all = true,
      interval = 5000,
    },
    datetime = {
      icon = "",
      format = "%a %b %d, %H:%M",
      clocks = {
        { name = "local" },
      },
    },
    todos = {
      icon = "",
      ignored_paths = { "~" }, -- ignore certain paths, this will prevent huge folders like $HOME to hog Neovim with TODO searching
      initially_closed = false, -- whether the groups should be initially closed on start. You can manually open/close groups later.
    },
  }
end

return M
