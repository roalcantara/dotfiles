return {
  -- AVANTE - Use your Neovim like using Cursor AI IDE!
  -- https://github.com/yetone/avante.nvim?tab=readme-ov-file#installation
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    enabled = true,
    version = false, -- Never set this value to '*'! Never!
    build = 'make',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      --- The below dependencies are optional,
      'echasnovski/mini.pick',         -- for file_selector provider mini.pick
      'nvim-telescope/telescope.nvim', -- for file_selector provider telescope
      'hrsh7th/nvim-cmp',              -- autocompletion for avante commands and mentions
      'ibhagwan/fzf-lua',              -- for file_selector provider fzf
      'nvim-tree/nvim-web-devicons',   -- or echasnovski/mini.icons
      'zbirenbaum/copilot.lua',        -- for providers='copilot'
      {
        -- support for image pasting
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'markdown', 'Avante' },
          latex = { enabled = false },
        },
        ft = { 'markdown', 'Avante' },
      },
    },
    ---@see https://github.com/yetone/avante.nvim?tab=readme-ov-file#installation
    ---@see https://github.com/yetone/avante.nvim/wiki#secrets
    opts = function(_, opts)
      return vim.tbl_deep_extend('force', opts, {
        provider = 'claude',
        claude = {
          api_key_name = 'cmd:doppler secrets get ANTROPIC_TOKEN --plain', -- the shell command must prefixed with `^cmd:(.*)`
          timeout = 60000,                                                 -- Timeout in milliseconds, increase this for reasoning models
        },
        openai = {
          endpoint = 'https://api.openai.com/v1',
          api_key_name = 'cmd:doppler secrets get OPENAI_TOKEN --plain', -- the shell command must prefixed with `^cmd:(.*)`
          model = 'gpt-4o',                                              -- your desired model (or use gpt-4o, etc.)
          timeout = 60000,                                               -- Timeout in milliseconds, increase this for reasoning models
          temperature = 0,
          max_tokens = 8192,                                             -- Increase this to include reasoning tokens (for reasoning models)
          --reasoning_effort = 'medium', -- low|medium|high, only used for reasoning models
        },
        copilot = {
          api_key_name = 'cmd:doppler secrets get COPILOT_TOKEN --plain', -- the shell command must prefixed with `^cmd:(.*)`
          endpoint = 'https://api.githubcopilot.com',
          model = 'gpt-4o-2024-08-06',
          proxy = nil,            -- [protocol://]host[:port] Use this proxy
          allow_insecure = false, -- Allow insecure server connections
          timeout = 60000,        -- Timeout in milliseconds (1min)
          temperature = 0,
          max_tokens = 20480,
        },
        gemini = {
          api_key_name = 'cmd:doppler secrets get GEMINI_TOKEN --plain', -- the shell command must prefixed with `^cmd:(.*)`
          endpoint = 'https://generativelanguage.googleapis.com/v1beta/models',
          model = 'gemini-2.0-flash',                                    -- 'gemini-1.5-flash-latest',
          timeout = 60000,                                               -- Timeout in milliseconds (1min)
          temperature = 0,
          max_tokens = 20480,
        },
      })
    end
  }
}
