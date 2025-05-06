---@class SecretOptions
---@field secret_provider? string The provider to use (e.g., 'vault', 'pass', 'gopass')
---@field secret_key? string The environment variable key to check first
---@field secret_path? string The path to the secret in the provider
---@field prompt_text? string Optional custom prompt text for user input
---@field default_value? string Optional default value if no secret is found

--- Retrieves a secret value from a secret provider
---@param opts SecretOptions Options for retrieving a secret value
---@return string|nil value The secret value or nil if not found
---@examples local secret = get_secret({ secret_provider = 'vault', secret_key = 'VAULT_TOKEN', secret_path = 'secret/data/my-secret' })
local function get_secret(opts)
  -- Validate required options
  local required_fields = {
    secret_provider = 'provider',
    secret_key = 'environment variable key',
    secret_path = 'secret path'
  }

  for field, description in pairs(required_fields) do
    if not opts[field] then
      vim.notify(string.format('%s (%s) is required', description, field), vim.log.levels.ERROR)
      return nil
    end
  end

  -- Try environment variable first
  local key = vim.fn.getenv(opts.secret_key)
  if key and key ~= '' then
    return key
  end

  -- Try secret provider
  local secret_provider_ok, secret_provider = pcall(require, 'lua/core/sec/' .. opts.secret_provider)
  if secret_provider_ok and secret_provider.is_authenticated() then
    key = secret_provider.get_secret(opts.secret_path)
    if key then
      return key
    end
  end

  -- If no key found, prompt user
  local prompt = opts.prompt_text or string.format('Enter your %s secret: ', opts.secret_provider)
  local value = vim.fn.inputsecret(prompt)

  -- Return default value if input is empty
  if value == '' and opts.default_value then
    return opts.default_value
  end

  return value
end

return get_secret
