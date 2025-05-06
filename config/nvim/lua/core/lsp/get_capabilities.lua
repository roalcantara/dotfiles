local get_blink_capabilities = function()
  local has_blink, blink = pcall(require, 'blink.cmp')

  return (has_blink and blink and type(blink.get_lsp_capabilities) == 'function')
      and blink.get_lsp_capabilities({}, false)
      or {}
end

local get_capabilities = function(current)
  local current_capabilities = current or {
    textDocument = {
      foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
      }
    }
  }
  local blink_capabilities = get_blink_capabilities()
  local client_capabilities = vim.lsp.protocol.make_client_capabilities() or {}
  local merged_capabilities = vim.tbl_deep_extend('force', client_capabilities, blink_capabilities)

  return vim.tbl_deep_extend('force', merged_capabilities, current_capabilities)
end

return get_capabilities
