local M = {}

M._add_desc = function(wk, keymap, desc, mode, group)
  -- print("setting " .. keymap .. " " .. desc)
  if group then
    wk.register({ [keymap] = { name = desc } }, { mode = mode })
  else
    wk.register({ [keymap] = { desc } }, { mode = mode })
  end
end

M.config = function(wk)
  for _, exec in pairs(lvim.builtin.terminal.execs) do
    M._add_desc(wk, exec[2], exec[3], "n")
    -- M._add_desc(wk, exec[2], exec[3], "t")
  end
end

return M
