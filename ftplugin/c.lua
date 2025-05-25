-- settings for C
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.makeprg="cmake -S . -B ./build -DCMAKE_EXPORT_COMPILE_COMMANDS=1 && cd ./build && make"
