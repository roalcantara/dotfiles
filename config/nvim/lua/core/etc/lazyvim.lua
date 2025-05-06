return {
  --- Plugin related utility functions
  plug = {
    --- Get the opts for a given plugin
    ---@param plugin string Plugin name
    ---@return avante.Config
    get_opts = function(plugin)
      return require('lazy.core.plugin').values(require('lazy.core.config').spec.plugins[plugin], 'opts', false)
    end,
  },
}
