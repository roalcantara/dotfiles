local has_is_executable, vi_is_executable = pcall(require, 'vim.fn.is_executable')

if has_is_executable then
  return vi_is_executable
end

--- Check if a file is executable
--- @param file_path string The path to the file to check
--- @return boolean true if the file is executable, false otherwise
local function is_executable(file_path)
  if not file_path then
    return false
  end

  if package.config:sub(1, 1) == '\\' then
    -- Windows - less reliable, just check if file exists
    return os.execute('if exist "' .. file_path .. '" exit 0') == 0
  end

  return os.execute('test -x "' .. file_path .. '"') == 0
end

return is_executable
