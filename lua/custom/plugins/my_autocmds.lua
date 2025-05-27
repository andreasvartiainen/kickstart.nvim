vim.api.nvim_create_autocmd('VimEnter', {
  desc = 'Auto select virtualenv Nvim open',
  pattern = '*',
  callback = function()
    local venv = vim.fn.findfile('pyproject.toml', vim.fn.getcwd() .. ';')
    if venv ~= '' then
      require('venv-selector').retrieve_from_cache()
    end
  end,
  once = true,
})

vim.api.nvim_create_autocmd({"InsertEnter"}, {
	pattern = {"*"},
	callback = function()
		if vim.bo.filetype == "neo-tree" then
			return
		end
		vim.opt.number = true
		vim.opt.relativenumber = false
	end,
})

vim.api.nvim_create_autocmd({"InsertLeave"}, {
	pattern = {"*"},
	callback = function()
		if vim.bo.filetype == "neo-tree" then
			return
		end
		vim.opt.number = true
		vim.opt.relativenumber = true
	end,
})

-- Highlight when yanking text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
