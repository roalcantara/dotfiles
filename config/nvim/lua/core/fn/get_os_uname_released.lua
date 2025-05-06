--- Get os_release_name using `uname -r`
--- @return string|nil os_name - The os release name or nil if not found
local function get_os_uname_released()
  local handle_uname_r = io.popen('uname -r 2>/dev/null')

  if handle_uname_r and handle_uname_r ~= nil then
    local u_name = handle_uname_r:read('*a')
    handle_uname_r:close()
    return u_name
  end

  return nil
end

return get_os_uname_released
