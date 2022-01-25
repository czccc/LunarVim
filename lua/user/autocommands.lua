local M = {}

M.config = function()
  -- Autocommands
  if lvim.builtin.nonumber_unfocus then
    vim.cmd [[
" don't show line number in unfocued window
augroup WindFocus
    autocmd!
    autocmd WinEnter * set relativenumber number cursorline
    autocmd WinLeave * set norelativenumber nonumber nocursorline
augroup END
  ]]
  end

  vim.cmd [[
" disable syntax highlighting in big files
function! DisableSyntaxTreesitter()
    echo("Big file, disabling syntax, treesitter and folding")
    if exists(':TSBufDisable')
        exec 'TSBufDisable autotag'
        exec 'TSBufDisable highlight'
    endif

    set foldmethod=manual
    syntax clear
    syntax off
    filetype off
    set noundofile
    set noswapfile
    set noloadplugins
    set lazyredraw
endfunction

augroup BigFileDisable
    autocmd!
    autocmd BufReadPre,FileReadPre * if getfsize(expand("%")) > 1024 * 1024 | exec DisableSyntaxTreesitter() | endif
augroup END
  ]]

  local codelens_viewer = "lua require('nvim-lightbulb').update_lightbulb()"

  lvim.autocommands.custom_groups = {
    -- bug fix: fold
    { "BufRead", "*", ":normal! zX<CR>" },

    { "CursorHold", "*.rs,*.go,*.ts,*.tsx", codelens_viewer },

    -- toggleterm
    { "TermOpen", "term://*", "lua require('user.keybindings').set_terminal_keymaps()" },

    -- dashboard
    { "FileType", "alpha", "nnoremap <silent> <buffer> q :q<CR>" },

    -- c, cpp
    -- { "Filetype", "c,cpp", "nnoremap <leader>H <Cmd>ClangdSwitchSourceHeader<CR>" },

    -- uncomment the following if you want to show diagnostics on hover
    -- { "CursorHold", "*", "lua vim.lsp.diagnostic.show_line_diagnostics({ show_header = false, border = 'single' })" },

    -- Telescope
    -- { "user", "TelescopeFindPre", "setlocal number" },
    { "user", "TelescopePreviewerLoaded", "setlocal number relativenumber wrap list" },
  }
end

return M
