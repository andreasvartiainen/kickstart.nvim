return {
  'jim-at-jibba/micropython.nvim',
  config = function()
    vim.keymap.set('n', '<leader>mr', require('micropython_nvim').run, { desc = 'Run the current buffer on micro controller' })
  end,
}
