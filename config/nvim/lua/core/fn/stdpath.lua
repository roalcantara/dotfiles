local has_stdpath, vi_stdpath = pcall(require, 'vim.fn.stdpath')

if has_stdpath then
  return vi_stdpath
end

--- Get the standard path for a given type
--- @param type string The type of path to get
--- @return string The standard path
local function stdpath(type)
  local stdpath_types = {
    cache = '~/.cache',
    config = '~/.config',
    data = '~/.local/share',
    state = '~/.local/state',
    log = '~/.local/log',
  }

  if not stdpath_types[type] then
    error('Invalid stdpath type: ' .. type)
  end

  return stdpath_types[type]
end

return stdpath
