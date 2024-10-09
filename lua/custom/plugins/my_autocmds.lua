local bufnr = 19

vim.api.nvim_create_autocmd('bufEnter', {
  group = vim.api.nvim_create_augroup('Mygroup', { clear = true }),
  pattern = '*.lua',
  callback = function()
    vim.fn.jobstart({ 'git', 'root' }, {
      stdout_buffered = true,
      on_stdout = function(_, data)
        if data then
          vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, { data })
        end
      end,
    })
  end,
})
