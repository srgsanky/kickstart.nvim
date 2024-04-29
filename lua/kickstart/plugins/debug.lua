-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)
--
--
-- From https://github.com/mfussenegger/nvim-dap/discussions/420
-- Log file can be found in the location :lua print(vim.fn.stdpath('cache')). Look for the default log file dap.log
-- ~/.cache/nvim/dap.log
--
-- DAP-Client ----- Debug Adapter ------- Debugger ------ Debugee
-- (nvim-dap)  |   (per language)  |   (per language)    (your app)
--             |                   |
--             |        Implementation specific communication
--             |        Debug-adapter and debugger could be the same process
--             |
--      Communication via debug adapter protocol
--
-- TODO: Other plugins to explore
-- 1. Record and replay support <https://github.com/jonboh/nvim-dap-rr>
--   * This is based on <https://github.com/rr-debugger/rr>
-- 2. Project specific configuration <https://github.com/ldelossa/nvim-dap-projects>
-- <https://www.youtube.com/watch?v=lEMZnrC-ST4>

local function configure_codelldb()
  local dap = require 'dap'
  dap.adapters.codelldb = {
    type = 'server',
    port = '${port}',
    executable = {
      command = vim.fn.stdpath 'data' .. '/mason/bin/codelldb',
      args = { '--port', '${port}' },
    },
  }

  dap.configurations.cpp = {
    {
      name = 'Launch executable via codelldb',
      type = 'codelldb',
      request = 'launch',
      program = '${workspaceFolder}/src/valkey-server',
      -- program = function()
      --   return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      -- end,
      cwd = '${workspaceFolder}',
      -- When I set stopOnEntry to true, it drops me in assembly code. I can still set breakpoint in source code
      -- and the debugger works with source code. But the initial drop in assembly can be confusing.
      stopOnEntry = false,
    },
  }
  -- Print variables using "p <variable name>". This is the same as gdb syntax.
  -- codelldb keeps the console output and repl output separate
end

local function configure_lldb_vscode()
  local dap = require 'dap'
  dap.adapters.lldb = {
    type = 'executable',
    command = '/opt/homebrew/opt/llvm/bin/lldb-vscode',
    name = 'lldb',
  }

  dap.configurations.cpp = {
    {
      name = 'Launch executable via lldb-vscode',
      type = 'lldb',
      request = 'launch',
      -- workspaceFolder is the current directory where neovim is opened
      program = '${workspaceFolder}/src/valkey-server',
      cwd = '${workspaceFolder}',
      -- When I set stopOnEntry to true, it drops me in assembly code. I can still set breakpoint in source code
      -- and the debugger works with source code. But the initial drop in assembly can be confusing.
      stopOnEntry = false,
      args = {},
    },
  }
  -- Print variables using "<variable name>". This is different from gdb syntax.
  -- lldb-vscode mixes the console output in the repl window.
end

local function configure_gdb_with_dap_support()
  local dap = require 'dap'
  -- GDB version 14 (released in Dec 23) and above support dap.
  -- https://blog.cryptomilk.org/2024/01/02/neovim-dap-and-gdb-14-1/
  -- https://sourceware.org/gdb/current/onlinedocs/gdb.html/Interpreters.html
  -- https://sourceware.org/gdb/current/onlinedocs/gdb.html/Debugger-Adapter-Protocol.html
  dap.adapters.gdb = {
    id = 'gdb',
    type = 'executable',
    command = 'gdb',
    args = { '--quiet', '--interpreter=dap' },
  }
end

local function configure_cppdbg()
  local dap = require 'dap'
  -- How to start the debug adaptor?
  -- GDB version 14 (released in Dec 23) and above support dap. But for versions before it,
  -- we have to use the MI interface.
  -- https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(gdb-via--vscode-cpptools)
  dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    command = vim.fn.expand '$HOME/.local/share/nvim/mason/bin/OpenDebugAD7',
    name = 'cppdbg',
  }

  -- How to start the debugee?
  -- https://code.visualstudio.com/docs/cpp/launch-json-reference#_customizing-gdb-or-lldb
  dap.configurations.cpp = {
    {
      name = 'Launch executable via gdb',
      type = 'cppdbg',
      MIMode = 'gdb',
      miDebuggerPath = '/usr/bin/gdb',
      request = 'launch',
      program = '${workspaceFolder}/src/valkey-server',
      -- program = function()
      --   return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      -- end,
      cwd = '${workspaceFolder}',
      -- When I set stopOnEntry to true, it drops me in assembly code. I can still set breakpoint in source code
      -- and the debugger works with source code. But the initial drop in assembly can be confusing.
      stopOnEntry = false,
      setupCommands = {
        {
          text = '-enable-pretty-printing',
          description = 'enable pretty printing',
          ignoreFailures = false,
        },
      },
    },
    -- Print variables using "<variable name>". To use gdb commands, prefix the command with "-exec ".
    -- For e.g. "-exec info registers"
  }
end

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
    'leoluz/nvim-dap-go',

    -- Show variable values in editor
    'theHamsta/nvim-dap-virtual-text',

    -- Telescope integration
    'nvim-telescope/telescope-dap.nvim',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve', -- for go <https://github.com/go-delve/delve>
        'codelldb', -- for C
        -- for C to use with gdb <https://github.com/microsoft/vscode-cpptools>.
        -- Provides OpenDebugAD7
        'cpptools',
      },
    }

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    -- https://github.com/rcarriga/nvim-dap-ui/blob/master/doc/nvim-dap-ui.txt
    -- If dap UI doesn't close for some reason, use :lua require("dapui").close()
    -- https://github.com/rcarriga/nvim-dap-ui/issues/13
    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      element_mappings = {},
      expand_lines = true,
      force_buffers = true,
      floating = {
        border = 'single',
        mappings = {
          close = { 'q', '<Esc>' },
        },
      },
      -- The controls show up in the winbar (top left) of repl window. I use lualine which configures the winbar.
      -- The controls are showing up after I started ignoring dap* in lualine.
      -- If mouse controls are not working, make sure mouse is working in neovim.
      -- https://stackoverflow.com/questions/77560255/set-mouse-a-not-working-on-vim-neovim-in-iterm2
      -- https://github.com/nvim-lualine/lualine.nvim/blob/0a5a66803c7407767b799067986b4dc3036e1983/lua/lualine/extensions/nvim-dap-ui.lua#L4
      controls = {
        element = 'repl', -- Element to show controls on
        enabled = true, -- Show controls on an element (requires winbar feature)
        icons = {
          pause = '',
          play = '',
          step_into = '',
          step_over = '',
          step_out = '',
          step_back = '',
          run_last = '',
          terminate = '',
          disconnect = '',
        },
      },
      layouts = {
        {
          elements = {
            {
              id = 'scopes',
              size = 0.25,
            },
            {
              id = 'breakpoints',
              size = 0.25,
            },
            {
              id = 'stacks',
              size = 0.25,
            },
            {
              id = 'watches',
              size = 0.25,
            },
          },
          position = 'left',
          size = 40,
        },
        {
          elements = {
            {
              id = 'repl',
              size = 0.5,
            },
            {
              id = 'console',
              size = 0.5,
            },
          },
          position = 'bottom',
          size = 10,
        },
      },
      mappings = {
        edit = 'e',
        expand = { '<CR>', '<2-LeftMouse>' },
        open = 'o',
        remove = 'd',
        repl = 'r',
        toggle = 't',
      },
      render = {
        indent = 1,
        max_value_lines = 100,
      },
    }
    vim.fn.sign_define('DapBreakpointRejected', { text = '❌', texthl = '', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpoint', { text = '🟥', texthl = '', linehl = '', numhl = '' })
    vim.fn.sign_define('DapStopped', { text = '➜', texthl = '', linehl = '', numhl = '' })

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    require('dap-go').setup()

    -- C specific
    if vim.loop.os_uname().sysname == 'Darwin' then
      local use_code_lldb = true

      if use_code_lldb then
        configure_codelldb()
      else
        configure_lldb_vscode()
      end
    else
      -- Linux
      configure_gdb_with_dap_support()
      configure_cppdbg()
    end

    -- Copy the same for C and Rust
    dap.configurations.c = dap.configurations.cpp
    dap.configurations.rust = dap.configurations.cpp

    require('nvim-dap-virtual-text').setup {
      commented = true,
    }

    require('telescope').load_extension 'dap'
  end,
}
