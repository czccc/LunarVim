local M = {}

M.config = function()
  local function restore_nvim_tree()
    local status_ok, nvim_tree = pcall(require, "nvim-tree")
    if not status_ok then
      return
    end
    nvim_tree.change_dir(vim.fn.getcwd())
    nvim_tree.toggle(false)
    require("nvim-tree.actions.reloaders").reload_explorer()
  end

  local status_ok, auto_session = pcall(require, "auto-session")
  if not status_ok then
    return
  end

  auto_session.setup {
    log_level = "error",
    auto_session_enable_last_session = false,
    auto_session_root_dir = vim.fn.stdpath "data" .. "/sessions/",
    auto_session_create_enabled = false,
    auto_session_enabled = true,
    auto_save_enabled = true,
    auto_restore_enabled = true,
    auto_session_suppress_dirs = nil,
    -- the configs below are lua only
    bypass_session_save_file_types = { "Outline" },
    post_restore_cmds = { restore_nvim_tree },
  }
end

return M
