-- Why did I have to make a copy of these from Telescope?
--
-- I wanted to hide the type of symbols while looking up headers in markdown file. When the markdown
-- file is about a language like Rust and I want to find the section that talks about String, I am
-- not able to use String to navigate to the section.
--
-- I tried using symbol_type_width=0, but that didn't help. So, I went on to implement an
-- entry_maker that is consulted to build the displayed text. If a custom entry_maker is provided,
-- it is called. Otherwise the default one is used. If you notice, only the default one gets the
-- opts.
--
--    entry_maker = opts.entry_maker or make_entry.gen_from_lsp_symbols(opts),
--
-- Since the custom entry_maker doesn't have the opts, I am not able to make a decision in the
-- entry_maker like
--
--     if markdown
--        return custom entry format
--     else
--        Delegate to the default entry maker
--     end
--
-- When I delegate to the default entry marker in the custom entry marker, it does not have access
-- to the opts. So, it ends up using the defaults and there is no way to customize it. So, I ended
-- up copying and modifying the document symbols function.
local exported_symbols = {}

local symbols_sorter = function(symbols)
  if vim.tbl_isempty(symbols) then
    return symbols
  end

  local current_buf = vim.api.nvim_get_current_buf()

  -- sort adequately for workspace symbols
  local filename_to_bufnr = {}
  for _, symbol in ipairs(symbols) do
    if filename_to_bufnr[symbol.filename] == nil then
      filename_to_bufnr[symbol.filename] = vim.uri_to_bufnr(vim.uri_from_fname(symbol.filename))
    end
    symbol.bufnr = filename_to_bufnr[symbol.filename]
  end

  table.sort(symbols, function(a, b)
    if a.bufnr == b.bufnr then
      return a.lnum < b.lnum
    end
    if a.bufnr == current_buf then
      return true
    end
    if b.bufnr == current_buf then
      return false
    end
    return a.bufnr < b.bufnr
  end)

  return symbols
end

local markdown_displayer = nil

local function markdown_entry_maker(entry)
  local entry_display = require 'telescope.pickers.entry_display'

  if markdown_displayer == nil then
    -- Create displayer only once instead of creating one per result entry
    markdown_displayer = entry_display.create {
      separator = ' ',
      items = {
        { remaining = true },
      },
    }
  end
  -- This function is mostly a copy of https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/make_entry.lua.
  -- Modified to avoid showing the symbol in markdown files.
  local make_display = function(entry_to_display)
    local symbol_type, symbol_name = entry_to_display.text:match '%[(.+)%]%s+(.*)'
    return markdown_displayer {
      symbol_name,
      { symbol_type, 'TelescopeResultsField' },
    }
  end

  local symbol_type, symbol_name = entry.text:match '%[(.+)%]%s+(.*)'
  return {
    value = entry,
    ordinal = symbol_name,
    display = make_display(entry),
    filename = entry.filename,
    symbol_name = symbol_name,
    symbol_type = symbol_type,
    lnum = entry.lnum,
    col = entry.col,
  }
end

-- Taken from https://github.com/nvim-telescope/telescope.nvim/blob/37dc9233a473dd6c3f54456ef9994d8f77c80211/lua/telescope/builtin/__lsp.lua#L324
exported_symbols.custom_document_symbols = function(opts)
  local conf = require('telescope.config').values
  local finders = require 'telescope.finders'
  local make_entry = require 'telescope.make_entry'
  local pickers = require 'telescope.pickers'
  local utils = require 'telescope.utils'

  local params = vim.lsp.util.make_position_params(opts.winnr)
  vim.lsp.buf_request(opts.bufnr, 'textDocument/documentSymbol', params, function(err, result, _, _)
    if err then
      vim.api.nvim_err_writeln('Error when finding document symbols: ' .. err.message)
      return
    end

    if not result or result == vim.NIL or vim.tbl_isempty(result) then
      utils.notify('builtin.lsp_document_symbols', {
        msg = 'No results from textDocument/documentSymbol',
        level = 'INFO',
      })
      return
    end

    local locations = vim.lsp.util.symbols_to_items(result, opts.bufnr) or {}
    locations = utils.filter_symbols(locations, opts, symbols_sorter)
    if locations == nil then
      -- error message already printed in `utils.filter_symbols`
      return
    end

    if vim.tbl_isempty(locations) then
      utils.notify('builtin.lsp_document_symbols', {
        msg = 'No document_symbol locations found',
        level = 'INFO',
      })
      return
    end

    if vim.bo.filetype == 'markdown' then
      -- All symbols are of type string in markdown.
      opts.symbol_width = 80
      opts.symbol_type_width = 0
    end
    opts.path_display = { 'hidden' }

    local picker_options = {
      prompt_title = 'LSP Document Symbols',
      previewer = conf.qflist_previewer(opts),
      sorter = conf.prefilter_sorter {
        tag = 'symbol_type',
        sorter = conf.generic_sorter(opts),
      },
      push_cursor_on_edit = true,
      push_tagstack_on_edit = true,
    }

    if vim.bo.filetype == 'markdown' then
      picker_options.finder = finders.new_table {
        results = locations,
        entry_maker = markdown_entry_maker,
      }
    else
      picker_options.finder = finders.new_table {
        results = locations,
        entry_maker = opts.entry_maker or make_entry.gen_from_lsp_symbols(opts),
      }
    end
    pickers.new(opts, picker_options):find()
  end)
end

return exported_symbols
