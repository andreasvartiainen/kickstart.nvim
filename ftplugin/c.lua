-- settings for C
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.makeprg="cmake -S . -B ./build -DCMAKE_EXPORT_COMPILE_COMMANDS=1 && cd ./build && make"

-- Cmake Generate on buffer write
vim.api.nvim_create_autocmd({"BufWritePost"}, {
	group = vim.api.nvim_create_augroup("C", {clear=true}),
	pattern = {'*.c', '*.cpp', '*.h', '*.hpp'},
	callback = function ()
		vim.api.nvim_command(":CMakeGenerate")
	end
})
