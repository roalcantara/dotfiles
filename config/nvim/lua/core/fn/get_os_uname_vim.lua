local get_os_uname = require('core/fn/get_os_uname')
local get_os_uname_released = require('core/fn/get_os_uname_released')

--- Get os_uname (vim.uv.os_uname)
--- @return table|nil os_uname - The os_uname or nil if not found
local function get_os_uname_vim()
  local vi_os_uname_ok, vi_os_uname = pcall(vim.uv.os_uname)
  if vi_os_uname_ok and vi_os_uname ~= nil then
    return vi_os_uname
  end

  local os_name = get_os_uname()
  if os_name ~= nil then
    return {
      sysname = os_name,
    }
  end

  local os_release_name = get_os_uname_released()
  if os_release_name ~= nil then
    return {
      release = os_release_name,
    }
  end

  return nil
end

return get_os_uname_vim
