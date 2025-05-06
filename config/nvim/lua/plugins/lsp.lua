-- LSP servers and clients communicate which features they support through "capabilities".
--  By default, Neovim supports a subset of the LSP specification.
--  With blink.cmp, Neovim has _more_ capabilities which are communicated to the LSP servers.
--  Explanation from TJ: https://youtu.be/m8C0Cq9Uv9o?t=1275
-- This can vary by config, but in general for nvim-lspconfig:
local paths = require('core/etc/paths')

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- LAZYDEV | Configures Lua LSP for your Neovim config, runtime and plugins used for completion, annotations and signatures of Neovim apis
      -- https://github.com/folke/lazydev.nvim
      'folke/lazydev.nvim',

      -- mason-lspconfig.nvim is a plugin that bridges the gap between mason and nvim-lspconfig
      -- https://github.com/williamboman/mason-lspconfig.nvim
      -- https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
      -- https://lazyvim.org/plugins/lsp#masonnvim-1
      {
        'williamboman/mason-lspconfig.nvim',
        dependencies = {
          'williamboman/mason.nvim',
        },
        opts = {
          -- A list of servers to automatically install if they're not already installed.
          -- https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
          ensure_installed = {
            'ast_grep',
            'bashls',
            'cssls',
            'diagnosticls',
            'docker_compose_language_service',
            'dockerls',
            'eslint',
            'html',
            'jsonls',
            'kotlin_language_server',
            'lua_ls',
            'marksman',
            'neocmake',
            'pyright',
            'ruby_lsp',
            'taplo',
            'vimls',
            'vtsls',
            'yamlls'
          },
          -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
          -- This setting has no relation with the `ensure_installed` setting.
          -- Can either be:
          --   - false: Servers are not automatically installed.
          --   - true: All servers set up via lspconfig are automatically installed - except the ones provided in the list `ensure_installed`
          automatic_installation = true,
        },
      },
    },
    opts = function(_, opts)
      return vim.tbl_deep_extend('force', opts, {
        -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
        -- Be aware that you also will need to properly configure your LSP server to
        -- provide the code lenses.
        codelens = {
          enabled = true,
        },
        -- LSP Server Settings
        ---@type lspconfig.options
        servers = {
          -- ast-grep
          -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#ast_grep
          ast_grep = {},
          -- bash-language-server
          -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#bashls
          bashls = {},
          -- css-lsp
          -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#cssls
          cssls = {},
          -- diagnostic-languageserver
          -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#diagnosticls
          diagnosticls = {},
          -- docker-compose-language-service
          -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#docker_compose_language_service
          docker_compose_language_service = {},
          -- dockerls
          -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#dockerls
          dockerls = {},
          -- eslint-lsp
          -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#eslint
          eslint = {},
          -- html-lsp
          -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#html
          html = {},
          -- json-lsp
          -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#jsonls
          jsonls = {
            server_capabilities = {
              documentFormattingProvider = false,
            },
            filetypes = { 'json', 'jsonc' },
          },
          -- lua-language-server
          -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls
          lua_ls = {},
          -- marksman
          -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#marksman
          marksman = {},
          -- neocmakelsp
          -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#neocmake
          neocmake = {},
          -- pyright
          -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#pyright
          pyright = {},
          -- ruby-lsp
          -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#ruby_lsp
          ruby_lsp = {},
          -- taplo
          -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#taplo
          taplo = {},
          -- tsserver
          -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#tsserver
          tsserver = false,
          -- typescript-language-server
          -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#ts_ls
          ts_ls = false,
          -- vim-language-server
          -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#vimls
          vimls = {},
          -- vtsls
          -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#vtsls
          vtsls = {
            server_capabilities = {
              documentFormattingProvider = false,
            },
            filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx' },
          },
          -- yaml-language-server
          -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#yamlls
          yamlls = {
            filetypes = { 'yaml', 'yml' },
          },
        },
      })
    end,
  },
}
