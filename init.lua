--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    If you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>

    (If you already know the Neovim basics, you can skip this step.)

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or Neovim features used in Kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help you understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your Neovim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]

-- nvim plugins and data are store in two directories (See also
-- <https://neovim.io/doc/user/builtin.html#stdpath()>)
--
-- Plugin source: ~/.local/share/nvim/
-- State (vim.fn.stdpath "data"): ~/.local/state/nvim/

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

-- Setup python3 path in Linux
if vim.loop.os_uname().sysname == 'Linux' then
  vim.g.python3_host_prog = '/usr/bin/python3'
end

-- Do not auto resize the quickfix to 10 items
vim.g.qf_auto_resize = 1

-- Set max height to be 30
vim.g.qf_max_height = 30

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = false

-- Enable mouse mode, can be useful for resizing splits for example!
-- If mouse is not working when using iTerm, check
-- https://stackoverflow.com/questions/77560255/set-mouse-a-not-working-on-vim-neovim-in-iterm2
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
--  See also `:help 'clipboard-osc52'`
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
-- gitsigns doees not handle mix of staged and unstaged hunks in the same block well
-- <https://github.com/lewis6991/gitsigns.nvim/issues/1102>
-- The workaround suggested in the above issue is to use two signcolumns - one for staged
-- (col 2) and another for unstaged (col 1). There is one glitch though - the signs can mix
-- i.e. the staged sign can end up showing in col1 when there is no unstaged sign available.
-- <https://neovim.io/doc/user/options.html#'signcolumn'>
-- auto:1-2 will use a second column only if there are both staged and unstaged changes in the
-- buffer. Otherwise, it will use a single column.
vim.opt.signcolumn = 'auto:1-2'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.expandtab = true -- In Insert mode, use the appropriate number of spaces to insert a tab.
-- vim.opt.smartindent = true
vim.opt.tabstop = 4 -- Num of spaces that a tab accounts to in the editor
vim.opt.shiftwidth = 4 -- Num of spaces to use for each step of (auto)indent. Used for >>, << etc
vim.opt.softtabstop = 4 -- Num of spaces that a tab accounts for while performing editing operations.

-- Line length above which to break a line. Whether to break a line or not is controlled by formatoptions
vim.opt.textwidth = 100

-- default formatoptions (Use :set formatoptions? to find out)
-- jcroql
-- <https://neovim.io/doc/user/change.html#fo-table>
-- j: Where it makes sense, remove a comment leader when joining lines
-- c: Auto-wrap comments based on text-width
-- r: Automatically insert the current comment leader after hitting <Enter> in Insert mode.
-- o: Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
-- q: Allow formatting of comments with "gq".
-- l: Existing long lines are not broken when entering insert mode
-- n: Treat lines starting with numbers as list items, which helps in preserving the structure when reformatting using gw.
vim.opt.formatoptions:append 'n'
-- To remove a specific option, use
-- vim.opt.formatoptions:remove 'n'
-- Or you can spell out the full options
-- vim.opt.formatoptions = 'jcroqln'

-- Pattern to recognize lists while formatting. This is used only when formatoptions contains 'n'
-- Based on https://vimways.org/2018/formatting-lists-with-vim/
-- WARN: It is tedious to figure out which characters need double backslash and which doesn't.
-- NOTE: This is missing roman numerals. Might need something like
-- <https://stackoverflow.com/questions/267399/how-do-you-match-only-valid-roman-numerals-with-a-regular-expression>
vim.opt.formatlistpat = '^\\s*' --  Optional leading whitespace

vim.opt.formatlistpat:append '[' -- Start character class
vim.opt.formatlistpat:append '\\[({]\\?' -- Optionally match opening punctuation

vim.opt.formatlistpat:append '\\(' -- Start group
vim.opt.formatlistpat:append '[0-9]\\+' -- Numbers
vim.opt.formatlistpat:append '\\|' -- or
vim.opt.formatlistpat:append '[a-zA-Z]\\+' -- Letters
vim.opt.formatlistpat:append '\\)' -- End group

vim.opt.formatlistpat:append '[\\]:.)}' -- Closing punctuation
vim.opt.formatlistpat:append ']' -- End character class

vim.opt.formatlistpat:append '\\s\\+' --  One or more spaces
vim.opt.formatlistpat:append '\\|' --  or
vim.opt.formatlistpat:append '^\\s*[-–+o*•]\\s\\+' --  Bullet points

-- NOTE: Pro-tip: use :options to view all options in Neovim
-- https://www.reddit.com/r/neovim/comments/12d075n/some_people_dont_know_this_options/

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 7

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Disable showing help with F1 is hit. I tend to accidentally hit F1 all the time when I hit Esc.
-- https://vim.fandom.com/wiki/Disable_F1_built-in_help_key
vim.keymap.set('n', '<F1>', '<nop>')
vim.keymap.set('i', '<F1>', '<nop>')

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- You can open the current buffer in a new tab. Once you are done, close the tab with :q.
-- This will help given the options of zooming into a single buffer (when you have multiple windows)
-- and zoom back out by closing the buffer.
-- From https://www.reddit.com/r/vim/comments/16sv7uu/maximizing_windows/
-- Map :tab split to <leader>ts<CR>
vim.keymap.set('n', '<leader>ts', '<cmd>tab split<CR>', { desc = 'Tab split (open current buffer in new tab)' })

-------------------- Quickfix list --------------------
--- NOTE: This does not work. Cfilter is not a valid command in neovim.
---
--- Usecase: You search for reference using LSP (keybinding gr). You then open the list as quickfix
---          list using C-q. You want to remove some of the references in the list based on manual
---          inspection. Use <leader>cdd defined below to delete the current line.
---
--- <https://www.reddit.com/r/vim/comments/xeqdbb/keybinding_to_remove_a_quickfix_entry/>
---
-- matchstr({string}, {pattern})
-- pattern = '.\{-}\ze<bar>'
-- .: Matches any character except a newline.
-- \{-}: Matches as few characters as possible (non-greedy match).
-- \ze: "End match here." Everything before \ze is captured.
-- <bar>: Matches the literal pipe character (|).

-- nnoremap <leader>c<bs> <cmd>exe 'Cfilter! ' .. matchstr(getline('.'), '.\{-}\ze<bar>')<cr>
-- nnoremap <leader>l<bs> <cmd>exe 'Lfilter! ' .. matchstr(getline('.'), '.\{-}\ze<bar>')<cr>

vim.keymap.set('n', '<leader>cdd', function()
  local line = vim.api.nvim_get_current_line()
  -- () is a capture group, but in this case, it's capturing the position where the match occurs rather than a substring.
  -- %| is to escape |.
  local match = line:match '.*()%|' -- Lua pattern to match until the pipe symbol "|"
  if match then
    local command = 'Cfilter! ' .. line:sub(1, match - 1)
    vim.cmd(command)
  end
end, { desc = 'Delete current entry in quickfix list', noremap = true, silent = true })
-------------------------------------------------------

-- Function to save quickfix list
-- Using Csave as it is similar to cfile, caddfile
vim.api.nvim_create_user_command('Csave', function(opts)
  local filename = opts.args

  local qflist = vim.fn.getqflist()
  local file = io.open(filename, 'w')
  if file == nil then
    require 'notify'('Could not open file ' .. filename .. ' for writing.', 'error')
    return
  end
  for _, item in ipairs(qflist) do
    -- If the entry has a bufnr (which is typically the case for search results from telescope), resolve it to a filename
    local resolved_filename = item.filename or (item.bufnr and vim.fn.bufname(item.bufnr)) or '[No File]'
    file:write(string.format('%s|%d col %d| %s\n', resolved_filename, item.lnum, item.col, item.text))
  end
  file:close()

  require 'notify'('Saved quickfix to ' .. filename, 'info')
end, {
  nargs = 1,
  complete = 'file', -- Enable filename completion
})

-- Function to load quickfix list from a file. Loading directly using :cfile does not make the list
-- navigable. So, I have to manually read the file, parse it and add to quicklist using API.
function LoadQuickfix(filename, mode)
  local qf_entries = {}
  local file = io.open(filename, 'r')

  if not file then
    require 'notify'('Could not open file ' .. filename .. ' for reading.', 'error')
    return
  end

  for line in file:lines() do
    -- Parse each line, splitting by the '|' character
    -- e.g. line:
    -- init.lua|272 col 10| function SaveQuickfix(filename)
    local filepath, lnum, col, text = line:match '([^|]+)|(%d+)%s+col%s+(%d+)|%s(.+)'
    if filepath and lnum and col and text then
      table.insert(qf_entries, {
        filename = filepath,
        lnum = tonumber(lnum),
        col = tonumber(col),
        text = text,
      })
    end
  end
  file:close()

  -- Populate the quickfix list using Neovim's API
  -- r replaces the current list
  -- a adds to the existing list
  vim.fn.setqflist(qf_entries, mode)
  if #qf_entries > 0 then
    -- Open the quickfix if the list is not empty
    vim.cmd 'copen'
  end

  require 'notify'('Loaded quickfix from ' .. filename, 'info')
end

-- I am using command names similar to the native commands :cfile and :caddfile.
-- Neovim does not allow starting custom commands with lowercase, so I have not able to redefine
-- :cfile and :caddfile
-- <https://neovim.io/doc/user/quickfix.html>
vim.api.nvim_create_user_command('Cfile', function(opts)
  LoadQuickfix(opts.args, 'r') -- r replaces the current list, using a fresh list
end, {
  nargs = 1,
  complete = 'file', -- Enable filename completion
})

vim.api.nvim_create_user_command('Caddfile', function(opts)
  LoadQuickfix(opts.args, 'a') -- a adds to the current list
end, {
  nargs = 1,
  complete = 'file', -- Enable filename completion
})

-- Open specific quickfix item
function OpenQuickfixEntry(index)
  if type(index) ~= 'number' then
    require 'notify'('Index provided to OpenQuickfixEntry is not a number ' .. index, 'error')
    return
  end

  local qflist = vim.fn.getqflist()
  if #qflist == 0 then
    -- list is empty
    return
  end

  -- If index is out of bounds, set it to 1 (the first entry)
  if index < 1 or index > #qflist then
    index = 1
  end

  -- Jump to the specified entry in the quickfix list
  vim.cmd('cc ' .. index)
end

vim.api.nvim_create_user_command('OpenQuickfixEntry', function(opts)
  OpenQuickfixEntry(tonumber(opts.args))
end, {
  nargs = 1,
})

-- Don't wrap around searches
vim.opt.wrapscan = false

-- Use stack for jumplist.
-- When you backtrack and move forward, the behavior is similar to a stack which is more intuitive.
--
--                                         [A, B, C, D]
--                            [A, B, C]
--                                  ┏━━━━┓  4  ┏━━━━┓
--        [A]       [A, B]      ┌──▶┃ D  ┣─────▶ E  ┃
--                            3 │┌──┻━━━━◀─────┻━━━━┛
--         1          2         ││          5
-- ┏━━━━┓     ┏━━━━┓     ┏━━━━┳─┘│ 6  [A, B, C]
-- ┃ A  ┣─────▶ B  ┣─────▶ C  ┃◀─┘ [A, B]
-- ┗━━━━┛     ┗━━━━┛     ┗━━━━┻─┐
--                              │   ┏━━━━┓     ┏━━━━┓
--                              └──▶┃ F  ┣─────▶ G  ┃
--                               7  ┗━━━━┛  8  ┗━━━━┛
--
--                              [A, B, C]    [A, B, C, F]
--
vim.opt.jumpoptions = 'stack'

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Control behavior of window size when splitting and closing splits
-- https://vimdoc.sourceforge.net/htmldoc/options.html#'equalalways'
-- https://stackoverflow.com/questions/486027/close-a-split-window-in-vim-without-resizing-other-windows
-- When equalalways is false, the size of windows other than the one being split is not affected.
-- Similarly, when closing a window, the extra space is given to only one window, preventing a resize of other windows
vim.opt.equalalways = false

-- Remap quit to quit all - you can only remap uppercase commands, so, I am not able to remap q
-- For convenience: When you press : and try to press q immediately, you might still be holding shift
vim.api.nvim_create_user_command('Q', 'qa', { desc = 'Quit all' })

-- Restart LSP using shortcut
vim.keymap.set('n', '<leader>lr', '<cmd>LspRestart<CR>', { desc = '[L]sp [R]estart' })

-- Open Navbuddy
vim.keymap.set('n', '<leader>nb', '<cmd>Navbuddy<CR>', { desc = 'Open [N]av [B]uddy' })

--------------------------------------------------------------------
-- Conform toggle format on save
-- See <https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#command-to-toggle-format-on-save>
--------------------------------------------------------------------
vim.api.nvim_create_user_command('FormatDisable', function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = 'Disable autoformat-on-save',
  bang = true,
})

vim.api.nvim_create_user_command('FormatEnable', function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = 'Re-enable autoformat-on-save',
})
---------------------------------------------------------------------
local function find_git_dir(current_path)
  while current_path do
    if vim.fn.isdirectory(current_path .. '/.git') == 1 then
      return current_path .. '/.git'
    end

    local parent_path = vim.fn.fnamemodify(current_path, ':h')
    if parent_path == current_path then
      return nil
    end
    current_path = parent_path
  end
end

-- vim.fn.expand '%:.' gives the current buffer name's relative path from the current working directory
-- vim.fn.expand '%:p' gives the absolute path of the current buffer.
-- vim.fn.expand '%:p:h' :h removes the last component in the path, essentially returning the parent of a path
-- Note: I am not using coloring in git log as the colors show up as control characters in VIM fugitive instead of the
-- actual color. E.g. coloring: %C(yellow)%s%Creset
vim.keymap.set('n', '<leader>bc', function()
  -- I am using a function so that vim.fn.expand is evaluated at runtime for the current buffer
  -- instead of being evaluated at neovim startup time.
  vim.cmd('Git' .. ' log --color --pretty=format:"%h %<(10)%as %<(20,trunc)%an(%<(15,trunc)%al) %<(70,trunc)%s" -- ' .. vim.fn.expand '%:p')
end, { desc = '[b]uffer [c]ommits' })

vim.keymap.set(
  'n',
  '<leader>rc',
  '<cmd>Git log --color --pretty=format:"%h %<(10)%as %<(20,trunc)%an(%<(15,trunc)%al) %<(70,trunc)%s"<CR>',
  { desc = '[r]epo [c]ommits' }
)

-----------------------------------------------------------------------------------------------------------
-- View man pages with Neovim
-- https://neovim.io/doc/user/filetype.html#%3AMan
-----------------------------------------------------------------------------------------------------------
vim.g.ft_man_folding_enable = true
vim.g.man_hardwrap = false -- enable soft wrap

-- Make sure to add the following to ~/.zshrc
-- export MANPAGER='nvim +Man!'
-- export MANWIDTH=999
-----------------------------------------------------------------------------------------------------------

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Use jq for formatting json when using jq
-- <https://www.reddit.com/r/neovim/comments/xa4ca6/best_way_to_validate_and_format_json_files/>
vim.cmd [[autocmd! FileType json set formatprg=jq]]

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Convenience function to help dump table in Lua
-- https://stackoverflow.com/questions/9168058/how-to-dump-a-table-to-console
local function dump(o)
  if type(o) == 'table' then
    local s = '{ '
    for k, v in pairs(o) do
      if type(k) ~= 'number' then
        k = '"' .. k .. '"'
      end
      s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
    end
    return s .. '} '
  else
    return tostring(o)
  end
end

-- OS detection
local is_linux = vim.loop.os_uname().sysname == 'Linux'
local is_mac = vim.loop.os_uname().sysname == 'Darwin'

-- Should use clangd in Mac?
-- Use true to use clangd, false to use ccls. You may want to use ccls as it supports call hierarchy
local use_clangd_in_mac = false

-- Should open Neotree on startup?
local open_neo_tree_on_startup = false

-- These are aux windows from plugins that are meant to assist in editing your main file
-- neo-tree is the file explorer on the left
-- Outline is the outline of symbols in the file
-- yggdrasil is used to show call hierachy by vim-ccls
-- noice and notify are from noice (used to show cmdline at the center instead of bottom left)
-- fidget is the notification that you see in the bottom right particularly in Lua files
-- dapui* are debugger windows used by nvim-dap-ui. Ignoring them makes the debug control show up.
local aux_windows = {
  'neo-tree',
  'Outline',
  'yggdrasil',
  'noice',
  'notify',
  'fidget',
  'dapui_watches',
  'dapui_breakpoints',
  'dapui_scopes',
  'dapui_console',
  'dapui_stacks',
  'dap-repl',
  'neotest-summary',
  'toggleterm',
  'trouble',
}
local function is_aux_window(name)
  for i = 1, #aux_windows do
    if aux_windows[i] == name then
      return true
    end
  end
  return false
end

local function is_buffer_visible(bufnr)
  for _, winid in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(winid) == bufnr then
      return true
    end
  end
  return false
end

-- Create autocmd to close the given filetype if it is the only buffer
local function close_file_type_when_only_buffer(file_type_to_close)
  -- If this is the last buffer, it will automatically receive focus, triggering the BufEnter event.
  -- So, we try to check if this is the only buffer of interest.
  vim.api.nvim_create_autocmd('BufEnter', {
    callback = function(e)
      -- Set this to true to see what is keeping nvim from closing
      local debug = false
      local buf_num = e.buf
      local file_type = vim.api.nvim_get_option_value('filetype', { buf = buf_num })
      if debug then
        print('BufEnter: ' .. file_type .. ' focused')
      end

      if file_type == file_type_to_close then
        local bufs = vim.api.nvim_list_bufs()
        local loaded_bufs = 0
        for buf_idx = 1, #bufs do
          if vim.api.nvim_buf_is_loaded(bufs[buf_idx]) then
            local loaded_buf_number = vim.api.nvim_buf_get_number(bufs[buf_idx])

            -- https://neovim.io/doc/user/options.html
            local loaded_buf_type = vim.api.nvim_get_option_value('buftype', { buf = loaded_buf_number })
            local loaded_buf_listed = vim.api.nvim_get_option_value('buflisted', { buf = loaded_buf_number })
            local loaded_buf_modified = vim.api.nvim_get_option_value('modified', { buf = loaded_buf_number })
            local loaded_buf_modifiable = vim.api.nvim_get_option_value('modifiable', { buf = loaded_buf_number })
            local loaded_buf_file_type = vim.api.nvim_get_option_value('filetype', { buf = loaded_buf_number })

            if debug then
              print(
                'Buffer='
                  .. loaded_buf_number
                  .. ', type='
                  .. loaded_buf_type
                  .. ', listed='
                  .. tostring(loaded_buf_listed)
                  .. ', modified='
                  .. tostring(loaded_buf_modified)
                  .. ', modifiable='
                  .. tostring(loaded_buf_modifiable)
                  .. ', filetype='
                  .. loaded_buf_file_type
                  .. ' is still open'
              )
            end

            -- We only care about buffers that are listed or modified
            if loaded_buf_listed or loaded_buf_modified then
              -- We don't care about aux windows.
              -- We don't care about buffers that are of type that we want to close
              if not is_aux_window(loaded_buf_file_type) and loaded_buf_file_type ~= file_type_to_close then
                if is_buffer_visible(loaded_buf_number) then
                  if debug then
                    print('BufEnter: ' .. loaded_buf_file_type .. ' (len: ' .. string.len(loaded_buf_file_type) .. ') is still open')
                  end
                  loaded_bufs = loaded_bufs + 1
                end
              end
            end
          end
        end

        if loaded_bufs == 0 then
          -- Try to quit. This will fail if buffer is dirty
          vim.cmd 'q'
        end
      end
    end,
  })
end

local function get_telescope_dropdown()
  -- See help for telescope.layout.center()
  -- https://github.com/nvim-telescope/telescope.nvim/blob/5a701e99906961218b55d7ad6c2a998f066c6fe0/lua/telescope/pickers/layout_strategies.lua#L395
  return require('telescope.themes').get_dropdown {
    previewer = true,
    layout_strategy = 'center',
    layout_config = {
      width = function(_, max_columns, _)
        return max_columns - math.floor(max_columns / 5) -- 80% of max_columns
      end,

      height = function(_, _, max_lines)
        return math.min(max_lines, 15) -- show limited number of results so more space is given for preview
      end,

      anchor = 'S', -- Anchor to the bottom (south), so the rest of the top is used for dropdown and preview
    },
  }
end

local function map_telescope_using_dropdown_theme(mode, keybinding, builtin_fn, opts)
  vim.keymap.set(mode, keybinding, function()
    -- You can pass additional configuration to Telescope to change the theme, layout, etc.
    builtin_fn(get_telescope_dropdown())
  end, opts)
end

-- Use borders for hover
-- Taken from https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization
vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

local rounded_border = {
  { '╭', 'FloatBorder' },
  { '─', 'FloatBorder' },
  { '╮', 'FloatBorder' },
  { '│', 'FloatBorder' },
  { '╯', 'FloatBorder' },
  { '─', 'FloatBorder' },
  { '╰', 'FloatBorder' },
  { '│', 'FloatBorder' },
}
local function get_lsp_handlers_with_border()
  -- LSP settings (for overriding per client)
  return {
    ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = rounded_border }), -- single, double
    ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = rounded_border }), -- single, double
  }
end

-- true will use neovim's navtive inlay hints. Otherwise, it uses the now archived plugin lvimuser/lsp-inlayhints.nvim
local use_native_inlay_hints = true

-- rust toolchain to use
-- Use "rustup toolchain list" to list all toolchains
local use_nightly_toolchain = false
local rustup_toolchain = 'stable'
if use_nightly_toolchain then
  rustup_toolchain = 'nightly'
end

-- Use vanilla rust analyzer or rustacenavim (mrcjkb/rustaceanvim)
-- Currently I don't see the value add with rustacenavim, so configuring it behind a flag.
local use_vanilla_rust_analyzer = true

-- Logic to save only modified lines on save
-- I don't like the way rustfmt formats ranges of lines. In rust, anyway you have to format the entire file.
-- Update: this works great for python after I added the current buffer name in git diff command. So, I am giving it a
-- shot again.
local enable_format_only_modified_lines_on_save = true

--                               ▲
--                               │
--                               │
--                               │
--             Scrollback        │
--                               │
--
-- ┌────────────────────────────────────┐
-- │                                    │
-- │                                    │
-- │                                    │
-- │              Screen                │
-- │                                    │
-- │                                    │
-- │                                    │
-- └────────────────────────────────────┘
-- Clear buffer on terminal on closing vim. This will not leave traces of the editor on the terminal
-- This approach clears only the screen, not the scrollback
-- https://stackoverflow.com/questions/31595411/how-to-clear-the-screen-after-exit-vim
vim.cmd [[autocmd! VimLeave * :!clear]]

-- local function clear_terminal_scrollback()
--   -- Temporarily set scrollback to the minimum value of 1
--   local original_scrollback = vim.opt.scrollback:get()
--   vim.opt.scrollback = 1
--
--   -- Clear the terminal
--   -- <C-\><C-n> will switch between terminal mode and normal mode
--   -- true: String should be escaped for use in a terminal.
--   -- false: String should not be prefixed with the escape key.
--   -- true: Keys should be treated atomically.
--   -- true: Keys should be fed Synchronously
--   vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-\\><C-n>', true, false, true), 'n', false)
--   -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('clear<CR>', true, false, true), 'n', false)
--   -- https://unix.stackexchange.com/questions/517025/zsh-clear-scrollback-buffer
--   vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('clear && printf "\\e[3J"<CR>', true, false, true), 'n', false)
--   vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('zle && zle .reset-prompt && zle -R<CR>', true, false, true), 'n', false)
--   vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-\\><C-n>', true, false, true), 'n', false)
--
--   -- Reset scrollback to its original value
--   vim.opt.scrollback = original_scrollback
-- end
--
-- -- Call the function on exit
-- vim.api.nvim_create_autocmd('VimLeave', { callback = clear_terminal_scrollback })

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --
  --  This is equivalent to:
  --    require('Comment').setup({})

  -- Comment code blocks using
  -- Normal mode:
  --  Line comment: gcc
  --  Block comment: gbc
  -- Visual mode:
  --  Line comment: gc
  --  Block comment: gb
  { 'numToStr/Comment.nvim', opts = {} },

  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`. This is equivalent to the following Lua:
  --    require('gitsigns').setup({ ... })
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  -- TODO: Clean this up. I have declared gitsigns below.
  -- { -- Adds git related signs to the gutter, as well as utilities for managing changes
  --   'lewis6991/gitsigns.nvim',
  --   opts = {
  --     -- signs = {
  --     --   add = { text = '+' },
  --     --   change = { text = '~' },
  --     --   delete = { text = '_' },
  --     --   topdelete = { text = '‾' },
  --     --   changedelete = { text = '~' },
  --     -- },
  --   },
  -- },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --  config = function() ... end

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default whick-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  -- Telescope is the fuzzy finder. You can find almost anything with it.
  --
  -- Keybindings:
  -- ============
  --
  -- <C-n>/<C-p>: Navigate between the search results.
  -- Tab: Toggle selection of search result.
  -- <C-q>: Open all search results in quickfix list.
  -- <M-q>: Open only the selected search results in quickfix list. NOTE: it adds to the existing qf list
  --
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },

      -- use telescope for command prompt. With this, you can position the cmd prompt at the center of the screen.
      { 'jonarrien/telescope-cmdline.nvim' },

      -- undo tree
      'debugloop/telescope-undo.nvim',
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        defaults = {
          -- Ignore files in specific paths from showing up in telescope
          file_ignore_patterns = {
            'build/private/',
            -- Git files
            '.git/',
            -- Rust build files
            'target/debug/',
            'target/release/',
          },

          mappings = {
            -- Allow refining the search i.e. search on top of existing search results. I am using
            -- ALT + ENTER. The default suggested in kickstart is C-Enter which is hard to type in
            -- Kinesis keyboards.
            --
            -- Note the following conflicts in Mac:
            -- ALT + ENTER: Fullscreen in wezterm by default. I have disabled it in wezterm.
            -- ALT + SPACE: Open Alfred
            -- CMD + SPACE: Open Alfred/spotlight
            --
            i = { ['<A-ENTER>'] = 'to_fuzzy_refine' },
          },

          -- Default scroll_strategy is cycle which will go to the first result when you try to go
          -- to next result from the last result. Limit will stay at the last result.
          scroll_strategy = 'limit',
        },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
          undo = {
            -- telescope-undo.nvim config, see below
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'cmdline')
      pcall(require('telescope').load_extension 'undo')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      map_telescope_using_dropdown_theme('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      map_telescope_using_dropdown_theme('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      map_telescope_using_dropdown_theme('n', '<leader>sf', function(opts)
        opts = opts or {}
        opts.hidden = true -- show hidden files as well
        builtin.find_files(opts)
      end, { desc = '[S]earch [F]iles' })
      map_telescope_using_dropdown_theme('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      map_telescope_using_dropdown_theme('n', '<leader>su', builtin.grep_string, { desc = '[S]earch [U]sages for word under cursor' })
      map_telescope_using_dropdown_theme('n', '<leader>sw', function(opts)
        -- NOTE: lsp_workspace_symbols vs lsp_dynamic_workspace_symbols: Use the dynamic version for
        --       interactive search where you type in the symbols. The following is a static search
        --       that looks up the exact word and is also blocking. I have mapped the dynamic search
        --       to the keybinding <leader>ws.
        opts = opts or {}
        opts.query = vim.fn.expand '<cword>'
        builtin.lsp_workspace_symbols(opts)
      end, { desc = '[S]earch [W]ord under cursor in workspace symbols' })
      map_telescope_using_dropdown_theme('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      map_telescope_using_dropdown_theme('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      map_telescope_using_dropdown_theme('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      map_telescope_using_dropdown_theme('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      -- Pick a buffer by searching. Also see the bufferline keybinding below which uses <leader>bp to
      -- pick a buffer by typing characters.
      map_telescope_using_dropdown_theme('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      map_telescope_using_dropdown_theme('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = '[/] Fuzzily search in current buffer' })

      -- Search in quickfix list
      map_telescope_using_dropdown_theme('n', '<leader>sq', builtin.quickfix, { desc = '[S]earch [Q]uickfix' })

      -- Search in undo tree
      map_telescope_using_dropdown_theme('n', '<leader>u', function(opts)
        opts = opts or {}
        opts.side_by_side = true
        require('telescope').extensions.undo.undo(opts)
      end, { desc = '[u]ndo tree search' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      map_telescope_using_dropdown_theme('n', '<leader>s/', function(opts)
        opts = opts or {}
        opts.grep_open_files = true
        opts.prompt_title = 'Live Grep in Open Files'
        builtin.live_grep(opts)
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      map_telescope_using_dropdown_theme('n', '<leader>sn', function(opts)
        opts = opts or {}
        opts.cwd = vim.fn.stdpath 'config'
        builtin.find_files(opts)
      end, { desc = '[S]earch [N]eovim files' })

      -- Search messages (notifications from notify)
      map_telescope_using_dropdown_theme('n', '<leader>sm', require('telescope').extensions.notify.notify, { desc = '[S]earch [M]essages' })
    end,
    keys = {
      -- Uncomment this to use telescope for cmdline instead of Noice
      -- { ':', '<cmd>Telescope cmdline<cr>', desc = 'Cmdline' },
    },
  },

  -- For winbar (top) and status line (bottom)
  --
  --   a b c                                           x y z
  -- ┌───────────────────────────────────────────────────────┐ tabline
  -- ├───────────────────────────────────────────────────────┤
  -- ├───────────────────────────────────────────────────────┤  winbar
  -- │                                                       │
  -- │                                                       │
  -- │                                                       │
  -- │                                                       │
  -- │                                                       │
  -- │                                                       │
  -- │                                                       │
  -- │                                                       │
  -- │                                                       │
  -- ├───────────────────────────────────────────────────────┤
  -- └───────────────────────────────────────────────────────┘ statusline
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'arkav/lualine-lsp-progress', -- helps show lsp indexing progress
      'SmiteshP/nvim-navic', -- breadcrumbs
    },
    config = function()
      require('lualine').setup {
        winbar = { -- configuring only the winbar
          lualine_a = {
            -- Always show the file name so that when there are no breadcrumbs the buffer won't jump
            -- up and down
            {
              'filename',
              path = 0, -- Just the filename
            },
          },
          lualine_b = {
            -- breadcrumbs using nvim-navic
            {
              'navic',
              color_correction = nil,
              navic_opts = nil,
            },
          },
        },
        options = {
          disabled_filetypes = { -- Filetypes to disable lualine for.
            statusline = aux_windows, -- statusline won't be drawn for these file types
            winbar = aux_windows, -- winbar won't be drawn for these file types
          },
          ignore_focus = aux_windows, -- When you focus the aux windows, they will continue to show the status from previous window
          globalstatus = true, -- Have a single status line across all windows instead of one per window
        },
        sections = {
          lualine_a = {
            'mode',
          },
          lualine_b = {
            -- Show recording note when macro is being recorded (i.e. recording @q)
            -- https://www.reddit.com/r/neovim/comments/yvq93j/noicenvim_macros_key_q_not_working_anymore/
            -- Followed https://github.com/folke/noice.nvim/wiki/A-Guide-to-Messages#showmode, but the example in that
            -- wiki uses deprecated field. Followed https://github.com/folke/noice.nvim/discussions/246
            {
              require('noice').api.status.mode.get,
              cond = require('noice').api.status.mode.has,
              color = { fg = '#ff9e64' },
            },
            'branch',
            'diagnostics',
          }, -- 'branch', 'diff', 'diagnostics'
          lualine_c = {
            {
              'filename',
              file_status = true, -- Displays file status (readonly status, modified status)
              newfile_status = false, -- Display new file status (new file means no write after created)
              path = 1,
              -- 0: Just the filename
              -- 1: Relative path
              -- 2: Absolute path
              -- 3: Absolute path, with tilde as the home directory
              -- 4: Filename and parent dir, with tilde as the home directory

              shorting_target = 40, -- Shortens path to leave 40 spaces in the window

              symbols = {
                modified = '[*]', -- Text to show when the file is modified.
                readonly = '[R]', -- Text to show when the file is non-modifiable or readonly.
                unnamed = '[No Name]', -- Text to show for unnamed buffers.
                newfile = '[New]', -- Text to show for newly created file before first write
              },
            },
            'lsp_progress',
          },
          lualine_x = {
            -- {
            --   'filename',
            --   path = 0, -- Just the filename
            -- },
            -- 'encoding', -- UTF-8 etc. Not very useful. Removing to reduce noise
            -- 'fileformat', -- shows unix, dos, mac
            'filetype',
          },
          lualine_z = {
            'location',
            'selectioncount',
          },
        },
      }
    end,
    opts = {},
  },

  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      { 'folke/neodev.nvim', opts = {} },

      -- Gray out code within undefined symbols in c and cpp
      -- You also need to configure lspconfig.ccls.setup to turn on highlight.
      {
        'jackguo380/vim-lsp-cxx-highlight',
        opts = {},
        config = function() end, -- dummy config function for vimscript plugins
      },
    },
    config = function()
      -- Brief aside: **What is LSP?**
      --
      -- LSP is an initialism you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc)
            map_telescope_using_dropdown_theme('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          local map_no_dropdown = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          local telescope_builtin = require 'telescope.builtin'
          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', telescope_builtin.lsp_definitions, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', function(opts)
            opts = opts or {}
            -- extend it
            opts.fname_width = 50
            telescope_builtin.lsp_references(opts)
          end, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', telescope_builtin.lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map_no_dropdown('<leader>D', telescope_builtin.lsp_type_definitions, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ds', function(opts)
            opts = opts or {}
            -- extend it
            opts.symbol_width = 50
            telescope_builtin.lsp_document_symbols(opts)
          end, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('<leader>ws', function(opts)
            opts = opts or {}
            -- extend it
            opts.fname_width = 50
            telescope_builtin.lsp_dynamic_workspace_symbols(opts)
          end, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map_no_dropdown('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map_no_dropdown('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

          -- Opens a popup that displays documentation about the word under your cursor
          --  See `:help K` for why this keymap.
          map_no_dropdown('K', vim.lsp.buf.hover, 'Hover Documentation')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map_no_dropdown('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client == nil then
            return
          end
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end

          local bufnr = event.buf
          local signature_setup = {
            bind = true, -- This is mandatory, otherwise border config won't get registered.
            handler_opts = {
              border = 'single', -- double, rounded, single, shadow, none, or a table of borders
            },
          }
          require('lsp_signature').on_attach(signature_setup, bufnr)

          -- Attach lsp based breadcrumb
          if client.server_capabilities.documentSymbolProvider then
            require('nvim-navic').attach(client, bufnr)
          end

          -- Don't open the outline for lua files
          if string.match(event.file, 'lua$') == nil then
            -- Open symbols outline :Outline! (! keeps the focus on the current buffer)
            --
            -- Since I added NavBuddy, let me see if I still use outline that much
            -- require('outline').open_outline { focus_on_open = false }
          end

          -- Navbuddy - attach it only if the lsp has documentSymbol capability. For e.g. ruff_lsp for python doesn't have this
          if client.server_capabilities.documentSymbolProvider then
            require('nvim-navbuddy').attach(client, bufnr)
          end

          if use_native_inlay_hints then
            -- Enable inlay hints (available since Neovim 0.10)
            -- <https://neovim.io/doc/user/lsp.html#_lua-module:-vim.lsp.inlay_hint>
            -- Native inlay shows up only on edit i.e. after inserting any char. Similar question
            -- <https://www.reddit.com/r/neovim/comments/1fklbks/inlay_hints_only_appear_after_re_enabling_them/>
            vim.lsp.inlay_hint.enable(true)
          else
            -- lsp-inlayhints is archived as of Feb 2024
            require('lsp-inlayhints').on_attach(client, bufnr)
          end

          -- Open floating preview
          -- https://neovim.io/doc/user/lsp.html#vim.lsp.util.open_floating_preview()
          -- TODO: Is there a way to use this to show preview of definition
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- gopls = {},
        -- pyright = {}, -- Python. NOTE: See below, pyright is added conditionally only if npm is available
        -- rust_analyzer = {}, -- NOTE: Don't use the rust analyzer from mason. Use rust-analyzer from your rustup toolchain
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`tsserver`) will work just fine
        -- tsserver = {},
        --
        marksman = {}, -- Markdown

        lua_ls = {
          -- cmd = {...},
          -- filetypes = { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- pyright is written in typescript and requires npm to be installed.
      -- In Linux, you can install using "sudo yum install -y npm"
      --  https://neovim.io/doc/user/builtin.html
      if vim.fn.executable 'npm' == 1 then
        -- npm exists
        if vim.fn.executable 'ruff-lsp' == 1 then
          servers.pyright = {
            settings = {
              pyright = {
                -- Using Ruff's import organizer
                disableOrganizeImports = true,
              },
              python = {
                analysis = {
                  -- Ignore all files for analysis to exclusively use Ruff for linting
                  ignore = { '*' },
                },
              },
            },
          }
        else
          servers.pyright = {}
        end
      end

      -- clangd from mason is available only on Mac
      if is_mac and use_clangd_in_mac then
        -- MacOS
        servers.clangd = {}
      end

      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu.
      require('mason').setup()

      -- https://github.com/williamboman/mason.nvim/discussions/880
      if is_linux then
        local mason_registry = require 'mason-registry'
        local package = mason_registry.get_package 'lua-language-server'
        -- This is the last version that works with glibc 2.26 (AL2 has glibc 2.26 only)
        -- Versions beyond 3.7.4 require glibc 2.26+
        local lua_ls_version = '3.7.4'
        if not package:is_installed() then
          package:install { version = lua_ls_version }
        else
          -- If lua_ls got updated accidentally (say using the :Mason UI), downgrade it
          package:get_installed_version(function(success, version_or_err)
            if success then
              local version = version_or_err
              if version ~= lua_ls_version then
                package:uninstall()
                package:install { version = lua_ls_version }
              end
            end
          end)
        end
      end

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code

        -- python specific
        'ruff', -- extremely fast python linter. Replacement for black https://docs.astral.sh/ruff/
        'ruff-lsp', -- Python linter lsp based on ruff
        'black', -- formatter
        'debugpy', -- debugging
        'isort', -- sort imports
        'flake8', -- linter - checks for errors, styling issues and complexity
        'mypy', -- static type checker for python
        'pylint', -- static code analyzer

        --toml
        'taplo',
      })
      -- mason tool installer's ensure installed doesn't support version
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        -- This ensure installed supports version
        ensure_installed = { 'lua_ls@3.7.4' },
        handlers = {
          function(server_name)
            -- Mason auto load clangd if it is installed in the system
            if server_name == 'clangd' and not use_clangd_in_mac then
              return
            end

            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            server.handlers = get_lsp_handlers_with_border()
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
      -- Use ccls only in linux. clangd is available in Mac which makes things easier
      if is_linux or not use_clangd_in_mac then
        local function find_path_to_file(filename)
          -- Find needs an absolute path if you want it to output absolute paths
          local cwd = vim.fn.getcwd()
          -- -print -quit will quit on first match
          -- Using maxdepth for a faster start up time
          local find_command = 'find ' .. cwd .. ' -maxdepth 2 -type f -name "' .. filename .. '" -print -quit | xargs -I {} dirname {}'
          for entry in io.popen(find_command):lines() do
            return entry
          end
          return ''
        end

        -- Automatically find the directory where compile_commands.json is located
        -- Note that ccls expects the absolute path. If you give a relative path like ., it won't work.
        local compile_commands_json_dir = find_path_to_file 'compile_commands.json'

        local lspconfig = require 'lspconfig'
        lspconfig.ccls.setup {
          -- See https://github.com/MaskRay/ccls/wiki/Customization for options.
          -- The only way to set the log file location is via the command line argument
          cmd = { 'ccls', '--log-file=' .. vim.fn.expand '$HOME/ccls-log.log', '-v=1' },
          init_options = {
            index = {
              threads = 0,
            },
            cache = {
              format = 'binary', -- json, binary
            },
            clang = {
              excludeArgs = { '-frounding-math' },
            },
            compilationDatabaseDirectory = compile_commands_json_dir,
            highlight = {
              lsRanges = true, -- Along with jackguo380/vim-lsp-cxx-highlight, helps dim code within undefined macros
            },
            offset_encoding = 'utf-8',
          },
          handlers = get_lsp_handlers_with_border(),
        }
      end

      if use_vanilla_rust_analyzer then
        -- LSP config for rust. Use rust-analyzer from the rustup toolchain.
        require('lspconfig').rust_analyzer.setup {
          -- Ask rustup to run the rust-analyzer from stable toolchain
          cmd = { 'rustup', 'run', rustup_toolchain, 'rust-analyzer' },
          settings = {
            ['rust-analyzer'] = {
              server = {
                extraEnv = {
                  ['foo'] = 'bar', -- placeholder env variables
                },
              },
              cargo = {
                ['unsetTest'] = { 'mod1', 'mod2' }, -- placeholder modules where test config must be unset
              },
              cfg = {
                -- When <https://github.com/rust-lang/rust-analyzer/pull/18085> is merged, this config
                -- is necessary to unset tests. This will prevent rust analyzer from show test
                -- references and will also dim the test code.
                ['setTest'] = false,
              },
              check = {
                command = 'clippy', -- default is 'check' https://users.rust-lang.org/t/how-to-use-clippy-in-vs-code-with-rust-analyzer/41881
              },
            },
          },
          capabilities = capabilities,
          handlers = get_lsp_handlers_with_border(),
        }
      end

      -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ruff_lsp
      if vim.fn.executable 'ruff-lsp' == 1 then
        require('lspconfig').ruff_lsp.setup {
          init_options = {
            settings = {
              -- Any extra CLI arguments for `ruff` go here.
              args = {},
            },
          },
          capabilities = capabilities,
          on_attach = function(client, _)
            -- Disable hover in favor of Pyright
            client.server_capabilities.hoverProvider = false
            -- https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/
            client.server_capabilities.documentSymbolProvider = false
          end,
          handlers = get_lsp_handlers_with_border(),
        }
      end
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    branch = 'master', -- without specifying the branch, I was seeing older version of the plugin at ~/.local/share/nvim/lazy/conform.nvim which couldn't handle function in formatters_by_ft
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        local timeout_ms = 1000
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local ignore_filetypes = { 'c', 'cpp', 'lua' }
        local curr_buffer_ft = vim.bo[bufnr].filetype
        if vim.tbl_contains(ignore_filetypes, curr_buffer_ft) then
          -- Don't use LSP for formatting
          return { timeout_ms = timeout_ms, lsp_fallback = false }
        end

        -- taplo for toml currently doesn't support ranges
        local ft_format_entire_file = { 'rust', 'toml' }
        if vim.tbl_contains(ft_format_entire_file, curr_buffer_ft) or not enable_format_only_modified_lines_on_save then
          -- Use LSP for formatting. For e.g. rust uses rust-analyzer
          return { timeout_ms = timeout_ms, lsp_fallback = true }
        end

        -- format only modified lines in current buffer based on git. Taken from https://github.com/stevearc/conform.nvim/issues/92
        -- --unified=0 tells the diff to have 0 lines of context (before and after)
        local lines = vim.fn.system('git diff --unified=0 ' .. vim.fn.bufname(bufnr)):gmatch '[^\n\r]+'
        local ranges = {}
        for line in lines do
          if line:find '^@@' then
            --     Del   Add
            --  @@ -31,2 +39 @@ class TestRedisClusterSlotMigration(RedisClusterSlotMigrationTestCaseBase):
            local line_nums = line:match '%+.- '
            if line_nums:find ',' then
              local _, _, first, second = line_nums:find '(%d+),(%d+)'
              table.insert(ranges, {
                start = { tonumber(first), 0 },
                ['end'] = { tonumber(first) + tonumber(second), 0 },
              })
            else
              local first = tonumber(line_nums:match '%d+')
              table.insert(ranges, {
                start = { first, 0 },
                ['end'] = { first + 1, 0 },
              })
            end
          end
        end
        local format = require('conform').format
        for _, range in pairs(ranges) do
          format { range = range, timeout_ms = timeout_ms }
        end
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { 'ruff_fix', 'ruff_format' },
        python = function(bufnr)
          if require('conform').get_formatter_info('ruff_format', bufnr).available then
            return { 'ruff_fix', 'ruff_format' }
          else
            return { 'isort', 'black' }
          end
        end,
        toml = { 'taplo' },
        --
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
        -- javascript = { { "prettierd", "prettier" } },
      },
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
      },
      'saadparwaiz1/cmp_luasnip',

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          -- Scroll the documentation window [b]ack / [f]orward
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ['<C-y>'] = cmp.mapping.confirm { select = true }, -- This is the key to insert the currently selected text in dropdown

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping.complete {},

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        },
        sources = {
          {
            name = 'nvim_lsp',
            entry_filter = function(entry, _ctx)
              -- Don't show text suggestions. These get in the way of thinking
              return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] ~= 'Text'
            end,
          },
          { name = 'luasnip' },
          { name = 'path' },
        },
      }
    end,
  },

  -- Show inlay hints using LSP server. This shows the parameter name on the right which is helpful while reading.
  -- This is archived as of Feb 2024. Neovim 0.10 natively supports inlay hints.
  {
    'lvimuser/lsp-inlayhints.nvim',
    opts = {},
    enabled = not use_native_inlay_hints,
  },

  -- Show signature of the method as you type the invocation. This is helpful while invoking the function.
  {
    'ray-x/lsp_signature.nvim',
    event = 'VeryLazy',
    opts = {},
  },

  -- Rust tools -> Rustacean vim
  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    ft = { 'rust' },
    enabled = not use_vanilla_rust_analyzer,
    config = function()
      ---@type RustaceanOpts
      vim.g.rustaceanvim = {
        ---@type RustaceanLspClientOpts
        server = {
          cmd = { 'rustup', 'run', rustup_toolchain, 'rust-analyzer' },

          -- rust-analyzer language server configuration
          ['rust-analyzer'] = {
            server = {
              extraEnv = {
                ['foo'] = 'bar', -- placeholder env variables
              },
            },
            cargo = {
              ['unsetTest'] = { 'mod1', 'mod2' }, -- placeholder modules where test config must be unset
            },
          },
        },
      }
    end,
  },

  -- Show recent buffers as tabs at the top
  -- See :h bufferline-configuration
  -- :BufferLineCloseOthers (to close all other buffers)
  -- :BufferLinePick (to visually pick a buffer based on the showcased letters)
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
      options = {
        max_name_length = 30,
        diagnostics = 'nvim_lsp',
        show_buffer_close_icons = true,
        offsets = {
          {
            filetype = 'neo-tree', -- The filetype of the window you want to offset for
            text = '', -- Text displayed in the bufferline when the offset is active
            highlight = 'Directory', -- The highlight group for the text
            text_align = 'left', -- Alignment of the text ("left", "center", "right")
            separator = true, -- Show a separator between the offset and the buffers (optional)
          },
        },
      },
    },
    config = function(_, opts)
      require('bufferline').setup(opts)

      -- Pick a buffer by typing the character shown (this is similar to the link navigation using Vimium in Chrome)
      -- Also see the telescope keybinding above to search and pick a buffer using <leader><leader>
      vim.keymap.set('n', '<leader>bp', '<cmd>BufferLinePick<CR>', { desc = '[B]uffer [P]ick', silent = true })
    end,
  },

  -- File explorer on the left. Use :Neotree to open it
  -- :Neotree
  -- :Neotree buffers dir=/
  -- :Neotree git_status
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    lazy = false,
    config = function()
      require('neo-tree').setup {
        close_if_last_window = true,
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,
            hide_hidden = false,
          },
          bind_to_cwd = true,
          follow_current_file = {
            enabled = true,
          },
          hijack_netrw_behavior = 'disabled',
          use_libuv_file_watcher = true,
        },
        buffers = {
          -- https://github.com/nvim-neo-tree/neo-tree.nvim/discussions/1407
          -- :Neotree buffers dir=/
          leave_dirs_open = false,
          follow_current_file = {
            enabled = true,
          },
          bind_to_cwd = false,
        },
      }

      -- Open Neotree using <leader>[E]xplorer
      -- action=show will open Neotree but keep the focus on the current buffer
      vim.keymap.set('n', '<leader>E', '<cmd>Neotree toggle action=show<CR>', { desc = '[E]xplorer' })
    end,
  },

  -- Code folding based on syntax
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    opts = {},
    config = function()
      -- https://github.com/kevinhwang91/nvim-ufo
      vim.o.foldcolumn = '1' -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

      -- Option 2: nvim lsp as LSP client.
      -- I disabled this option for the following 2 reasons. Option 3 solves both the problems.
      -- 1. It created folds only for functions. It didn't create folds for blocks within a function.
      -- 2. It didn't create folds for block comments.
      -- local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- capabilities.textDocument.foldingRange = {
      --   dynamicRegistration = false,
      --   lineFoldingOnly = true,
      -- }
      -- local language_servers = require('lspconfig').util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
      -- for _, ls in ipairs(language_servers) do
      --   require('lspconfig')[ls].setup {
      --     capabilities = capabilities,
      --     -- you can add other fields for setting up lsp server in this table
      --   }
      -- end

      -- require('ufo').setup()

      -- Option 3: treesitter as a main provider instead
      -- (Note: the `nvim-treesitter` plugin is *not* needed.)
      -- ufo uses the same query files for folding (queries/<lang>/folds.scm)
      -- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`
      require('ufo').setup {
        provider_selector = function(bufnr, filetype, buftype)
          return { 'treesitter', 'indent' }
        end,
      }
    end,
  },

  -- diff view
  -- Commands:
  --
  -- :DiffviewOpen
  -- :DiffviewFileHistory
  -- :DiffviewFileHistory %
  --
  -- Keybindings:
  -- See https://github.com/sindrets/diffview.nvim/blob/main/doc/diffview_defaults.txt
  --   [x Previous conflict
  --   x] Next conflict
  --   dx Delete the conflict
  --   dX Delete all conflicts
  --
  --
  --                        <leader>cb
  --                        <leader>cB
  --
  --                          ┌────┐
  --                          │Base│
  --                          └────┘
  --                             │
  --                  ┌──────────┼───────────┐
  --                  │                      │
  --                  ▼          │           ▼
  --               ┌────┐                ┌──────┐
  --               │Ours│        │       │Theirs│
  --               └────┘                └──────┘
  --                             │
  --          ┌─────────────┐          ┌─────────────┐
  --          │             │    │     │             │
  --          │             │          │             │
  --          │             │          │             │
  --          │             │    │     │             │
  --          └─────────────┘          └─────────────┘
  --                             │
  --                 └ ─ ─ ─ ─ ─ ┐─ ─ ─ ─ ─ ─ ┘
  --  <leader>co                 ▼               <leader>ct
  --  <leader>cO          ┌─────────────┐        <leader>cT
  --                      │             │
  --                      │             │
  --                      │             │
  --                      │             │
  --                      └─────────────┘
  --                         End result
  --
  --
  -- From within the file explorer in the diff view
  --  s stage/unstage (toggle staging)
  --  S stage all
  --  U unstage all
  --  X restore from left
  --
  -- :h diff-mode
  --   Works with ranges
  --   :diffget
  --   :diffput
  --
  --   Works without ranges
  --   :diffobtain or :do
  --   :diffput
  --
  { 'sindrets/diffview.nvim', lazy = false, priority = 1000, opts = {} },

  -- Symbols outline's author has archived the repo due to lack of time
  -- { 'simrat39/symbols-outline.nvim', lazy = false, opts = {} },

  -- outline is a fork of symbols-outline that supports keeping the focus on current buffer
  -- https://github.com/simrat39/symbols-outline.nvim/issues/143
  {
    'hedyhli/outline.nvim',
    lazy = false,
    cmd = { 'Outline', 'OutlineOpen' },
    keys = { -- Example mapping to toggle outline
      -- With !, focus stays in the current buffer. Without it, focus moves to Outline.
      -- If I open outline, I want to focus it, so I am not using !.
      -- FIXME: If I don't open Outline on LspAttach and rather rely on this command to open, the filetype is not set as
      -- Outline. My logic to close vim when Outline is the last open buffer works only when filetype is set correctly.
      { '<leader>o', '<cmd>Outline<CR>', desc = 'Toggle outline' },
    },
    opts = {},
    config = function(opts)
      require('outline').setup(opts)
      -- Close if outline is the only buffer of interest
      close_file_type_when_only_buffer 'Outline'
    end,
  },

  -- Show trailing whitespace
  -- Empty config function is required to avoid error while loading vim plugin
  -- https://www.reddit.com/r/AstroNvim/comments/17p224n/how_do_i_track_down_this_error_lua_module_not/
  -- If a file already has lots of trailing whitespaces and the red highlight is distracting, toggle whitespace using :ToggleWhitespace
  {
    'ntpeters/vim-better-whitespace',
    config = function()
      vim.g.better_whitespace_enabled = 1

      -- For this to work in Mac, make sure to install GNU diff using brew install diffutils
      -- TODO: These two should be enabled in Mac only if diff command is from GNU.
      vim.g.strip_whitespace_on_save = 1
      vim.g.strip_only_modified_lines = 1

      vim.g.strip_whitespace_confirm = 0
      vim.g.strip_max_file_size = 0
    end,
    opts = {},
  },

  -- Git related
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      -- gitsigns doees not handle mix of staged and unstaged hunks in the same block well
      -- <https://github.com/lewis6991/gitsigns.nvim/issues/1102>
      -- The workaround is to use two sign columns using vim.opt.signcolumn. See this option defined
      -- earlier in this file.

      require('gitsigns').setup {
        linehl = false, -- When the line is highlighted green or red, it is hard to read code
        numhl = true,
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then
              return ']c'
            end
            vim.schedule(function()
              -- target = 'all' navigates to staged or unstaged changes. By default, it navigates only unstaged changes.
              gs.next_hunk { target = 'all' }
            end)
            return '<Ignore>'
          end, { expr = true })

          map('n', '[c', function()
            if vim.wo.diff then
              return '[c'
            end
            vim.schedule(function()
              -- target = 'all' navigates to staged or unstaged changes. By default, it navigates only unstaged changes.
              gs.prev_hunk { target = 'all' }
            end)
            return '<Ignore>'
          end, { expr = true })

          -- Actions
          map('n', '<leader>hs', gs.stage_hunk, { desc = '[h]unk [s]tage' })
          map('n', '<leader>hr', gs.reset_hunk, { desc = '[h]unk [r]eset' })

          map('v', '<leader>hs', function()
            gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
          end, { desc = '[h]unk [s]tage' })

          map('v', '<leader>hr', function()
            gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
          end, { desc = '[h]unk [r]eset' })

          -- I think this is whether to add to index and undo it
          map('n', '<leader>hS', gs.stage_buffer, { desc = 'Stage buffer' })
          map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'Undo stage buffer' })
          map('n', '<leader>hR', gs.reset_buffer, { desc = 'Reset buffer' })
          -- Once you open a hunk, you can cycle through the hunks using [c (prev change) and ]c (next change)
          -- use preview_hunk_inline if you don't like the floating window in the future
          map('n', '<leader>hp', gs.preview_hunk, { desc = '[h]unk [p]review' })
          map('n', '<leader>hb', function()
            gs.blame_line { full = true }
          end, { desc = '[h]unk [b]lame' })

          map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = '[t]oggle [b]lame for current line' })
          -- Diff views
          -- When you open a diff view, the file stays on the right. The left side shows the index or previous commit.
          -- When you are done, close the left window to return back to the file.
          map('n', '<leader>hd', gs.diffthis, { desc = '[h]unk [d]iff this (against index)' })
          map('n', '<leader>hD', function()
            gs.diffthis '~' -- this is the git notation for last commit
          end, { desc = '[h]unk [D]iff this (against last commit)' })

          map('n', '<leader>td', gs.toggle_deleted, { desc = '[t]oggle [d]eleted' })

          -- List hunks in quickfix list
          map('n', '<leader>hlb', function()
            -- Hunks in current buffer only
            require('gitsigns').setqflist 'attached'
          end, { desc = '[h]unk [l]ist [b]uffer' })

          map('n', '<leader>hla', function()
            -- List all hunks - across files
            require('gitsigns').setqflist 'all'
          end, { desc = '[h]unk [l]ist [a]ll' })

          -- Text object
          map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end,
      }
      -- vim.keymap.set('n', '<leader>gp', ':Gitsigns preview_hunk<CR>', {})
    end,
    lazy = false,
    opts = {},
  },

  -- For git blame gutter
  -- Empty config function is required to avoid error while loading vim plugin
  -- https://www.reddit.com/r/AstroNvim/comments/17p224n/how_do_i_track_down_this_error_lua_module_not/
  { 'tpope/vim-fugitive', config = function() end, opts = {} },

  -- For quickfix list shortcuts. Especially to delete an item on the list
  {
    'romainl/vim-qf',
    config = function()
      -- If quickfix is the only visible buffer, close neovim
      close_file_type_when_only_buffer 'qf'

      -- Original vimscript from
      -- <https://www.reddit.com/r/vim/comments/xeqdbb/keybinding_to_remove_a_quickfix_entry/>
      -- " Normal: `dd` removes item from the quickfix list.
      -- " Visual: `d` removes all selected items, gk keeps all selected items
      -- augroup custom_qf_mapping
      --   autocmd!
      --   autocmd FileType qf nnoremap <buffer> dd :.Reject<CR>
      --   autocmd FileType qf xnoremap <buffer> d :'<,'>Reject<CR>
      --   autocmd FileType qf nnoremap <buffer> gk :.Keep<CR>
      --   autocmd FileType qf xnoremap <buffer> gk :'<,'>Keep<CR>
      -- augroup END

      -- Generated lua using ChatGPT and hand modified it.
      -- Create an augroup for custom quickfix mappings
      -- clear = true ensures that any previous autocommands in this group are cleared.
      vim.api.nvim_create_augroup('custom_qf_mapping', { clear = true })

      -- Define autocommands for FileType qf
      -- first argument is the event. In this case when FileType is set on the buffer.
      vim.api.nvim_create_autocmd('FileType', {
        group = 'custom_qf_mapping',
        pattern = 'qf',
        callback = function()
          -- Use false to use the default behavior of showing quickfix at the bottom
          local show_qf_on_the_right = true

          if show_qf_on_the_right then
            -- Move the quickfix window to the right
            vim.cmd 'wincmd L'
            -- I don't want quickfix to take up half of the screen. So limit it to 80 cols
            vim.cmd 'vertical resize 80'
          else
            -- Set height to be given number of lines
            -- Vim quivalent is vim.cmd [[autocmd FileType qf wincmd J | resize 15]]
            local qflist = vim.fn.getqflist()
            if #qflist > 30 then
              vim.cmd 'resize 30'
            else
              vim.cmd 'resize 15'
            end
          end

          -- Normal mode
          -- `dd` removes item from quickfix list
          vim.api.nvim_buf_set_keymap(0, 'n', 'dd', ':.Reject<CR>', { noremap = true, silent = true })
          -- `gk` keeps the current item
          vim.api.nvim_buf_set_keymap(0, 'n', 'gk', ':.Keep<CR>', { noremap = true, silent = true })

          -- Visual mode
          -- `d` removes all selected items
          vim.api.nvim_buf_set_keymap(0, 'x', 'd', ":'<,'>Reject<CR>", { noremap = true, silent = true })
          -- `gk` keeps all selected items
          vim.api.nvim_buf_set_keymap(0, 'x', 'gk', ":'<,'>Keep<CR>", { noremap = true, silent = true })

          -- The following allows opening the quickfix list location without moving focus away from
          -- quicklist.
          -- The keybinding of 'o' is inspired by the plugin hedyhli/outline.nvim
          local bufnr = vim.api.nvim_get_current_buf()
          vim.keymap.set('n', 'o', function()
            local cursor_pos = vim.fn.getcurpos()
            local current_cursor_line = cursor_pos[2]
            OpenQuickfixEntry(current_cursor_line)

            -- Navigate back to the quickfix window
            -- p here is previous window
            vim.cmd 'wincmd p'
          end, { buffer = bufnr, noremap = true, silent = true })
        end,
      })
    end,
    opts = {},
  },

  -- Enhance the quickfix window
  -- Why?
  -- 1. Better looks
  --    1. Highlights the currently selected item.
  -- 1. Search and filter the list using fzf
  -- 1. Preview window
  --
  -- Keybindings for common usecases:
  -- ============
  -- Navigation
  --    j/k: Use j/k similar to vanila quickfix list
  --    C-n/C-p: Navigate to next/previous file in quickfix list
  --
  -- Select items and create new list
  --    Tab: Toggle item selection and move to NEXT item.
  --    S-Tab: Toggle item selection and move to PREVIOUS item.
  --    zn: Create a new list from the selected items.
  --
  -- When you create a new list, the follow helps with moving around lists
  --    <: Previous quickfix list
  --    >: Next quickfix list
  --
  -- Preview:
  --    p: Toggle preview for current item only
  --    P: Toggle preview for all items
  --    zp: Toggle preview window between normal and max size.
  --
  -- Filter items and create new list
  --    zf: Start fuzzy search using fzf. You can open the results in a new buffer using keybindings
  --        that are similar to telescope.
  --        C-t: Open in new tab
  --        C-x: Open in new horizontal split
  --        C-v: Open in new vertical split
  --
  --        C-o: Select all items in the result.
  --        Tab: Toggle item selection and move to NEXT item.
  --        S-Tab: Toggle item selection and move to PREVIOUS item.
  --        C-n: When in search result, go to NEXT item
  --        C-p: When in search result, go to PREVIOUS item
  --        Enter: When in search result, create a new list from the selected items.
  --               NOTE: when there is only one item in the search result, it will navigate to the result
  --               instead of creating a new list. See https://github.com/kevinhwang91/nvim-bqf/issues/153
  --
  --        For a single item in the result, there is a workaround. Navigate to the item in the
  --        result, and hit ESCAPE. This will leave the cursor on the item. Now hit TAB and zn to
  --        create a new list with the single item.
  --
  --        Another workaround for a single item is to, hit <C-q> to add the item and exit fuzzy search.
  --        Use zn to create a new list from the single item.
  --
  {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
    opts = {
      preview = {
        -- Enable preview in quickfix window automatically
        auto_preview = false,

        -- The following is sued when qf list is at the bottom (default in neovim)
        win_height = 12, -- The height of preview window for horizontal layout, large value (like 999) perform preview window as a "full" mode

        -- The following is used when qf list is on the right, opened as a vertical split
        win_vheight = 40, -- The height of preview window for vertical layout
      },
    },
    dependencies = {
      {
        'junegunn/fzf',
        config = function()
          -- Check if fzf is already installed
          local fzf_path = vim.fn.exepath 'fzf'
          if fzf_path == '' then
            vim.fn['fzf#install']()
          end
        end,
      },
    },
  },

  ------------------------------------------------------------
  -- Plugins to help focus on sections of code.
  ------------------------------------------------------------
  -- Works at paragraph level
  -- :LimeLight 0.5 Use a value between 0.0 and 0.9 to dim the other text. 0.9 dims a lot.
  -- :LimeLight!! Toggle
  {
    'junegunn/limelight.vim',
    opts = {},
    config = function() end, -- dummy config function for vimscript plugins
  },

  -- Works on treesitter objects
  --
  -- :Twilight toggles twilight
  -- :TwilightEnable
  -- :TwilightDisable
  {
    'folke/twilight.nvim',
    opts = {
      -- 0 makes sure that no extra lines are highlighted outside of treesitter object. This helps
      -- me focus better.
      context = 0, -- amount of lines we will try to show around the current line

      treesitter = true, -- use treesitter when available for the filetype
      -- treesitter is used to automatically expand the visible text,
      -- but you can further control the types of nodes that should always be fully expanded
      expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
        -- text object names https://github.com/nvim-treesitter/nvim-treesitter-textobjects
        -- Look at ~/.local/share/nvim/lazy/nvim-treesitter/queries/rust/highlights.scm
        'function',
        'method',
        'block',
        'class',
        'comment',
        -- 'table',
        -- 'if_statement',
      },
      exclude = {}, -- exclude these filetypes
    },
  },

  -- Zen mode <https://github.com/folke/zen-mode.nvim>
  ------------------------------------------------------------

  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'tokyonight-night'

      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
  },

  -- Themes - from https://github.com/topics/neovim-colorscheme
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    opts = {
      dim_inactive = {
        enabled = true, -- dims the background color of inactive window
        shade = 'dark',
        percentage = 0, -- percentage of the shade to apply to the inactive window
      },
    },
  },
  { 'rebelot/kanagawa.nvim', opts = {} },
  { 'kepano/flexoki-neovim', name = 'flexoki', opts = {} },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      --  a and i here is around and inside text object. Don't confuse it with AI.
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- <leader>saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- <leader>sd'   - [S]urround [D]elete [']quotes
      -- <leader>sr)'  - [S]urround [R]eplace [)] [']
      -- require('mini.surround').setup()

      --  I am using https://github.com/nvim-lualine/lualine.nvim as this plugin throws an error when lsp is enabled in
      --  Linux. Didn't root cause it.
      -- local statusline = require 'mini.statusline'
      -- -- set use_icons to true if you have a Nerd Font
      -- statusline.setup { use_icons = vim.g.have_nerd_font }

      -- -- You can configure sections in the statusline by overriding their
      -- -- default behavior. For example, here we set the section for
      -- -- cursor location to LINE:COLUMN
      -- ---@diagnostic disable-next-line: duplicate-set-field
      -- statusline.section_location = function()
      --   return '%2l:%-2v'
      -- end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        'awk',
        'bash',
        'c',
        'cpp',
        'csv',
        'diff',
        'html',
        'java',
        'javascript',
        'json',
        'lua',
        'make',
        'markdown',
        'markdown_inline',
        'python',
        'query',
        'ruby',
        'rust',
        'sql',
        'ssh_config',
        'tmux',
        'toml',
        'vim',
        'vimdoc',
        'xml',
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)

      -- https://github.com/nvim-treesitter/nvim-treesitter/discussions/1513
      -- I want to override else_if_statement and else_statement so that the individual blocks can be folded, but this
      -- doesn't work. Need to find a way to fold individual blocks.
      if require('nvim-treesitter.parsers').has_parser 'c' then
        -- Copied from https://github.com/nvim-treesitter/nvim-treesitter/blob/master/queries/c/folds.scm
        local folds_query = [[
[
  (for_statement)
  (if_statement)
  (while_statement)
  (do_statement)
  (switch_statement)
  (case_statement)
  (function_definition)
  (struct_specifier)
  (enum_specifier)
  (comment)
  (preproc_if)
  (preproc_elif)
  (preproc_else)
  (preproc_ifdef)
  (preproc_function_def)
  (initializer_list)
  (gnu_asm_expression)
] @fold

(compound_statement
  (compound_statement) @fold)
    ]]
        require('vim.treesitter.query').set('c', 'folds', folds_query)
      end

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  },

  -- To show preview of full definitions without having to jump to the definition
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function(_, opts)
      -- Peek definition
      opts = opts or {}
      opts.textobjects = {
        lsp_interop = {
          enable = true,
          border = rounded_border,
          floating_preview_opts = {},
          peek_definition_code = {
            ['<leader>df'] = '@function.outer',
            ['<leader>dF'] = '@class.outer',
          },
        },
      }
      require('nvim-treesitter.configs').setup(opts)
    end,
    opts = {},
  },

  -- Treesitter context for showing current method name as you scroll down
  -- If this gets annoying, you can turn it off using TSContextDisable
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require('treesitter-context').setup {
        -- multiline_threshold = 2, -- Separator helps with the contrast, so not limiting multiline_threshold
        separator = '-',
        on_attach = function(buf)
          -- buf=0 is current buffer
          -- Don't enable tree sitter context for lua files
          if string.match(vim.api.nvim_buf_get_name(buf), 'lua$') ~= nil then
            return false
          end
          return true
        end,
        -- TS context needs to be per buffer. This is tracked in
        -- <https://github.com/nvim-treesitter/nvim-treesitter-context/issues/31>.
      }
    end,
    opts = {},
  },

  -- Show call hierarchy
  {
    'm-pilia/vim-ccls',
    opts = {},
    config = function()
      -- I am using ccls only in Linux.
      if is_mac and use_clangd_in_mac then
        return
      end

      vim.keymap.set('n', '<leader>ch', ':CclsCallHierarchy<CR>', { desc = 'Show [c]all [h]ierarchy of symbol under cursor.' })
      -- vim.keymap.set('n', '<leader>chf', ':CclsCallHierarchy -float<CR>', { desc = 'Show [c]all [h]ierarchy of symbol under cursor using floating window.' })

      vim.api.nvim_set_var('ccls_float_width', 50)
      vim.api.nvim_set_var('ccls_float_height', 20)

      -- Num of cols for vertical and num of rows for horizontal
      local size = 10
      -- Num of levels to fetch from LSP client. The more levels that you fetch, the
      -- faster the tree expansion is. This does not make the tree visually expand
      -- automatically
      vim.g.ccls_levels = 1
      vim.g.ccls_size = size
      vim.g.ccls_position = 'botright' -- topleft, botright
      vim.g.ccls_orientation = 'horizontal' -- vertical, horizontal
      -- vim.g.ccls_close_on_jump = true

      -- Make sure that there is only one call hierarchy window is open at a time
      -- Since we rely on the filetype of the buffer, invoke this only when filetype changes
      vim.api.nvim_create_autocmd('Filetype', {
        callback = function(e)
          -- vim-ccls uses yggdrasil to render the call tree
          local call_hierarchy_file_type = 'yggdrasil'

          local buf_being_created = e.buf

          -- Only close existing call hierarchy when trying to open another call hierarchy
          local filetype_of_buffer_being_created = vim.api.nvim_get_option_value('filetype', { buf = buf_being_created })
          if filetype_of_buffer_being_created ~= call_hierarchy_file_type then
            return
          end

          local function close_existing_call_hierarchies(layout)
            if layout[1] == 'row' or layout[1] == 'col' then
              -- This will have one or more windows. Traverse recursively
              for i, _ in ipairs(layout[2]) do
                close_existing_call_hierarchies(layout[2][i])
              end
            elseif layout[1] == 'leaf' then
              -- Leaf window
              local buf_handle = vim.api.nvim_win_get_buf(layout[2])
              local buf_number = vim.api.nvim_buf_get_number(buf_handle)
              if buf_number ~= buf_being_created then
                local filetype = vim.api.nvim_get_option_value('filetype', { buf = buf_number })
                if filetype == call_hierarchy_file_type then
                  vim.api.nvim_buf_delete(buf_number, {
                    force = true, -- Force deletion and ignore unsaved changes.
                  })
                  return
                end
              end
            end
          end

          local layout = vim.api.nvim_call_function('winlayout', {})
          close_existing_call_hierarchies(layout)

          -- When existing window is closed, the newly open buffer can occupy 2x the size. Resize to keep it at 1x
          vim.api.nvim_win_set_height(vim.api.nvim_get_current_win(), size)
        end,
      })

      -- Close if call hierarchy is the only buffer of interest
      close_file_type_when_only_buffer 'yggdrasil'
    end,
  },

  -- Terminal in nvim
  -- If you accidentally clear the screen using cmd + k, you can redraw neovim
  -- using :mode or ctrl + L (i.e. ctrl + shift + L).
  -- https://neovim.io/doc/user/various.html
  --
  -- TIL: You can create a new terminal buffer in neovim using :terminal. It doesn't require toggle
  --      term at all
  --
  -- <ESC>-<ESC> in quick succession to go to NORMAL mode. You can browse the previous output (similar to
  -- COPY mode in tmux)
  -- i will go to TERMINAL mode where you enter commands like a terminal.
  {
    'akinsho/toggleterm.nvim',
    opts = {},
    config = function()
      -- zsh is run as a login shell with -l option, which will source ~/.zprofile automatically.
      -- But this is slowing down the exit and also throws errors with StripWhitespace on write. So, I
      -- have instead copied the sourcing of my custom configuration in ~/.zshrc itself.
      -- vim.opt.shell = 'zsh -l'

      vim.keymap.set('n', '<leader>tt', ':ToggleTerm<CR>', { desc = 'Toggle terminal' })
      require('toggleterm').setup()
    end,
  },

  -- Notification - provide better notification view.
  -- Messages open in a buffer which is easy to navigate
  -- You can easily view the last errors using :NoiceErrors or :NoiceLast
  {
    'rcarriga/nvim-notify',
    lazy = false,
    opts = {
      stages = 'static', -- fade_in_slide_out, fade, slide, static
      render = 'wrapped-compact', -- default, minimal, simple, compact, wrapped-compact
      timeout = 4000, -- ms
      minimum_width = 50,
      icons = { ERROR = '', WARN = '', INFO = '', DEBUG = '', TRACE = '✎' },
      level = vim.log.levels.INFO,
      fps = 20,
      background_colour = '#000000',
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
      top_down = true, -- true: top to bottom, false: bottom to top
    },
  },
  -- Show command line at the center along with enhancements to notifications
  -- Also shows [1/n] for each search match
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {},
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
    config = function()
      -- whether to show symbols like : ? /. false shows the symbols.
      local enable_conceal = false

      require('noice').setup {
        -- Position the command popup at the center of the screen
        -- https://github.com/folke/noice.nvim/issues/779
        -- See https://github.com/folke/noice.nvim/blob/0cbe3f88d038320bdbda3c4c5c95f43a13c3aa12/lua/noice/types/nui.lua#L6
        -- See https://github.com/folke/noice.nvim/wiki/Configuration-Recipes
        ---@type NoiceConfigViews
        views = {
          cmdline_popup = {
            backend = 'popup',
            relative = 'editor',
            zindex = 200,
            position = {
              row = '40%', -- 40% from top of the screen. This will position it almost at the center.
              col = '50%',
            },
            size = {
              width = 120,
              height = 'auto',
            },
            win_options = {
              winhighlight = {
                Normal = 'NoiceCmdlinePopup',
                FloatTitle = 'NoiceCmdlinePopupTitle',
                FloatBorder = 'NoiceCmdlinePopupBorder',
                IncSearch = '',
                CurSearch = '',
                Search = '',
              },
              winbar = '',
              foldenable = false,
              cursorline = false,
            },
          },
          popupmenu = {
            -- relative = 'editor', -- "'cursor'"|"'editor'"|"'win'"
            position = {
              row = 'auto', -- Popup will show up below the cmdline automatically
              col = 'auto',
            },
            size = {
              width = 120, -- Making this as wide as the cmdline_popup
              height = 'auto',
            },
            border = {
              ---@type _.NuiBorderStyle
              style = 'double', -- 'double'"|"'none'"|"'rounded'"|"'shadow'"|"'single'"|"'solid'
              ---@type _.NuiBorderPadding
              padding = { 0, 1 },
            },
            win_options = {
              winhighlight = {
                Normal = 'NoicePopupmenu', -- Normal | NoicePopupmenu
                FloatBorder = 'NoicePopupmenuBorder', -- DiagnosticInfo | NoicePopupmenuBorder
                CursorLine = 'NoicePopupmenuSelected',
                PmenuMatch = 'NoicePopupmenuMatch',
              },
            },
          },
        },
        cmdline = {
          view = 'cmdline_popup', -- cmdline_popup, cmdline
          format = {
            -- Disable icons by using empty string
            cmdline = { conceal = enable_conceal, icon = '' },
            search_down = { conceal = enable_conceal, icon = '' },
            search_up = { conceal = enable_conceal, icon = '' },
            filter = { conceal = enable_conceal, icon = '' },
            lua = { conceal = enable_conceal, icon = '' },
            help = { conceal = enable_conceal, icon = '' },
            input = { conceal = enable_conceal, icon = '' },
          },
        },
        lsp = {
          signature = {
            enabled = false, -- Disabling this to avoid error on load in markdown files
          },
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
            ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = false, -- true: use a classic bottom cmdline for search
          command_palette = false, -- position the cmdline and popupmenu together. Based on my testing, this must be false to make the cmdline and popup appear next to each other
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      }
    end,
  },
  -- No Neck pain - to center the buffer like Zen mode
  { 'shortcuts/no-neck-pain.nvim', version = '*' },

  -- cs<current char><new char> - Change the surrounding char from current char to new char. Works.
  -- ds<current char> - Delete the surrounding char. Works.
  -- S<new text> - In visual mode this will surround the selection with new text. Works.
  --
  -- ys<motion><new char> - You surround. Surrounds the text objects with new char.
  --  For e.g. ys$" will surround the text between cursor and end of line with "
  --  NOTE: This works if you type the keybindings rapidly.
  {
    'tpope/vim-surround',
    config = function() end,
  },

  -- Repeat keybindings from other plugins like vim-surround etc.
  {
    'tpope/vim-repeat',
    config = function() end,
  },

  -- Surround text object with quotes.
  -- I have disabled this as I don't get the shortcuts working very reliably. There is interference
  -- from other plugins.
  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    enabled = false,
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup {
        -- Configuration here, or leave empty to use defaults
        --
        -- The three "core" operations of add/delete/change can be done with the keymaps
        -- ys{motion}{char},
        -- ds{char}, and
        -- cs{target}{replacement}
        --
        -- https://github.com/kylechui/nvim-surround/blob/main/doc/nvim-surround.txt
        -- y is used to yank only in visual mode, so the keybindings starting with y won't have
        -- conflicts in normal mode.
        --
        -- insert = "<C-g>s",
        -- insert_line = '<C-g>S',
        --
        -- normal = 'ys',
        -- normal_cur = 'yss',
        -- normal_line = 'yS',
        -- normal_cur_line = 'ySS',
        --
        -- visual = 'S',
        -- visual_line = 'gS',
        --
        -- delete = 'ds',
        -- change = 'cs',
        -- change_line = 'cS',
      }
    end,
  },

  -- Search highlight. Highlight characters when using f, F, t, T. Also show visual hints using characters to jump to
  -- specific search locations
  -- This also makes f, F, t, T work across lines
  {
    'folke/flash.nvim',
    -- This is very slow when using over ssh.
    -- The keybindings interfere with other usecases like surround and I don't find myself using this plugin a lot
    enabled = false and not is_linux,
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {},
    -- The following directive asks stylua to not format the following block
    --      COMMANDS               MODES
    -- :map   :noremap  :unmap     Normal, Visual, Select, Operator-pending
    -- :nmap  :nnoremap :nunmap    Normal
    -- :vmap  :vnoremap :vunmap    Visual and Select
    -- :smap  :snoremap :sunmap    Select
    -- :xmap  :xnoremap :xunmap    Visual
    -- :omap  :onoremap :ounmap    Operator-pending
    -- :map!  :noremap! :unmap!    Insert and Command-line
    -- :imap  :inoremap :iunmap    Insert
    -- :lmap  :lnoremap :lunmap    Insert, Command-line, Lang-Arg
    -- :cmap  :cnoremap :cunmap    Command-line
    -- :tmap  :tnoremap :tunmap    Terminal

    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },

      -- { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },

      -- In command mode, use <C-s> to toggle flash search which shows visual hints like Vimium
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  -- Nav buddy to navigate across symbols in the current document (similar to cmd + F12 in jetbrains IDEs).
  -- Once nav buddy is opened (my keybinding: <leader>nb)
  --  j/k: Go to next previous symbol in the same level
  --  h/l: Move to left/right pannel for parent/children respectively. 0 moves to first panel.
  --  c: comment out the current scope.
  --  J/K: Move the scope down or up.
  --  t: Invoke fuzzy finder at current level within navbuddy
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'SmiteshP/nvim-navbuddy',
        dependencies = {
          'SmiteshP/nvim-navic',
          'MunifTanjim/nui.nvim',
        },
        opts = { lsp = { auto_attach = true } },
      },
    },
    opts = {},
  },

  -- Lspsaga has a call hierarchy view which is amazing for browsing rust
  -- https://nvimdev.github.io/lspsaga/callhierarchy/#default-keymaps
  --
  -- Usage: Move over the symbol and invoke the command
  -- :Lspsaga incoming_calls
  --
  -- Default key bindings:
  -- q: quit the layout
  -- u: toggle a hierarchy
  {
    'nvimdev/lspsaga.nvim',
    config = function()
      require('lspsaga').setup {
        callhierarchy = {
          layout = 'normal',
        },
        -- lightbulb for code actions https://nvimdev.github.io/lspsaga/lightbulb/#default-options
        lightbulb = {
          enable = false,
          -- Don't show a virtual light bulb at the end of the line, it mess up with cursor movement
          -- and yanking.
          virtual_text = false,
        },
      }

      -- Show incoming calls to the method
      vim.keymap.set('n', '<leader>ci', '<cmd>Lspsaga incoming_calls<CR>', { silent = true })

      -- Show outgoing calls from the method
      vim.keymap.set('n', '<leader>co', '<cmd>Lspsaga outgoing_calls<CR>', { silent = true })
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons', -- optional
    },
  },

  -- Jump around in the document
  -- It expects you to type two chars in the location that you want to jump to. For the last character in the line, use
  -- space.
  -- s: search forward
  -- S: search backward
  {
    'ggandor/leap.nvim',
    -- This is very slow when using over ssh.
    -- The keybindings interfere with other usecases like surround and I don't find myself using this plugin a lot
    enabled = false and not is_linux,
    opts = {},
    config = function(opts)
      -- leap's keybindings conflicts with lazy. This is taken from
      -- <https://github.com/LazyVim/LazyVim/issues/2379#issuecomment-1898491969>
      local leap = require 'leap'
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
      vim.keymap.del({ 'x', 'o' }, 'x')
      vim.keymap.del({ 'x', 'o' }, 'X')
      vim.keymap.set('n', 's', function()
        require('leap').leap { target_windows = { vim.api.nvim_get_current_win() } }
      end)
    end,
  },

  -- Go to next occurrence of symbol, ignoring symbol in comments
  {
    'nvim-treesitter/nvim-treesitter-refactor',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {},
    config = function()
      require('nvim-treesitter.configs').setup {
        refactor = {
          highlight_definitions = {
            enable = false,
            -- Set to false if you have an `updatetime` of ~100.
            clear_on_cursor_move = true,
          },
          highlight_current_scope = { enable = false },
          navigation = {
            enable = true,
            keymaps = {
              -- goto_definition = "gnd",
              -- list_definitions = "gnD",
              -- list_definitions_toc = "gO",
              goto_next_usage = '<a-j>', -- alt + j
              goto_previous_usage = '<a-k>', -- alt + k
            },
          },
        },
      }
    end,
  },

  -- Preview markdown live in a webbrowser
  -- Current cursorline will be at the center of the browser screen
  -- Make sure to URL encode image paths for it to render correctly. For e.g. a space in image name will prevent the
  -- image from rendering.
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
  },

  -- Plugin to browse github issues and pr. This shows more information than the github CLI tool
  -- This plugin is lazily loaded. Use <leader>O to load it. You can then use it via
  -- 1. <leader>O
  -- 2. :Octo <tab>
  -- Use gx to open link under cursor in browser.
  -- Use <C-b> to open the current issue or pr in Github.
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      -- OR 'ibhagwan/fzf-lua',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('octo').setup {
        default_to_projects_v2 = true,
        mappings_disable_default = false,
        enable_builtin = true,
      }
    end,
    keys = {
      { '<leader>O', '<cmd>Octo<cr>', desc = 'Octo' },
    },
  },

  -- Highlight background in markdown header, code blocks etc.
  -- Makes the markdown easier to read inside neovim.
  -- {
  --   'lukas-reineke/headlines.nvim',
  --   dependencies = 'nvim-treesitter/nvim-treesitter',
  --   config = function()
  --     require('headlines').setup {
  --       markdown = {
  --         -- I don't like the default config that shows bullets in headers. But I do want the
  --         -- highlight for headers.
  --         bullets = {},
  --       },
  --     }
  --   end,
  -- },

  -- https://github.com/MeanderingProgrammer/render-markdown.nvim
  -- Improve viewing of markdown files in neovim
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown' },
    opts = {
      -- Whether Markdown should be rendered by default or not
      enabled = false,
      -- Maximum file size (in MB) that this plugin will attempt to render
      -- Any file larger than this will effectively be ignored
      max_file_size = 10.0,
      -- Milliseconds that must pass before updating marks, updates occur
      -- within the context of the visible window, not the entire buffer
      debounce = 100,
    },
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  },

  -- Automatically save and restore session. This remembers the open buffers, cursor position in
  -- each buffer along with folds etc.
  --
  -- Session files are stored in ~/.local/state/nvim/sessions
  --
  -- Usage:
  --  * Use "nvim" or "nvim <dir>" to start neovim. If you start with a specific file, auto-session
  --    won't kick-in.
  --  * Or Manually save and restore using the following commands.
  --
  -- Commands
  -- :SessionSave
  -- :SessionRestore
  -- :SessionSearch
  -- :SessionDelete if you get error about restoring a session
  {
    'rmagatti/auto-session',
    lazy = false,
    dependencies = {
      'nvim-telescope/telescope.nvim', -- Only needed if you want to use session lens
    },

    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      suppressed_dirs = { '~/', '~/Downloads', '/' },

      -- List of file types to bypass auto save when the only buffer open is one of the file types listed
      bypass_save_filetypes = aux_windows,

      -- log_level = 'debug',
    },
  },

  -- Remember the last cursor position and open file in that position.
  -- It won't impact git commit messages etc.
  {
    'farmergreg/vim-lastplace',
    opts = {},
    config = function() end, -- dummy config function for vimscript plugins
  },

  -- Highlight undo/redo text
  -- Couldn't get this to work. Moved to yuki-yano/highlight-undo
  -- {
  --   'tzachar/highlight-undo.nvim',
  --   opts = {},
  -- },

  -- Highlight undo/redo text
  {
    'yuki-yano/highlight-undo.nvim',
    config = function()
      if vim.fn.executable 'deno' == 1 then
        -- deno is installed
        require('highlight-undo').setup {}
      else
        print 'deno is not available. Follow https://github.com/denoland/deno/ to install it'
        -- For Mac/Linux, this is
        --
        -- curl -fsSL https://deno.land/install.sh | sh
        --
        -- Add to the zshrc path
        --
        -- export DENO_INSTALL="/home/sanka/.deno"
        -- export PATH="$DENO_INSTALL/bin:$PATH"
      end
    end,
    dependencies = {
      -- Also make sure deno is installed <https://github.com/denoland/deno/>
      'vim-denops/denops.vim',
    },
  },

  -- Run tests from within neovim using neotest
  --
  -- neotest-rust requires cargo-nextest to be installed <https://nexte.st/>
  --
  -- I have decided not to use cargo-nextest as it is not a superset of cargo test and might require
  -- code changes to the test <https://nexte.st/docs/design/custom-test-harnesses/>.
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'vim-test/vim-test', -- For running tests via vim-test
      'nvim-neotest/neotest-vim-test', -- Neotest adapter for vim-test

      -- 'rouge8/neotest-rust',
    },
    config = function()
      require('neotest').setup {
        -- https://github.com/nvim-neotest/neotest/pull/437/files
        run = {
          augment = function(tree, args)
            -- Set rust backtrace while running rust tests
            args.env = { RUST_BACKTRACE = 1 }
            return args
          end,
        },
        adapters = {
          require 'neotest-vim-test' {
            ignore_file_types = {}, -- You can adjust this for other languages if needed
          },

          -- require 'neotest-rust',
        },
        -- Floating window for test result is controlled by the property relative = "editor"
        -- <https://github.com/nvim-neotest/neotest/blob/6d6ad113f56edc7c3f2a77a0836ea8c1b955ebea/lua/neotest/lib/ui/float.lua#L33>
        -- I couldn't find a way to configure this using floating.options
        --
        -- For the default configuration values see ~/.local/share/nvim/lazy/neotest/lua/neotest/config/init.lua
      }

      close_file_type_when_only_buffer 'neotest-summary'

      -- keymap
      vim.keymap.set('n', '<leader>tn', '<cmd>lua require("neotest").run.run()<CR>', { desc = '[t]est [n]earest' })
      vim.keymap.set('n', '<leader>tf', '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<CR>', { desc = '[t]est [f]ile' })
      vim.keymap.set('n', '<leader>ta', '<cmd>lua require("neotest").run.run({ suite = true })<CR>', { desc = '[T]est [A]ll' })

      vim.keymap.set('n', '<leader>th', '<cmd>lua require("neotest").run.stop()<CR>', { desc = '[t]est [h]alt' })

      vim.keymap.set('n', '<leader>tr', '<cmd>lua require("neotest").summary.toggle()<CR>', { desc = '[T]est [R]eport' })
      vim.keymap.set('n', '<leader>to', '<cmd>lua require("neotest").output.open({ enter = true })<CR>', { desc = '[T]est [O]utput' })
    end,
  },

  -- Indent guides similar to IDEs using virtual text
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    enabled = not is_linux,
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
  },

  -- Show diagnostics by buffer and also at workspace level
  -- Also has better view of qflist and location list
  {
    'folke/trouble.nvim',
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = 'Trouble',
    keys = {
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>xX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<leader>cs',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Symbols (Trouble)',
      },
      {
        '<leader>cl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)',
      },
      {
        '<leader>xL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>xQ',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      },
    },
    config = function(_, opts)
      -- If trouble is the only visible buffer, close neovim
      close_file_type_when_only_buffer 'trouble'

      require('trouble').setup(opts)
    end,
  },

  -- Undo tree
  {
    'mbbill/undotree',
    config = function() end,
  },

  -- Highlight cursor when it moved
  {
    'danilamihailov/beacon.nvim',
    ft = function()
      -- beacon doesn't provide a way to disable this plugin for specific filetypes
      -- <https://github.com/DanilaMihailov/beacon.nvim/issues/26>
      -- ft doesn't provide a way to specify file types to ignore. A workaround is to list all
      -- common filetypes
      return {
        'c',
        'cpp',
        'rust',
        'go',
        'python',
        'javascript',
        'typescript',
        'lua',
        'vim',
        'bash',
        'html',
        'css',
        'scss',
        'json',
        'yaml',
        'toml',
        'xml',
        'markdown',
        'txt',
        'sh',
        'zsh',
        'make',
        'cmake',
        'dockerfile',
        'gitcommit',
        'gitrebase',
        'sql',
        'perl',
        'ruby',
        'php',
        'java',
        'scala',
        'haskell',
        'elixir',
        'erlang',
        'r',
        'latex',
        'tex',
        'perl',
        'kotlin',
        'dart',
        'swift',
        'racket',
        'clojure',
        'scheme',
        'fsharp',
        'ocaml',
        'fortran',
        'vim',
        'help',
        -- aux windows where I want this feature
        'neo-tree',
        'Outline',
        'neotest-summary',
        -- Add any other relevant filetypes here
      }
    end,
    config = function(opts)
      opts = opts or {}
      opts.width = 120

      -- Highlight groups have to be reinitialized after setting the color scheme
      vim.api.nvim_create_autocmd('ColorScheme', {
        callback = function()
          vim.api.nvim_set_hl(0, 'Beacon', { bg = 'white' })
        end,
      })
      require('beacon').setup()
    end,
  },

  -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- I find the debug plugin in neovim to be high effort low returns at this point in time.
  -- There are way too many failure points for a debugger. I may revisit these plugins later.
  require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.lint',

  ----------------------------------------------------------------------------------------------------
  -- AI plugins
  ----------------------------------------------------------------------------------------------------
  --
  -- API access is not free in claude. You have to prepay a certain amount to get access.
  -- Set the API key using environment variable before opening nvim.
  --
  -- export ANTHROPIC_API_KEY=<your-api-key>
  --
  -- export OPENAI_API_KEY=your-api-key
  --
  -- Remember chat history:
  -- The plugin tends to hide the previous chats whenever I ask new questions. But if I close and
  -- open Avante, I am able to see past chats.
  --
  -- <https://github.com/yetone/avante.nvim/issues/239> Chat history is not remembered in the
  -- ongoing conversation. So, there is a discussion that the AI services are not having the history
  -- of the conversation.
  --
  -- <https://github.com/yetone/avante.nvim/issues/76> @codebase can be used to share the entire
  -- codebase as context. There is a discussion on providing a way to share only the open buffers as
  -- context instead of the entire workspace.
  --
  -- <https://github.com/yetone/avante.nvim/issues/627> Mentions that the plugin forgets the
  -- previous chats when reopening Avante. I don't have this problem.
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      --@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
      provider = 'claude', -- Recommend using Claude
      -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
      auto_suggestions_provider = 'claude',
      claude = {
        endpoint = 'https://api.anthropic.com',
        model = 'claude-3-5-sonnet-20240620',
        temperature = 0,
        max_tokens = 4096,
      },
      openai = {
        endpoint = 'https://api.openai.com/v1/',
        model = 'gpt-4o',
        temperature = 0,
        max_tokens = 4096,
      },
      behaviour = {
        auto_suggestions = false, -- Experimental stage
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
      },
      mappings = {
        -- <Leader>aa    show sidebar
        -- <Leader>ar    refresh sidebar
        -- <Leader>ae    edit selected blocks
        -- co    choose ours
        -- ct    choose theirs
        -- ca    choose all theirs
        -- c0    choose none
        -- cb    choose both
        -- cc    choose cursor
        -- ]x    move to previous conflict
        -- [x    move to next conflict
        -- [[    jump to previous codeblocks (results window)
        -- ]]    jump to next codeblocks (results windows)
        --
        -- /help      show help on slash commands
        -- /clear     clears chat history
        -- @codebase  Chat using the entire codebase.
        --
        --- @class AvanteConflictMappings
        diff = {
          -- These keybindings are similar to git diffview plugin
          ours = 'co',
          theirs = 'ct',
          all_theirs = 'ca',
          both = 'cb',
          cursor = 'cc',
          next = ']x', -- Previous conflict
          prev = '[x', -- Next conflict
        },
        suggestion = {
          -- FIXME: this is not working for me due to conflicts with aerospace
          accept = '<M-l>',
          next = '<M-]>',
          prev = '<M-[>',
          dismiss = '<C-]>',
        },
        jump = {
          -- FIXME: this is not working for me due to conflicts in keymap
          next = ']]',
          -- FIXME: this is not working for me due to conflicts in keymap
          prev = '[[',
        },
        submit = {
          normal = '<CR>',
          insert = '<C-s>',
        },
        sidebar = {
          switch_windows = '<Tab>',
          reverse_switch_windows = '<S-Tab>',
        },
      },
      -- Whether to show the keybinding hint in visual mode? <https://github.com/yetone/avante.nvim/issues/682>
      hints = { enabled = false },
      windows = {
        ---@type "right" | "left" | "top" | "bottom"
        position = 'right', -- the position of the sidebar
        wrap = true, -- similar to vim.o.wrap
        width = 40, -- default % based on available width
        sidebar_header = {
          align = 'center', -- left, center, right for title
          rounded = true,
        },
      },
      highlights = {
        ---@type AvanteConflictHighlights
        diff = {
          current = 'DiffText',
          incoming = 'DiffAdd',
        },
      },
      --- @class AvanteConflictUserConfig
      diff = {
        autojump = false,
        ---@type string | fun(): any
        list_opener = 'copen',
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = 'make BUILD_FROM_SOURCE=true',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      --- The below dependencies are optional,
      'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
      'zbirenbaum/copilot.lua', -- for providers='copilot'
      { 'akinsho/git-conflict.nvim', version = '*', config = true, opts = {} },
      {
        -- support for image pasting
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            -- use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'markdown', 'Avante' },
        },
        ft = { 'markdown', 'Avante' },
      },
    },
    config = function(_, opts)
      -- WARN: Workaround begin: The conflict highlight group is getting cleared when the color scheme is set after loading this plugin.
      -- If I need the colors, I have to manually setup the highlight groups again.
      if false then
        local is_previous_filetype_avante = false

        -- Set up autocommand for BufLeave to track the previous buffer's filetype
        vim.api.nvim_create_autocmd('BufLeave', {
          pattern = '*', -- Match all buffers
          callback = function()
            is_previous_filetype_avante = vim.bo.filetype == 'Avante'
          end,
        })

        -- Set up autocommand for BufEnter to run setup when moving from avante to another filetype
        vim.api.nvim_create_autocmd('BufEnter', {
          pattern = '*', -- Match all buffers
          callback = function()
            if is_previous_filetype_avante and vim.bo.filetype ~= 'Avante' then
              require('avante.highlights').setup()
            end
          end,
        })

        -- <Leader>ac    Avante Conflict (my custom keybinding to show highlights for conflicts)
        vim.keymap.set('n', '<leader>ac', function()
          -- You can use :hi to show the current highlight groups and Avante* shows up as cleared prematurely.

          -- vim.cmd [[
          --   hi! link AvanteConflictCurrent GitConflictCurrent
          --   hi! link AvanteConflictIncoming GitConflictIncoming
          --   hi! link AvanteConflictAncestor GitConflictAncestor
          --   hi! link AvanteConflictCurrentLabel GitConflictCurrentLabel
          --   hi! link AvanteConflictIncomingLabel GitConflictIncomingLabel
          --   hi! link AvanteConflictAncestorLabel GitConflictAncestorLabel
          -- ]]

          -- https://github.com/yetone/avante.nvim/blob/main/lua/avante/highlights.lua
          require('avante.highlights').setup()
        end, { desc = '[A]vante [C]onflict', silent = true })
      end
      -- WARN: Workaround Ends

      -- Highlight groups have to be reinitialized after setting the color scheme
      -- <https://github.com/yetone/avante.nvim/issues/654>
      vim.api.nvim_create_autocmd('ColorScheme', {
        callback = function()
          require('avante.highlights').setup()
        end,
      })
      require('avante').setup(opts)

      -- Remove the Copilot command introduced by this plugin. I am currently not using it. Since it
      -- is shares the same prefix as :copen, it is getting on my way while trying to open qf list.
      vim.api.nvim_del_user_command 'Copilot'
    end,
  },

  -- NOTE: I have kept this plugin in a separate file as the configuration contains a lot of brackets. This
  -- messes up with the vim features like % which jumps to the matching bracket.
  require 'custom.plugins.mini_ai',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  -- { import = 'custom.plugins' },

  -- Notify on changes to files of interest (like lsp.log) from external processes.
  {
    'rktjmp/fwatch.nvim',
    -- Don't call setup or use opts = {}. This plugin just brings in utility methods that you can call
    -- directly
    config = function()
      require 'custom.plugins.file_watch'
      local previous_line_with_error = nil
      local lsp_log = vim.fn.fnamemodify('~/.local/state/nvim/lsp.log', ':p')
      local search_fn = SEARCH_IN_FILE(lsp_log)

      local previous_notification = nil
      -- local notification_open = false

      -- Notify when there is something written to lsp log. This helps surface errors in lsp logs
      require('fwatch').watch(lsp_log, {
        on_event = function(filename, events, unwatch_cb)
          if events.change then
            -- Notify only if a NEW error was written in lsp.log
            local file_contains_error, last_line_with_match, line_contents = search_fn 'ERROR'

            if file_contains_error then
              assert(line_contents ~= nil)

              if previous_line_with_error ~= nil and previous_line_with_error > last_line_with_match then
                -- The file got truncated
                previous_line_with_error = nil
              end

              if not previous_line_with_error or previous_line_with_error < last_line_with_match then
                previous_line_with_error = last_line_with_match

                --@type notify.Options
                local notification_opts = {
                  title = 'LSP errors',
                  -- timeout = 10000,
                  -- With icon, the text at the end is not colored correctly
                  on_open = function()
                    -- notification_open = true
                  end,
                  on_close = function()
                    previous_notification = nil
                    -- notification_open = false
                  end,
                }
                if previous_notification ~= nil then
                  -- I get notifications about no existing notifications to replace. So, I have
                  -- disabled this
                  -- notification_opts.replace = previous_notification
                end

                -- if not notification_open then
                line_contents = line_contents:gsub('\\n', '\n')
                if line_contents:match 'taplo' then
                  -- Ignore notifications from certain noisy lsps
                  -- 1. taplo (toml)
                  return
                elseif line_contents:match 'marksman' then
                  return
                elseif line_contents:match 'clangd' and string.find(line_contents, 'I%[') then
                  -- Ignore info messages logged as error by clangd. Info messages start with I[. %
                  -- is used to escape [ in the lua pattern string
                  return
                end

                vim.schedule(function()
                  -- https://github.com/rcarriga/nvim-notify/blob/fbef5d32be8466dd76544a257d3f3dce20082a07/doc/nvim-notify.txt#L55
                  previous_notification = require('notify').notify(line_contents, vim.log.levels.ERROR, notification_opts)
                end)
              end
            else
              if previous_line_with_error ~= nil then
                -- The file got truncated
                previous_line_with_error = nil
              end
            end
          end
          if events.rename then
            unwatch_cb()
          end
        end,
        on_error = function()
          require 'notify'('Error trying to get notification for lsp.log', 'error')
        end,
      })
    end,
  },
}, {
  config = function()
    -- Logic to run after lazy is setup
  end,
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
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

-- This follows most of
-- https://medium.com/hackernoon/tmux-in-practice-copy-text-from-remote-session-using-ssh-remote-tunnel-and-systemd-service-dd3c51bca1fa
-- to allow copying text from remote nvim to Mac's clipboard
if is_linux then
  local function is_local_port_open(port)
    -- host is mandatory for nc command
    local command = string.format('nc -z localhost %d', port)
    local cmd_handle = io.popen(command)
    local result = 'Not open'
    if cmd_handle then
      -- *a is read all the data until the end of the file
      result = cmd_handle:read '*a'
      cmd_handle:close()
    end
    -- No output from nc -z means that the port is open
    return result == ''
  end

  function YANK_AND_PIPE_TO_NC()
    local yanked_text = ''

    local mode = vim.fn.mode()
    if mode == 'v' or mode == 'V' then
      -- Trigger yank, so register " is populated
      vim.cmd 'normal! y'
      yanked_text = vim.fn.getreg '"'
    else
      return
    end

    local handle = io.popen('nc localhost 19999', 'w')
    if handle then
      handle:write(yanked_text)
      handle:close()
    end
    vim.notify('Copied!', 'info', { title = 'Yank and Pipe' })
  end

  if is_local_port_open(19999) then
    -- Map 'gy' to the custom function in normal and visual modes (without overriding regular 'y')
    vim.api.nvim_set_keymap('n', 'gy', '<cmd>lua YANK_AND_PIPE_TO_NC()<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('v', 'gy', '<cmd>lua YANK_AND_PIPE_TO_NC()<CR>', { noremap = true, silent = true })

    vim.notify('No service listening on port 19999', 'error', { title = 'Yank and Pipe' })
  end
end

vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter', 'FocusGained' }, {
  callback = function()
    vim.cmd 'setlocal winhighlight=Normal:Normal'
  end,
})

vim.api.nvim_create_autocmd({ 'WinLeave', 'BufLeave', 'FocusLost' }, {
  callback = function()
    vim.cmd 'setlocal winhighlight=Normal:DimInactive'
  end,
})

local function initialize_highlight_groups()
  -- Highlight cursor line using the following style
  -- Catppuccin mocha uses #1E1E2E as the background color. To contrast that, chatGPT recommended the following colors.
  -- #394B59 smoky teal
  -- #4C4F69 deep violet
  -- #3B3D43 dark olive
  -- #2E2E3E charcoal
  -- #2A2B3D dark slate
  vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#3B3D43', fg = 'NONE', underline = false, bold = true, italic = true })

  -- Set the dim color for inactive buffers
  vim.api.nvim_set_hl(0, 'DimInactive', { bg = '#000000', fg = '#888888' })

  -- Add more highlight group configurations here
end

-- Highlight groups have to be reinitialized after setting the color scheme
vim.api.nvim_create_autocmd('ColorScheme', {
  callback = initialize_highlight_groups,
})

-- slate does not color markdown well. So, I switched to catppuccin-mocha
vim.cmd.colorscheme 'catppuccin-mocha' -- catppuccin-mocha (dark)/catppuccin-latte/catppuccin-frappe/catppuccin-latte (light)
-- vim.cmd.colorscheme 'kanagawa-dragon' -- kanagawa-dragon (dark) / kanagawa-wave (mid - like tokyo night) / kanagawa-lotus (light)
-- vim.cmd.colorscheme 'flexoki-dark' -- flexoki-dark/flexoki-light

local function open_neotree_on_startup()
  -- Toggle Neotree on startup
  -- Auto-commands in Vim/Neovim are commands that execute automatically when certain events occur.
  -- VimEnter: This event is triggered when Vim/Neovim has finished starting up and is ready to use.
  -- *: This wildcard specifies that the auto-command applies to all files.
  vim.cmd [[autocmd VimEnter * Neotree]]

  -- The following is required to move the focus back to the window on the right once NeoTree is open
  -- nvim_replace_termcodes will replace keycodes with their terminal representation
  -- <C-w> is ctrl + w
  -- true: String should be escaped for use in a terminal.
  -- false: String should not be prefixed with the escape key.
  -- true: Keys should be treated atomically.
  local _code_c_w = vim.api.nvim_replace_termcodes('<C-w>', true, false, true)
  -- nvim_feed_keys will feed keys into Neovim's input buffer
  -- .. is for concatenation. This effectively sends the key sequence Ctrl + w followed by the letter 'l'.
  -- 'n': Normal mode.
  -- true: Keys should be fed asynchronously
  vim.api.nvim_feedkeys(_code_c_w .. 'l', 'n', true)
end

if open_neo_tree_on_startup then
  open_neotree_on_startup()
end

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
