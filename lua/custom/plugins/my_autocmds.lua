-- local bufnr = 40

local git_root = 'git rev-parse --show-toplevel'

vim.api.nvim_create_autocmd('bufEnter', {
  group = vim.api.nvim_create_augroup('Mygroup', { clear = true }),
  -- pattern = '*.lua',
  callback = function()
    -- vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {}) -- clear lines
    vim.fn.jobstart(git_root, {
      stdout_buffered = true,
      on_stdout = function(_, data)
        if data then
          local git_dir = data[1]
          if git_dir ~= "" then
            print(git_dir)
          else
            print("git root directory not found")
          end
        end
      end,
    })
  end,
})

--  NOTE: git config --global alias.root 'rev-parse --show-toplevel'
