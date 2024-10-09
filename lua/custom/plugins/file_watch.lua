local function truncate_file(file_path)
  local file = io.open(file_path, 'w+')

  if not file then
    require 'notify'('Could not truncate file ' .. file_path, 'error')
    return
  end

  file:write ''
  file:flush()
  file:close()
end

function SEARCH_IN_FILE(file_path)
  local abs_file_path = vim.fn.fnamemodify(file_path, ':p')
  -- truncates the file for performance reasons. Reading a smaller file is faster.
  truncate_file(abs_file_path)

  local file_offset = 0

  -- Check if the provided file contains the given text. The first return value indicates if the text
  -- was found. If it contains the text, the last line number that contains the text is returned as
  -- the second return value. The second argument is valid only if the file contains the text.
  --
  -- file_path can be absolute or relative. Relative paths will be expanded to abs path.
  --
  -- If there is an error in opening the file for reading, the function returns false.
  return function(search_term)
    local file = io.open(abs_file_path, 'r')

    if not file then
      require 'notify'('Could not open file ' .. file_path, 'error')
      return false
    end

    file:seek('set', file_offset)

    local last_line_with_match = nil
    local line_contents = nil
    local found = false
    local line_number = 0

    for line in file:lines() do
      line_number = line_number + 1
      if line:match(search_term) then
        last_line_with_match = line_number
        line_contents = line
        found = true
      end
    end

    -- Remember the new offset
    file_offset = file:seek()
    file:close()

    -- last_line_number is valid only if found=true
    return found, last_line_with_match, line_contents
  end
end
