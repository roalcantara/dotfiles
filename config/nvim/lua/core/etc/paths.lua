local homebrew = require('core/etc/homebrew')
local os = require('core/etc/sys').os_info()
local stdpath = require('core/fn/stdpath')
local tbl_filter = require('core/fn/tbl_filter')
local tbl_map = require('core/fn/tbl_map')
local tbl_contains = require('core/fn/tbl_contains')
local is_executable = require('core/fn/is_executable')

local NON_NORMALIZED_PATHS = {
  'XDG_RUNTIME_DIR',
}

local M = {
  _system_bin = nil,
  _local_bin = nil,
  _homebrew_bin = nil,
}

-- normalize unpack
unpack = table.unpack or unpack

--- Join a base path with a list of parts
--- @param base string The base path
--- @param parts string[] | string The parts to join to the path
--- @param normalize? boolean Whether to normalize the path (default: false)
--- @return string path The joined path
function M.join(base, parts, normalize)
  if type(parts) == 'string' then
    parts = { parts }
  end

  if type(parts) == 'table' then
    parts = vim.iter(parts):flatten():totable()
  end

  -- Insert base as first argument
  local path_parts = { base }
  vim.list_extend(path_parts, parts)

  -- Use vim.fs.joinpath to handle path joining
  local path = vim.fs.joinpath(unpack(path_parts))

  -- Optionally normalize the path
  if normalize then
    path = vim.fs.normalize(path)
  end

  if path:match('/$') then
    path = path:sub(1, -2)
  end

  return path
end

--- Get the path to the PATH environment variable
--- @return string The path to the PATH environment variable
function M.get_path()
  return vim.fn.expand('$PATH')
end

--- Create a standard path function
--- @param type string The stdpath type
--- @return function The path function
local function from_stdpath(type)
  return function(args, normalize)
    return M.join(stdpath(type), args or {}, normalize)
  end
end

-- Generate standard path functions
M.to_data = from_stdpath('data')
M.to_config = from_stdpath('config')
M.to_state = from_stdpath('state')
M.to_cache = from_stdpath('cache')
M.to_log = from_stdpath('log')

local function cleanup_args(args)
  if not args then
    return {}
  end

  args = tbl_filter(args, function(v)
    return v ~= nil and type(v) == 'string' and v:match('^%s*(.-)%s*$'):len() > 0
  end)

  -- Remove leading and trailing whitespace
  return tbl_map(args, function(v)
    return v:match('^%s*(.-)%s*$')
  end)
end

--- Create a XDG path function
--- @param type string The XDG type
--- @return function The path function
local function from_xdg(type)
  return function(args, normalize)
    local res = M.join(vim.env[type], cleanup_args(args))
    if normalize and not tbl_contains(NON_NORMALIZED_PATHS, type) then
      res = vim.fs.normalize(res)
    end
    return res
  end
end

--- Get the XDG config directory path. I.E.: `~/.config/`
M.to_xdg_config_home = from_xdg('XDG_CONFIG_HOME')

--- Get the XDG cache directory path. I.E.: `~/.cache/`
M.to_xdg_cache_home = from_xdg('XDG_CACHE_HOME')

--- Get the XDG data directory path. I.E.: `~/.local/share/`
M.to_xdg_data_home = from_xdg('XDG_DATA_HOME')

--- Get the XDG state directory path. I.E.: `~/.local/state/`
M.to_xdg_state_home = from_xdg('XDG_STATE_HOME')

--- Get the XDG runtime directory path. I.E.: `~/.local/run/`
M.to_xdg_runtime_dir = from_xdg('XDG_RUNTIME_DIR')

--- Get the XDG desktop directory path. I.E.: `~/Desktop/`
M.to_xdg_desktop_dir = from_xdg('XDG_DESKTOP_DIR')

--- Get the XDG download directory path. I.E.: `~/Downloads/`
M.to_xdg_download_dir = from_xdg('XDG_DOWNLOAD_DIR')

--- Get the XDG documents directory path. I.E.: `~/Documents/`
M.to_xdg_documents_dir = from_xdg('XDG_DOCUMENTS_DIR')

--- Get the XDG music directory path. I.E.: `~/Music/`
M.to_xdg_music_dir = from_xdg('XDG_MUSIC_DIR')

--- Get the XDG pictures directory path. I.E.: `~/Pictures/`
M.to_xdg_pictures_dir = from_xdg('XDG_PICTURES_DIR')

--- Get the XDG videos directory path. I.E.: `~/Videos/`
M.to_xdg_videos_dir = from_xdg('XDG_VIDEOS_DIR')

--- Get the XDG projects directory path. I.E.: `~/Projects/`
M.to_xdg_projects_dir = from_xdg('XDG_PROJECTS_DIR')

--- Get the XDG workspace directory path. I.E.: `~/Work/`
M.to_xdg_workspace_dir = from_xdg('XDG_WORKSPACE_DIR')

--- Get the path to the system bin directory
--- @param normalize? boolean Whether to normalize the path (default: false)
--- @return string The path to the system bin directory
function M.get_system_bin(normalize)
  if not M._system_bin then
    M._system_bin = os.is_windows and '$SYSTEMROOT\\System32' or '/usr/bin'
  end
  if normalize then
    return vim.fn.expand(M._system_bin)
  end
  return M._system_bin
end

--- Get the path to the local bin directory
--- @param normalize? boolean Whether to normalize the path (default: false)
--- @return string The path to the local bin directory
function M.get_local_bin(normalize)
  if not M._local_bin then
    M._local_bin = os.is_windows and '$LOCALAPPDATA\\Programs' or '/usr/local/bin'
  end
  if normalize then
    return vim.fn.expand(M._local_bin)
  end
  return M._local_bin
end

--- Get the path to the Homebrew bin directory
--- @param normalize? boolean Whether to normalize the path (default: false)
--- @return string The path to the Homebrew bin directory
function M.get_homebrew_bin(normalize)
  if not M._homebrew_bin then
    if homebrew.has_homebrew() then
      M._homebrew_bin = homebrew.get_homebrew_bin()
    end
  end
  if normalize then
    return vim.fn.expand(M._homebrew_bin)
  end
  return M._homebrew_bin
end

--- Get the path to a command
--- @param name string The name of the command
--- @param normalize? boolean Whether to normalize the path (default: false)
--- @return string The path to the command
function M.bin_for(name, normalize)
  local prefix = M.get_homebrew_bin(normalize)

  if not prefix then
    prefix = M.get_local_bin(normalize)
  end

  return M.join(prefix, name, normalize)
end

--- Check if a command is executable in the PATH
--- @param name string The name of the command to check
--- @return fun(): boolean Function that returns true if the command is executable, false otherwise
function M.is_executable(name)
  return function()
    return is_executable(name)
  end
end

return M
