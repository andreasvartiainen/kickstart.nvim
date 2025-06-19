-- [[ Install `lazy.nvim` plugin manager ]]
require 'lazy-bootstrap'
require('lazy').setup({
  -- 'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  require 'kickstart.plugins.overseer-config',
  require 'kickstart.plugins.toggleterm-config',
  require 'kickstart.plugins.debug',
  require 'kickstart.plugins.indent_line',
  require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs', -- adds ( ) { } automatically when relevant
  require 'kickstart.plugins.neo-tree',
  require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps
  require 'kickstart.plugins.which-key', -- shows keys to press after pressing a key
  require 'kickstart.plugins.telescope-config',
  require 'kickstart.plugins.venv-selector-config', -- plugin for selecting python envs
  require 'kickstart.plugins.lsp-config', -- language server configuration
  -- require 'kickstart.plugins.autoformat', -- autoformatting
  require 'kickstart.plugins.vim-cmp-config', -- autocomplete
  require 'kickstart.plugins.theme', -- theme for the editor configured here
  require 'kickstart.plugins.mini-config', -- library of lua modules to improve Neovim
  require 'kickstart.plugins.treesitter-config', -- updating syntax as the source is edited
  require 'kickstart.plugins.lazygit', -- remember to install lazygit for your system
  require 'kickstart.plugins.cmake_tools',
  require 'kickstart.plugins.heirline', -- zeioth heirline components
  require 'kickstart.plugins.presence', -- plugin for discord rich presence
  -- require 'kickstart.plugins.vimtex-config',
  require 'kickstart.plugins.colorizer-config',
  -- require 'kickstart.plugins.micropython',
  { 'echasnovski/mini.bufremove', version = '*' }, -- setting in mini-config didn't work
  { 'kylechui/nvim-surround', version = '*', event = 'VeryLazy', config = true },
  { 'Bilal2453/luvit-meta', lazy = true },
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } }, -- Highlight todo, notes, etc in comments
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- :NOTE: for git conflicts install lazygit
