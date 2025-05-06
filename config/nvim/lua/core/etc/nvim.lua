local M = {
  --- Get the current Neovim version
  --- @return string The current Neovim _VERSION
  get_nvim_version = function()
    local version = vim.version()
    return version.major .. '.' .. version.minor .. '.' .. version.patch
  end,

  --- Get the current LazyVim version
  --- @return string The current LazyVim version
  get_lazyvim_version = function()
    local lazyvim_version = require('lazy.core.config').version
    return lazyvim_version
  end,
}

return M
