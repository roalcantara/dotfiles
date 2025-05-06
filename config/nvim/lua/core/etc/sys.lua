local get_os_uname = require('core/fn/get_os_uname_vim')
local get_os_uname_released = require('core/fn/get_os_uname_released')

local M = {
  _os = nil,
  _name = nil,
  is_windows = nil,
  is_darwin = nil,
  is_linux = nil,
  is_wsl = nil,
  separator = nil,
}

--- Check if the operating system is Windows
--- @warning WINDIR or SystemRoot are Windows-specific environment variables
--- @warning In Windows, the path separator is '\', while on Unix-like systems it's '/'
--- @return boolean true if the operating system is Windows, false otherwise
function M.is_win()
  if M.is_windows == nil then
    M.is_windows = os.getenv('WINDIR') ~= nil or os.getenv('SystemRoot') ~= nil or package.config:sub(1, 1) == '\\'

    if M.is_windows then
      M._name = 'windows'
      M.separator = ';'
    end
  end

  return M.is_windows
end

--- Check if the operating system is macOS
--- @return boolean true if the operating system is macOS, false otherwise
function M.is_mac()
  local uname = get_os_uname()
  if uname ~= nil and uname.sysname:lower() == 'darwin' then
    M.is_darwin = true
    M._name = 'darwin'
    M.separator = '/'
  end
  return M.is_darwin
end

--- Check if the operating system is Linux
--- @return boolean true if the operating system is Linux, false otherwise
function M.is_linux_based()
  local uname = get_os_uname()
  if
      uname ~= nil
      and (uname.sysname:lower() == 'linux' or uname.sysname:lower() == 'freebsd' or uname.sysname:lower() == 'bsd')
  then
    M.is_linux = true
    M._name = 'linux'
    M.separator = '/'
  end
  return M.is_linux
end

--- Check if the operating system is WSL (Windows Subsystem for Linux)
--- @return boolean true if the operating system is WSL, false otherwise
function M.is_windows_subsystem_for_linux()
  if M.is_linux and M.is_wsl == nil then
    local uname_released = get_os_uname_released()
    if uname_released ~= nil then
      M.is_wsl = uname_released:lower():match('microsoft') ~= nil
    end
  end

  return M.is_wsl
end

--- Get the operating system information
--- @return table
function M.os_info()
  M.is_win()
  M.is_mac()
  M.is_linux_based()
  M.is_windows_subsystem_for_linux()

  return M
end

return M
