-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'mfussenegger/nvim-dap-python',
    'leoluz/nvim-dap-go',
  },
  keys = function(_, keys)
    local dap = require 'dap'
    local dapui = require 'dapui'
    return {
      -- Basic debugging keymaps, feel free to change to your liking!
      { '<F5>', dap.continue, desc = 'Debug: Start/Continue' },
      { '<F1>', dap.step_into, desc = 'Debug: Step Into' },
      { '<F2>', dap.step_over, desc = 'Debug: Step Over' },
      { '<F3>', dap.step_out, desc = 'Debug: Step Out' },
      { '<leader>b', dap.toggle_breakpoint, desc = 'Debug: Toggle Breakpoint' },
      {
        '<leader>B',
        function()
          dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,
        desc = 'Debug: Set Breakpoint',
      },
      -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
      { '<F7>', dapui.toggle, desc = 'Debug: See last session result.' },
      unpack(keys),
    }
  end,
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'cpptools',
        'python',
        -- 'delve',
      },
    }

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    -- require('dap-go').setup {
    --   delve = {
    --     -- On Windows delve must be run attached or it crashes.
    --     -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
    --     detached = vim.fn.has 'win32' == 0,
    --   },
    -- }
    require('dap-python').setup 'python'

    -- table.insert(require('dap').configurations.python, {
    --   type = 'python',
    --   request = 'launch',
    --   name = 'Module',
    --   console = 'externalTerminal',
    --   module = 'src', -- edit this to be your app's main module
    --   cwd = '${workspaceFolder}',
    -- })
    dap.configurations.python = {
      {
        type = 'python',
        request = 'launch',
        name = 'Launch Current File',
        console = 'integratedTerminal',
        -- cwd = '${workspaceFolder}',
        program = '${file}',
      },
      {
        type = 'python',
        request = 'launch',
        name = 'Launch Filepath',
        console = 'integratedTerminal',
        -- module = 'src', -- edit this to be your app's main module
        cwd = '${workspaceFolder}',
        program = function()
          return vim.fn.input('File Path: ', vim.fn.getcwd() .. '/', 'file')
        end,
      },
    }

    -- NOTE: if cpp debugging doesn't work check with :Mason that the debugger is installed

    -- setup cpp adapter
    -- dap.adapters.cpptools = {
    --   name = 'cpptools',
    --   type = 'executable',
    --   command = vim.fn.stdpath 'data' .. '/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
    --   options = {
    --     detached = false,
    --   },
    -- }
    -- this configuration should start cpptools and the debug the executable main in the current directory when executing :DapContinue
    -- dap.configurations.cpp = {
    --   {
    --     name = 'Launch',
    --     type = 'cpptools',
    --     request = 'launch',
    --     -- MIDebuggerPath = 'lldb-mi',
    --     program = '${workspaceFolder}/main.exe',
    --     cwd = '${workspaceFolder}',
    --     stopOnEntry = true,
    --     args = {},
    --     runInTerminal = false,
    --     -- program = function()
    --     --   return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    --     -- end,
    --   },
    -- }
    -- dap.configurations.c = {
    --   {
    --     name = 'Launch',
    --     type = 'cpptools',
    --     request = 'launch',
    --     program = '${workspaceFolder}/main.exe',
    --     cwd = '${workspaceFolder}',
    --     stopOnEntry = true,
    --     args = {},
    --     runInTerminal = false,
    --   },
    -- }
  end,
}
