local M = {}

M.config = function()
  local status_ok, autosave = pcall(require, "autosave")
  if not status_ok then
    return
  end

  autosave.setup {
    enabled = true,
    execution_message = function()
      return '"'
        .. vim.fn.fnamemodify(vim.fn.expand "%", ":~")
        .. '"'
        .. " auto saved at "
        .. vim.fn.strftime "%H:%M:%S"
    end,
    events = { "InsertLeave", "TextChanged" },
    conditions = {
      exists = true,
      filename_is_not = {},
      filetype_is_not = {},
      modifiable = true,
    },
    write_all_buffers = true,
    on_off_commands = true,
    clean_command_line_interval = 0,
    debounce_delay = 135,
  }
end

return M
