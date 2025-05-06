local M = {
  homebrew_prefix_per_os = {
    ['darwin'] = '/opt/homebrew',
    ['linux'] = '/home/linuxbrew/.linuxbrew',
  },
  homebrew_prefix = nil,
  homebrew_bin = nil,
}

local function get_os()
  return require('core/etc/sys').os_info()
end

function M.get_homebrew_prefix()
  if not M.homebrew_prefix then
    M.homebrew_prefix = os.getenv('HOMEBREW_PREFIX')
    if not M.homebrew_prefix then
      M.homebrew_prefix = M.homebrew_prefix_per_os[get_os().name]
    end
  end
  return M.homebrew_prefix
end

function M.has_homebrew()
  return M.get_homebrew_prefix() ~= nil
end

function M.get_homebrew_bin()
  if not M.homebrew_bin then
    local homebrew_prefix = M.get_homebrew_prefix()
    if homebrew_prefix then
      M.homebrew_bin = homebrew_prefix .. '/bin'
    end
  end

  return M.homebrew_bin
end

function M.get_homebrew_bin_for(name)
  local homebrew_bin = M.get_homebrew_bin()

  if not homebrew_bin then
    return error('Homebrew not found!', 1)
  end

  return homebrew_bin .. '/' .. name
end

return M
