local map = function(keys, func, desc, mode)
  mode = mode or 'n'
  vim.keymap.set(mode, keys, func, { desc = desc })
end

map("gh", vim.lsp.buf.hover, "Show info under cursor")
map("gd", "<c-]>", "[G]oto definition")
map("<leader>e", vim.diagnostic.open_float, "Show error")
map("gr", vim.lsp.buf.references, "Show references")

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
map('<Esc>', '<cmd>nohlsearch<CR>', 'Clear highlighting on ESC')
map('jj', '<Esc>', 'Exit insert mode with jj', 'i')

-- Diagnostic keymaps
map('<leader>q', vim.diagnostic.setloclist,  'Open diagnostic [Q]uickfix list' )

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
-- map('<Esc><Esc>', '<C-\\><C-n>',  'Exit terminal mode', 't' )

-- Keybinds to make split navigation easier.
--  See `:help wincmd` for a list of all window commands
map('<leader>h', '<C-w><C-h>',  'Move focus to the left window' )
map('<leader>l', '<C-w><C-l>',  'Move focus to the right window' )
map('<leader>j', '<C-w><C-j>',  'Move focus to the lower window' )
map('<leader>k', '<C-w><C-k>',  'Move focus to the upper window' )
map('<leader><TAB>', '<cmd>bnext<CR>',  'Go to next buffer' )
map('<leader><S-TAB>', '<cmd>bNext<CR>',  'Go to previous buffer' )
-- map('<leader>q', ':bp<bar>sp<bar>bn<bar>bd<CR>',  'Close buffer' )
map('<leader>q', ':bNext<bar>bd#<CR>',  'Close buffer' )
map('<leader>s', 'y/<C-R>"<CR>N',  'Search selected text', 'v' )

map('<leader>t', ':ToggleTerm<cr>', 'Open new terminal in a new tab')
