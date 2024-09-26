return {
  -- Learnt about this from https://www.youtube.com/watch?v=6V8jdqdygB4
  -- Found good configurations via https://dotfyle.com/plugins/echasnovski/mini.ai
  --
  -- I copied configurations from the following places
  -- Copied from https://github.com/Allaman/nvim/blob/main/lua/core/plugins/mini.lua
  -- LazyVim https://github.com/LazyVim/LazyVim/blob/a1c3ec4cd43fe61e3b614237a46ac92771191c81/lua/lazyvim/plugins/coding.lua#L166
  --
  -- g[<text-object> Move cursor to start of text object. For e.g. g[f will go to start of function.
  -- g]<text-object> Move cursor to end of text object. For e.g. g[f will go to end of function.
  --
  -- v[ai]<text-object> Visually select [a]round/[i]nside text object.
  -- d[ai]<text-object> Delete [a]round/[i]nside text object.
  -- c[ai]<text-object> Change [a]round/[i]nside text object.
  {
    'echasnovski/mini.ai',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    event = { 'BufReadPre', 'BufNewFile' },
    opts = function()
      local ai = require 'mini.ai'
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter { -- code block
            a = { '@block.outer', '@conditional.outer', '@loop.outer' },
            i = { '@block.inner', '@conditional.inner', '@loop.inner' },
          },
          f = ai.gen_spec.treesitter { a = '@function.outer', i = '@function.inner' }, -- function
          c = ai.gen_spec.treesitter { a = '@class.outer', i = '@class.inner' }, -- class
          t = { '<([%p%w]-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' }, -- tags
          d = { '%f[%d]%d+' }, -- digits
          e = { -- Word with case
            { '%u[%l%d]+%f[^%l%d]', '%f[%S][%l%d]+%f[^%l%d]', '%f[%P][%l%d]+%f[^%l%d]', '^[%l%d]+%f[^%l%d]' },
            '^().*()$',
          },
          -- ai_indent and ai_buffer are available from mini.extra https://github.com/echasnovski/mini.extra/blob/main/lua/mini/extra.lua
          -- i = ai_indent, -- indent
          -- g = ai_buffer, -- buffer
          u = ai.gen_spec.function_call(), -- u for "Usage"
          U = ai.gen_spec.function_call { name_pattern = '[%w_]' }, -- without dot in function name
        },
      }
    end,
    config = function(_, opts)
      require('mini.ai').setup(opts)

      -- Copied from
      -- https://github.com/roginfarrer/dotfiles/blob/6df6fd90627548667ade68ffb32cf75146adce2f/nvim/.config/nvim/lua/plugins/mini-ai.lua#L93
      -- This uses which-key's add instead of register. register is deprecated. add expects a
      -- different format than register.
      local objects = {
        { ' ', desc = 'whitespace' },
        { '"', desc = 'balanced "' },
        { "'", desc = "balanced '" },
        { '(', desc = 'balanced (' },
        { ')', desc = 'balanced ) including white-space' },
        { '<', desc = 'balanced <' },
        { '>', desc = 'balanced > including white-space' },
        { '?', desc = 'user prompt' },
        { 'U', desc = 'use/call without dot in name' },
        { '[', desc = 'balanced [' },
        { ']', desc = 'balanced ] including white-space' },
        { '_', desc = 'underscore' },
        { '`', desc = 'balanced `' },
        { 'a', desc = 'argument' },
        { 'b', desc = 'balanced )]}' },
        { 'c', desc = 'class' },
        { 'd', desc = 'digit(s)' },
        { 'e', desc = 'word in CamelCase & snake_case' },
        { 'f', desc = 'function' },
        -- { 'g', desc = 'entire file' },
        -- { 'i', desc = 'indent' },
        { 'o', desc = 'block, conditional, loop' },
        { 'q', desc = 'quote `"\'' },
        { 't', desc = 'tag' },
        { 'u', desc = 'use/call function & method' },
        { '{', desc = 'balanced {' },
        { '}', desc = 'balanced } including white-space' },
      }

      -- o is operator-pending mode
      -- x is visual (only) mode
      -- See :h mapmode-o
      local ret = { mode = { 'o', 'x' } }
      for prefix, name in pairs {
        i = 'inside',
        a = 'around',
        il = 'last',
        ['in'] = 'next',
        al = 'last',
        an = 'next',
      } do
        ret[#ret + 1] = { prefix, group = name }
        for _, obj in ipairs(objects) do
          ret[#ret + 1] = { prefix .. obj[1], desc = obj.desc }
        end
      end
      require('which-key').add(ret)
    end,
  },
}
