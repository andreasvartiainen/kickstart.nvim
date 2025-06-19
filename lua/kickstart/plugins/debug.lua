local js_based_languages = {
  'typescript',
  'javascript',
  'typescriptreact',
  'javascriptreact',
  'vue',
}

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',

    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    {
      'microsoft/vscode-js-debug',
      build = 'npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out',
    },

    'mfussenegger/nvim-dap-python',
    'leoluz/nvim-dap-go',
    {
      'mxsdev/nvim-dap-vscode-js',
      config = function()
        require('dap-vscode-js').setup {
          debugger_path = vim.fn.resolve(vim.fn.stdpath 'data' .. '/lazy/vscode-js-debug'),
          adapters = {
            'chrome',
            'pwa-node',
            'pwa-chrome',
            'pwa-msedge',
            'pwa-extensionHost',
          },
        }
      end,
    },
  },

  keys = function()
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
      },
    }

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {}

		-- listeners to exit and enter dapui automatically
    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    require('dap-python').setup 'python'

    for _, language in ipairs(js_based_languages) do
      if language == 'typescript' then
        dap.configurations[language] = {
          -- debug single file
          {
            type = 'pwa-node',
            request = 'launch',
            name = 'Launch TS file',
            runtimeExecutable = 'tsx',
            runtimeArgs = '',
            program = '${file}',
            console = 'integratedTerminal',
            cwd = '${workspaceFolder}',
            sourceMaps = true,
          },
        }
      else
        dap.configurations[language] = {
          -- debug single file
          {
            type = 'pwa-node',
            request = 'launch',
            name = 'Launch file',
            program = '${file}',
            console = 'integratedTerminal',
            cwd = '${workspaceFolder}',
            sourceMaps = true,
          },
        }
      end
    end

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
  end,
}
