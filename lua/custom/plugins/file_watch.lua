-- Check if the provided file contains the given text. The first return value indicates if the text
-- was found. If it contains the text, the last line number that contains the text is returned as
-- the second return value. The second argument is valid only if the file contains the text.
--
-- file_path can be absolute or relative. Relative paths will be expanded to abs path.
--
-- If there is an error in opening the file for reading, the function returns false.
function FILE_CONTAINS_TEXT(file_path, text)
  local abs_file_path = vim.fn.fnamemodify(file_path, ':p')
  local file = io.open(abs_file_path, 'r')

  local last_line_with_match = nil
  local found = false
  if file then
    local line_number = 0

    for line in file:lines() do
      line_number = line_number + 1
      if line:match(text) then
        last_line_with_match = line_number
        found = true
      end
    end

    file:close()
  else
    require 'notify'('Could not open file ' .. file_path, 'error')
  end

  -- last_line_number is valid only if found=true
  return found, last_line_with_match
end
