local M = {}

-- Helper function to execute vault commands
local function vault_cmd(cmd)
  -- In test environment, return mock values
  if package.loaded['specs.mocks.vault'] then
    if cmd == 'token lookup' then
      return 'mock_token'
    elseif cmd:match('kv get') then
      -- Return nil to simulate no secret found
      return nil
    end
    return nil
  end

  -- Real implementation
  local handle = io.popen('vault ' .. cmd)
  if handle then
    local result = handle:read('*a')
    handle:close()
    return result:gsub('\n$', '') -- Remove trailing newline
  end
  return nil
end

-- Get secret from Vault
function M.get_secret(path)
  -- Format: vault kv get -field=value secret/path
  local result = vault_cmd(string.format('kv get -field=value %s', path))
  if result and result ~= '' then
    return result
  end
  return nil
end

-- Check if vault is authenticated
function M.is_authenticated()
  local token = vault_cmd('token lookup')
  return token ~= nil and token ~= ''
end

return M
