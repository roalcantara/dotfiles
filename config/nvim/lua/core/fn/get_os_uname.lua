--- Get os_name using `uname -s`
--- @return string|nil os_name - The os name or nil if not found
local function get_os_uname()
  local handle_uname_s = io.popen('uname -s 2>/dev/null')

  if handle_uname_s and handle_uname_s ~= nil then
    local u_name = handle_uname_s:read('*a')
    handle_uname_s:close()
    return u_name
  end

  return nil
end

return get_os_uname
