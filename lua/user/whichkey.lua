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
  M._add_desc(wk, "<Leader>t", "Terminal", "n", true)
  M._add_desc(wk, "<C-\\>", "Terminal", "n")

  M._add_desc(wk, "gc", "Line Comment", "n")
  M._add_desc(wk, "gcc", "Line Comment", "n")
  M._add_desc(wk, "gc", "Line Comment", "v")
  M._add_desc(wk, "gb", "Block Comment", "n")
  M._add_desc(wk, "gbc", "Block Comment", "n")
  M._add_desc(wk, "gb", "Block Comment", "v")

  M._add_desc(wk, "<C-y>", "Scroll UP Little", "n")
  M._add_desc(wk, "<C-u>", "Scroll UP Much", "n")
  M._add_desc(wk, "<C-b>", "Scroll UP Page", "n")
  M._add_desc(wk, "<C-e>", "Scroll Down Little", "n")
  M._add_desc(wk, "<C-d>", "Scroll Down Much", "n")
  M._add_desc(wk, "<C-f>", "Scroll Down Page", "n")

  M._add_desc(wk, "<A-k>", "Move Text Up", "n")
  M._add_desc(wk, "<A-j>", "Move Text Down", "n")
end

return M
