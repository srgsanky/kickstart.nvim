-- Function to calculate luminance and return a contrasting foreground color
local function get_contrasting_color(r, g, b)
  -- Calculate the relative luminance of the color (based on WCAG standard)
  local luminance = (0.299 * r + 0.587 * g + 0.114 * b) / 255

  -- If luminance is high, return black, otherwise return white
  if luminance > 0.5 then
    return '#000000' -- Dark text for light backgrounds
  else
    return '#FFFFFF' -- Light text for dark backgrounds
  end
end

-- Function to generate a color based on a hash of the commit ID
local function generate_color_from_commit(commit)
  -- Convert the first few characters of the commit hash to a number
  local hash_value = tonumber(commit:sub(1, 6), 16)

  -- Use math.floor to handle integer division
  local r = (hash_value % 256)
  local g = (math.floor(hash_value / 256) % 256)
  local b = (math.floor(hash_value / (256 * 256)) % 256)

  -- Return the color in hex format
  return string.format('#%02x%02x%02x', r, g, b), r, g, b
end

local function set_minwidth_for_buffer(bufnr, minwidth)
  -- Iterate over all windows
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    -- Check if the window is displaying the specified buffer
    if vim.api.nvim_win_get_buf(win) == bufnr then
      -- Get the current window width
      local win_width = vim.api.nvim_win_get_width(win)
      -- If the current width is less than the desired minimum, resize the window
      if win_width < minwidth then
        vim.api.nvim_win_set_width(win, minwidth)
      end
    end
  end
end

-- https://github.com/tpope/vim-fugitive/blob/d4877e54cef67f5af4f950935b1ade19ed6b7370/autoload/fugitive.vim#L6862
local function highlight_same_commit()
  local ft = vim.bo.filetype
  -- This function is applicable only to fugitiveblame
  -- g.loaded_fugitive is only whether the plugin is loaded. It does not mean that the fugitiveblame
  -- is initialized.
  if ft ~= 'fugitiveblame' or vim.g.loaded_fugitive == nil or vim.g.loaded_fugitive ~= 1 then
    return
  end

  local current_buf = vim.api.nvim_get_current_buf()

  -- vim.b.initialized is a buffer local variable used to track if the buffer was already
  -- initialized
  if vim.b.initialized == nil or not vim.b.initialized then
    vim.b.initialized = true

    local lines = vim.api.nvim_buf_get_lines(current_buf, 0, -1, false)

    -- commit hash to highlight group mapping
    local commit_hash_to_hl_group_map = {}
    local last_commit = nil

    local is_curr_buf_modifiable = vim.api.nvim_get_option_value('modifiable', { buf = current_buf })
    if not is_curr_buf_modifiable then
      vim.api.nvim_set_option_value('modifiable', true, { buf = current_buf })
    end

    for i, line in ipairs(lines) do
      -- Regex to match a commit hash
      local commit = line:match '^%x%x%x%x%x%x%x%x'

      if not commit then
        commit = line:match '^%^%x%x%x%x%x%x%x'

        if commit then
          -- Remove the leading ^. It cannot be used in color calculation and it is not a valid highlight
          -- group name char
          commit = string.sub(commit, 2)
        end
      end

      if commit then
        if not commit_hash_to_hl_group_map[commit] then
          -- Using the commit id to generate color will produce the same color for the same hash.
          -- If you open the editor multiple times, you will see deterministic colors.
          local bg_color, r, g, b = generate_color_from_commit(commit)
          local fg_color = get_contrasting_color(r, g, b)

          local hl_group = 'CommitHighlight_' .. commit

          -- Define the new highlight group with the generated background and foreground colors
          -- We will reuse this for all hunks with the same commit id.
          vim.cmd(string.format('highlight %s guibg=%s guifg=%s', hl_group, bg_color, fg_color))

          -- No need to add a separate highlight group that uses bg_color as guibg and guifg when
          -- you replace the rest of the lines in the block with space. See below.

          commit_hash_to_hl_group_map[commit] = hl_group
        end

        -- For lines within the same chunk, rewrite the lines with space.
        if commit == last_commit then
          local line_content = vim.api.nvim_buf_get_lines(current_buf, i - 1, i, false)[1]

          if line_content then
            -- Create a string of spaces with the same length as the line content
            local em_space = '\u{00A0}' -- Em space
            -- Replacing with space will reserve the space which looks better visually. Moreover,
            -- since the commit ids are removed, if you jump to next/previous from a commit id using
            -- */#, it will go to the next/previous chunk.
            local spaces = string.rep(em_space, #line_content)

            vim.api.nvim_buf_set_lines(current_buf, i - 1, i, false, { spaces })
          end
        end

        vim.api.nvim_buf_add_highlight(current_buf, -1, commit_hash_to_hl_group_map[commit], i - 1, 0, -1)
        last_commit = commit
      else
        last_commit = nil
      end

      -- Don't show whitespace as dot
      vim.api.nvim_set_option_value('list', false, { win = vim.api.nvim_get_current_win() })
    end
    -- Add a line at the top to offset for breadcrumbs in the file. This messes up with cursorbind
    -- introducing off by one
    -- This is no longer needed after adding inactive_winbar to lualine
    -- vim.api.nvim_buf_set_lines(current_buf, 0, 0, false, { ' ' })

    if is_curr_buf_modifiable then
      vim.api.nvim_set_option_value('modifiable', false, { buf = current_buf })
    end

    -- Setting the width of buffer must be run on the main thread. So, it must be scheduled
    vim.schedule(function()
      -- Use vim fugitive's default keybinding to show till date column
      -- This does not work
      -- vim.api.nvim_feedkeys('D', 'n', false)

      -- Shows only the commit id which is 8 chars. Show the space after 8 chars
      set_minwidth_for_buffer(current_buf, 9)
    end)

    -- Add key bindings for A, C and D for the current buffer, so that it works even when you are in
    -- a blank line.
    -- vim.api.nvim_buf_set_keymap(0, 'n', 'A', '', {
    --   noremap = true,
    --   silent = true,
    --   callback = function()
    --     local first_line = vim.api.nvim_buf_get_lines(current_buf, 0, 1, false)[1]
    --
    --     if first_line then
    --       -- TODO: The logic that goes here is made hard by the following facts
    --       -- 1. The line contains hidden numbers for the line number.
    --       -- 2. Can't separate by space as author part can contains spaces
    --       -- 3. Need to do regex match. Coming up with a regex that works for all cases needs to be
    --       --    iterated upon.
    --
    --       print(first_line)
    --
    --       -- For now the workaround is - go to non-blank line and then press the key binding, it
    --       -- delegates to vim fugitive.
    --     end
    --   end,
    -- })
  end
end

vim.api.nvim_create_autocmd({ 'Filetype' }, {
  callback = function(e)
    if vim.bo.filetype == 'fugitiveblame' then
      local fugitive_buffer = e.buf
      local result = vim.fn['FugitiveResult'](e.buf)

      local original_buffer = result.origin_bufnr
      local original_window = result.origin_winid

      -- Close git blame when you leave original window
      -- Create an autocommand group to avoid duplicate commands
      vim.api.nvim_create_augroup('LeavingOriginalBuffer', { clear = true })
      -- 'WinLeave' or 'BufWinLeave' were causing the git blame to close when I navigate across
      -- splits. BufHidden will only close git blame when a new buffer is opened in the original
      -- window.
      vim.api.nvim_create_autocmd({ 'BufHidden' }, {
        group = 'LeavingOriginalBuffer',
        pattern = '*',
        callback = function(e1)
          if e1.buf == original_buffer then
            vim.schedule(function()
              if vim.api.nvim_buf_is_valid(fugitive_buffer) then
                vim.api.nvim_buf_delete(fugitive_buffer, { force = false })
              end
            end)
          end
        end,
      })
    end
  end,
})

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  callback = function(e)
    if vim.bo.filetype == 'fugitiveblame' then
      -- This will keep the cursors in sync between the blame window and the editor
      vim.cmd [[ setlocal cursorbind ]]

      local result = vim.fn['FugitiveResult'](e.buf)
      local original_buffer = result.origin_bufnr
      local original_window = result.origin_winid

      vim.api.nvim_set_option_value('cursorbind', true, { win = original_window })
    end
  end,
})

vim.api.nvim_create_autocmd({ 'BufLeave' }, {
  callback = function(e)
    if vim.bo.filetype == 'fugitiveblame' then
      vim.cmd [[ setlocal nocursorbind ]]

      local result = vim.fn['FugitiveResult'](e.buf)
      local original_buffer = result.origin_bufnr
      local original_window = result.origin_winid

      vim.api.nvim_set_option_value('cursorbind', false, { win = original_window })
    end
  end,
})

-- If I use Filetype auto cmd, the keybindings are not properly setup. So, I am sticking to
-- BufWinEnter.
vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
  callback = function()
    highlight_same_commit()
  end,
})

-- https://vimdoc.sourceforge.net/htmldoc/autocmd.html
--
-- VimEnter: Neovim has finished initializing. (Usecase: restore session state)
-- GUIEnter
-- VimLeavePre: Before existing vim. Before writing viminfo file.
-- VimLeave: Before existing vim. After writing viminfo file.
-- VimResized
--
-- SessionLoadPost: After loading a session file.
--
-- ColorScheme: After loading a color scheme
--
-- FocusGained: Neovim gained focus from other apps
-- FocusLost
--
-- BufReadPre: Before reading the contents of a buffer from file. Filetype is typically set before
--             this.
-- BufRead: After buffer is read from file into memory.
-- BufReadPost: After reading the file.
-- FileType: File type is detected. Typically after the buffer is loaded.
--           BufReadPre -> BufRead -> BufReadPost -> FileType
-- BufWritePre: Before a buffer is written to a file. (Usecase: Format the buffer before writing it)
-- BufWrite:
-- BufWritePost: After a buffer is written to a file. (Usecase: Run make or build scripts)
--
-- BufEnter: User enters buffer either in the same window (i.e. user switches files) or to a different window.
--           This will be triggered only when the buffer is attached to a window.
-- BufLeave: Before leaving to another buffer.
--
-- BufWinEnter: When buffer is shown in a window (window specific options)
--              Window is drawn (WinEnter) -> BufEnter -> BufWinEnter
-- BufWinLeave
--
-- WinEnter: When moving from one window to another. This can be a different buffer or same buffer
--           in a different window.
--
--           Switching to a different buffer in the same window triggers BufEnter but not WinEnter.
--           Switching to a different window without changing buffers triggers WinEnter but not BufEnter.
--           Switching to a different window with a different buffer triggers both BufEnter and WinEnter.
--              WinEnter -> BufEnter
--
-- TabEnter
-- TabLeave
--
-- CmdwinEnter
-- CmdwinLeave
--
-- BufAdd: After adding a buffer to the buffer list.
-- BufCreate: After adding a buffer to the buffer list.
-- BufDelete: Before deleting a buffer from the buffer list.
-- BufWipeout: Before completely deleting a buffer.
--
-- CursorHold: After cursor remains idle for a certain amount of time (updatetime). (Usecase: show
--             diagnostic or do error check)
-- CursorHoldI
-- CursorMoved
-- CursorMovedI
--
-- InsertEnter: Entered insert mode. (Usecase: hide UI elements like diagnostics or switch theme)
-- InsertLeave
--
