local get_default_sources = require('core/lsp/get_sources_by_filetype')

return {
  -- Source replacement by 'fang2hou/blink-copilot'
  -- https://github.com/fang2hou/blink-copilot?tab=readme-ov-file#with--lazyvim-copilot-extra
  { 'giuxtaposition/blink-cmp-copilot', enabled = false },

  -- BLINK - Performant, batteries-included completion plugin for Neovim
  -- https://cmp.saghen.dev
  -- https://github.com/saghen/blink.cmp
  {
    'saghen/blink.cmp',
    dependencies = {
      -- LAZYDEV - Configure Lua LSP Neovim config for runtime, plugins, completions, annotations, signatures and apis
      -- https://github.com/folke/lazydev.nvim
      'folke/lazydev.nvim',

      -- Conventional Commits source for blink-cmp
      -- https://github.com/disrupted/blink-cmp-conventional-commits?tab=readme-ov-file#installation
      'disrupted/blink-cmp-conventional-commits',

      -- Configurable GitHub Copilot blink.cmp source for Neovim
      -- https://github.com/fang2hou/blink-copilot?tab=readme-ov-file#with--lazyvim-copilot-extra
      'fang2hou/blink-copilot',

      -- Avante source for blink-cmp
      -- https://github.com/Kaiser-Yang/blink-cmp-avante?tab=readme-ov-file#installation
      {
        'Kaiser-Yang/blink-cmp-avante',
        init = function()
          vim.api.nvim_set_hl(0, 'BlinkCmpKindAvanteCmd', { default = false, fg = '#89b4fa' })
          vim.api.nvim_set_hl(0, 'BlinkCmpKindAvanteMention', { default = false, fg = '#89b4fa' })
        end,
      },

      -- Git source for blink-cmp
      -- https://github.com/Kaiser-Yang/blink-cmp-git?tab=readme-ov-file#lazynvim
      {
        'Kaiser-Yang/blink-cmp-git',
        dependencies = { 'nvim-lua/plenary.nvim' },
      },

      -- Colorful Menu source for blink-cmp
      -- https://github.com/xzbdmw/colorful-menu.nvim
      {
        'xzbdmw/colorful-menu.nvim',
        opts = {
          ls = {
            lua_ls = {
              -- Maybe you want to dim arguments a bit.
              arguments_hl = '@comment',
            },
            gopls = {
              -- By default, we render variable/function's type in the right most side,
              -- to make them not to crowd together with the original label.

              -- when true:
              -- foo             *Foo
              -- ast         'go/ast'

              -- when false:
              -- foo *Foo
              -- ast 'go/ast'
              align_type_to_right = true,
              -- When true, label for field and variable will format like 'foo: Foo'
              -- instead of go's original syntax 'foo Foo'. If align_type_to_right is
              -- true, this option has no effect.
              add_colon_before_type = false,
              -- See https://github.com/xzbdmw/colorful-menu.nvim/pull/36
              preserve_type_when_truncate = true,
            },
            -- for lsp_config or typescript-tools
            vtsls = {
              -- false means do not include any extra info,
              -- see https://github.com/xzbdmw/colorful-menu.nvim/issues/42
              extra_info_hl = '@comment',
            },
            ['rust-analyzer'] = {
              -- Such as (as Iterator), (use std::io).
              extra_info_hl = '@comment',
              -- Similar to the same setting of gopls.
              align_type_to_right = true,
              -- See https://github.com/xzbdmw/colorful-menu.nvim/pull/36
              preserve_type_when_truncate = true,
            },
            clangd = {
              -- Such as 'From <stdio.h>'.
              extra_info_hl = '@comment',
              -- Similar to the same setting of gopls.
              align_type_to_right = true,
              -- the hl group of leading dot of '•std::filesystem::permissions(..)'
              import_dot_hl = '@comment',
              -- See https://github.com/xzbdmw/colorful-menu.nvim/pull/36
              preserve_type_when_truncate = true,
            },
            zls = {
              -- Similar to the same setting of gopls.
              align_type_to_right = true,
            },
            roslyn = {
              extra_info_hl = '@comment',
            },
            dartls = {
              extra_info_hl = '@comment',
            },
            -- The same applies to pyright/pylance
            basedpyright = {
              -- It is usually import path such as 'os'
              extra_info_hl = '@comment',
            },
            -- If true, try to highlight 'not supported' languages.
            fallback = true,
            -- this will be applied to label description for unsupport languages
            fallback_extra_info_hl = '@comment',
          },
          -- If the built-in logic fails to find a suitable highlight group for a label,
          -- this highlight is applied to the label.
          fallback_highlight = '@variable',
          -- If provided, the plugin truncates the final displayed text to
          -- this width (measured in display cells). Any highlights that extend
          -- beyond the truncation point are ignored. When set to a float
          -- between 0 and 1, it'll be treated as percentage of the width of
          -- the window: math.floor(max_width * vim.api.nvim_win_get_width(0))
          -- Default 60.
          max_width = 60,
        },
      },
    },
    -- Blink cmp has a lot of configuration options
    -- https://lazyvim.org/extras/coding/blink#blinkcmp
    -- https://cmp.saghen.dev/configuration/general.html
    opts = function(_, opts)
      opts = opts or {}
      -- Enables keymaps, completions and signature help when true (doesn't apply to cmdline or term)
      -- If the function returns 'force', the default conditions for disabling the plugin will be ignored
      opts.enabled = function()
        -- Note that the default conditions are ignored when `vim.b.completion` is explicitly set to `true`
        -- Exceptions: vim.bo.filetype == 'dap-repl'
        return vim.bo.buftype ~= 'prompt' and vim.b.completion ~= false
        -- and not vim.tbl_contains({ 'lua', 'markdown' }, vim.bo.filetype)
      end

      -- Appearance
      -- https://cmp.saghen.dev/configuration/appearance.html
      -- https://cmp.saghen.dev/configuration/reference.html#appearance
      opts.appearance = vim.tbl_deep_extend('force', opts.appearance or {}, {
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'. Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'Nerd Font Mono',
        -- SET KIND ICONS
        -- https://lazyvim.org/extras/coding/blink#blinkcmp-1
        kind_icons = vim.tbl_extend("force", opts.appearance.kind_icons or {}, LazyVim.config.icons.kinds),
      })

      -- Command line (cmdline)
      -- Configure cmdline completion
      -- https://cmp.saghen.dev/modes/cmdline.html
      -- https://cmp.saghen.dev/configuration/reference.html#cmdline
      opts.cmdline = opts.cmdline or {}
      opts.cmdline = vim.tbl_extend('force', opts.cmdline, {
        enabled = true,
        keymap = {
          preset = 'cmdline',
          -- ['<Tab>'] = {
          --   function(cmp)
          --     -- If ghost text is visible and menu is not visible, accept the completion.
          --     if cmp.is_ghost_text_visible() and not cmp.is_menu_visible() then
          --       return cmp.accept()
          --     end
          --   end,
          --   'show_and_insert',                              -- Otherwise, shows the completion menu and inserts the first item
          --   'select_next',                                  -- Subsequent <Tab>s select the next item in the completion list
          -- },
          -- ['<S-Tab>'] = 'select_prev',                      -- Selects the previous item in the completion list
          -- ['<C-Space>'] = { 'show', 'fallback' },           -- triggers the completion menu, Runs the next non-blink keymap, or runs the built-in neovim binding
          -- ['<M-Right>'] = 'fallback_to_mappings',           -- Runs the next non-blink keymap, or runs the built-in neovim binding (Go to end of next word)
          -- ['<M-Left>'] = 'fallback_to_mappings',            -- Runs the next non-blink keymap, or runs the built-in neovim binding (Go to start of previous word)
          -- ['<D-Right>'] = 'fallback_to_mappings',           -- Runs the next non-blink keymap, or runs the built-in neovim binding (Go to end of the line)
          -- ['<D-Left>'] = 'fallback_to_mappings',            -- Runs the next non-blink keymap, or runs the built-in neovim binding (Go to start of the line)
          -- ['<Up>'] = 'select_prev',                         -- Selects the previous history item
          -- ['<Down>'] = 'select_next',                       -- Selects the next item, cycling to the top of the list if at the bottom
          -- ['<ESC>'] = 'close',                              -- Closes the completion menu
          -- ['<q>'] = { 'cancel', 'fallback_to_mappings' },   -- Reverts completion.list.selection.auto_insert and hides the completion menu
          -- ['<C-l>'] = { 'cancel', 'fallback_to_mappings' }, -- Reverts completion.list.selection.auto_insert and hides the completion menu
        },
        sources = function()
          local type = vim.fn.getcmdtype()
          -- Search '/' forward and '?' backward
          if type == '/' or type == '?' then
            return { 'buffer' }
          end
          -- Commands ':' and '@'
          if type == ':' or type == '@' then
            return { 'cmdline' }
          end
          return {}
        end,
        completion = {
          -- Controls when to request completion items from the sources and show the completion menu
          -- trigger = {
          --   show_on_blocked_trigger_characters = {},
          --   show_on_x_blocked_trigger_characters = {},
          -- },

          list = {
            selection = {
              -- When `true`, will automatically select the first item in the completion list
              preselect = true,
              -- When `true`, inserts the completion item automatically when selecting it
              auto_insert = true,
            },
          },

          -- Whether to automatically show the window when new completion items are available
          menu = {
            -- https://cmp.saghen.dev/modes/cmdline.html#show-menu-automatically
            auto_show = function(ctx)
              -- only show the menu only when writing commands for inputs
              -- and not when searching or using other input menus.
              return vim.fn.getcmdtype() == ':' or vim.fn.getcmdtype() == '@'
            end,
          },

          -- When noice.nvim is detected, ghost text will be shown, likely similar to your terminal shell completions.
          -- Pressing <Tab> while ghost text is visible will accept the completion.
          -- When not visible, <Tab> will open the menu and insert the first item as per usual.
          -- https://cmp.saghen.dev/modes/cmdline#ghost-text
          ghost_text = { enabled = true },
        },

        -- opts.cmdline = vim.tbl_deep_extend('force', opts.cmdline or {}, {
        --   enabled = true,
        --   keymap = vim.tbl_deep_extend('force', opts.cmdline.keymap or {}, {
        --     --
        --     -- https://cmp.saghen.dev/modes/cmdline.html#keymap-preset
        --     preset = 'cmdline',
        --     -- ['<Tab>'] = {
        --     --   function(cmp)
        --     --     -- If ghost text is visible and menu is not visible, accept the completion.
        --     --     if cmp.is_ghost_text_visible() and not cmp.is_menu_visible() then
        --     --       return cmp.accept()
        --     --     end
        --     --   end,
        --     --   'show_and_insert',                              -- Otherwise, shows the completion menu and inserts the first item
        --     --   'select_next',                                  -- Subsequent <Tab>s select the next item in the completion list
        --     -- },
        --     -- ['<S-Tab>'] = 'select_prev',                      -- Selects the previous item in the completion list
        --     -- ['<C-Space>'] = { 'show', 'fallback' },           -- triggers the completion menu, Runs the next non-blink keymap, or runs the built-in neovim binding
        --     -- ['<M-Right>'] = 'fallback_to_mappings',           -- Runs the next non-blink keymap, or runs the built-in neovim binding (Go to end of next word)
        --     -- ['<M-Left>'] = 'fallback_to_mappings',            -- Runs the next non-blink keymap, or runs the built-in neovim binding (Go to start of previous word)
        --     -- ['<D-Right>'] = 'fallback_to_mappings',           -- Runs the next non-blink keymap, or runs the built-in neovim binding (Go to end of the line)
        --     -- ['<D-Left>'] = 'fallback_to_mappings',            -- Runs the next non-blink keymap, or runs the built-in neovim binding (Go to start of the line)
        --     -- ['<Up>'] = 'select_prev',                         -- Selects the previous history item
        --     -- ['<Down>'] = 'select_next',                       -- Selects the next item, cycling to the top of the list if at the bottom
        --     -- ['<ESC>'] = 'close',                              -- Closes the completion menu
        --     -- ['<q>'] = { 'cancel', 'fallback_to_mappings' },   -- Reverts completion.list.selection.auto_insert and hides the completion menu
        --     -- ['<C-l>'] = { 'cancel', 'fallback_to_mappings' }, -- Reverts completion.list.selection.auto_insert and hides the completion menu
        --   }),
        --   completion = vim.tbl_deep_extend('force', opts.cmdline.completion or {}, {
        --     menu = vim.tbl_deep_extend('force', ((opts.cmdline or {}).completion or {}).menu or {}, {
        --       -- Show menu automatically
        --       -- Whether to automatically show the window when new completion items are available
        --       -- https://cmp.saghen.dev/modes/cmdline.html#show-menu-automatically
        --       auto_show = function(ctx)
        --         -- only show the menu only when writing commands for inputs
        --         -- and not when searching or using other input menus.
        --         return vim.fn.getcmdtype() == ':' or vim.fn.getcmdtype() == '@'
        --       end,
        --     }),
        --     -- When noice.nvim is detected, ghost text will be shown, likely similar to your terminal shell completions.
        --     -- Pressing <Tab> while ghost text is visible will accept the completion.
        --     -- When not visible, <Tab> will open the menu and insert the first item as per usual.
        --     -- https://cmp.saghen.dev/modes/cmdline#ghost-text
        --     ghost_text = vim.tbl_deep_extend('force', ((opts.cmdline or {}).completion or {}).ghost_text or {}, {
        --       enabled = true
        --     }),
        --   }),
        -- })
      })

      -- Keymap
      -- Blink uses a special schema for defining keymaps since it needs to handle falling back to other mappings
      -- https://cmp.saghen.dev/configuration/keymap.html
      opts.keymap = vim.tbl_deep_extend('force', opts.keymap, {
        -- super-tab: Specify exaclty the same completion keymaps as used on VSCode - witch is based on Atom's:
        -- https://cmp.saghen.dev/configuration/keymap.html#super-tab
        preset = 'super-tab',
      })

      -- Completions
      -- Blink cmp has a lot of configuration options
      -- The documentation tries to highlight the ones you'll likely care the most about
      -- https://cmp.saghen.dev/configuration/completion.html
      opts.completion = vim.tbl_deep_extend('force', opts.completion, {
        -- Match VSCode behavior for auto-selection and insertion
        -- 'prefix' will fuzzy match on the text before the cursor
        -- 'full' will fuzzy match on the text before _and_ after the cursor
        -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
        -- https://cmp.saghen.dev/configuration/completion.html#keyword
        -- https://cmp.saghen.dev/configuration/reference.html#completion-keyword
        keyword = vim.tbl_deep_extend('force', opts.completion.keyword or {}, {
          range = 'full'
        }),

        -- Completion Trigger
        -- Controls when to request completion items from the sources and show the completion menus
        -- https://cmp.saghen.dev/configuration/completion.html#trigger
        -- https://cmp.saghen.dev/configuration/reference.html#completion-trigger
        trigger = vim.tbl_deep_extend('force', opts.completion.trigger or {}, {
          -- When true, will prefetch the completion items when entering insert mode
          prefetch_on_insert = true,

          -- When false, will not show the completion window automatically when in a snippet
          -- disabled due to super-tab: https://cmp.saghen.dev/configuration/keymap.html#super-tab
          show_in_snippet = false,

          -- When true, will show the completion window after typing any of alphanumerics, `-` or `_`
          show_on_keyword = true,

          -- When true, will show the completion window after typing a trigger character
          show_on_trigger_character = true,

          -- LSPs can indicate when to show the completion window via trigger characters
          -- however, some LSPs (i.e. tsserver) return characters that would essentially
          -- always show the window. We block these by default.
          show_on_blocked_trigger_characters = { ' ', '\n', '\t' },
          -- You can also block per filetype with a function:
          -- show_on_blocked_trigger_characters = function(ctx)
          --   if vim.bo.filetype == 'markdown' then return { ' ', '\n', '\t', '.', '/', '(', '[' } end
          --   return { ' ', '\n', '\t' }
          -- end,

          -- When both this and show_on_trigger_character are true, will show the completion window
          -- when the cursor comes after a trigger character after accepting an item
          show_on_accept_on_trigger_character = true,

          -- When both this and show_on_trigger_character are true, will show the completion window
          -- when the cursor comes after a trigger character when entering insert mode
          show_on_insert_on_trigger_character = true,

          -- List of trigger characters (on top of `show_on_blocked_trigger_characters`) that won't trigger
          -- the completion window when the cursor comes after a trigger character when
          -- entering insert mode/accepting an item
          show_on_x_blocked_trigger_characters = { '\'', '"', '(' },
          -- or a function, similar to show_on_blocked_trigger_character
        }),

        -- Completion List
        -- Manages the completion list and its behavior when selecting items.
        -- https://cmp.saghen.dev/configuration/completion.html#list
        -- https://cmp.saghen.dev/configuration/reference.html#completion-list
        list = vim.tbl_deep_extend('force', opts.completion.list or {}, {
          -- Maximum number of items to display
          max_items = 200,

          selection = {
            -- When `true`, will automatically select the first item in the completion list
            -- Set as function due to super-tab: https://cmp.saghen.dev/configuration/keymap.html#super-tab
            preselect = function(ctx)
              return not require('blink.cmp').snippet_active({ direction = 1 })
            end,

            -- When `true`, inserts the completion item automatically when selecting it
            -- You may want to bind a key to the `cancel` command (default <C-e>) when using this option,
            -- which will both undo the selection and hide the completion menu
            auto_insert = true,
            -- auto_insert = function(ctx) return vim.bo.filetype ~= 'markdown' end
          },

          cycle = {
            -- When `true`, `select_next` at the _bottom_ of the completion list selects the _first_ completion item.
            from_bottom = true,
            -- When `true`, `select_prev` at the _top_ of the completion list selects the _last_ completion item.
            from_top = true,
          },
        }),

        -- Accepts
        -- Manages the behavior when accepting an item in the completion menu
        -- https://cmp.saghen.dev/configuration/completion.html#accept
        -- https://cmp.saghen.dev/configuration/reference.html#completion-accept
        accept = vim.tbl_deep_extend('force', opts.completion.accept or {}, {
          -- Auto Brackets
          -- Add brackets for functions/methods and place the cursor inside the brackets automatically
          -- https://cmp.saghen.dev/configuration/completion.html#auto-brackets
          -- https://cmp.saghen.dev/configuration/reference.html#completion-accept
          auto_brackets = { enabled = true }
        }),

        -- Menu
        -- Manages the appearance of the completion menu.
        -- https://cmp.saghen.dev/configuration/completion.html#menu
        -- https://cmp.saghen.dev/configuration/reference.html#completion-menu
        menu = vim.tbl_deep_extend('force', opts.completion.menu or {}, {
          auto_show = true, -- Show menu automatically

          -- Menu Draw
          -- blink.cmp uses a grid-based layout to render the completion menu.
          -- The components, defined in draw.components[string], define text and highlight functions which are called for each completion item.
          -- https://cmp.saghen.dev/configuration/completion.html#menu-draw
          -- https://cmp.saghen.dev/recipes.html#completion-menu-drawing
          draw = vim.tbl_deep_extend('force', opts.completion.menu.draw or {}, {
            columns = { -- VSCode-like menu layout
              { 'kind_icon', 'kind',              gap = 1 },
              { 'label',     'label_description', gap = 1 },
            },
            -- You may use treesitter to highlight the label text for the given list of sources.
            -- This feature is barebones, as it highlights the item as-is.
            -- https://cmp.saghen.dev/configuration/completion.html#treesitter
            -- treesitter = vim.tbl_deep_extend('force', opts.completion.menu.treesitter or {}, { 'lsp' })
          }),
        }),

        -- Documentation
        -- Show docs automatically when item is selected
        -- https://cmp.saghen.dev/configuration/completion.html#documentation
        -- https://cmp.saghen.dev/configuration/reference.html#completion-documentation
        documentation = vim.tbl_deep_extend('force', opts.completion.documentation or {}, {
          auto_show = true,
          auto_show_delay_ms = 50, -- Quick doc display
        }),

        -- Ghost Text
        -- Ghost text shows a preview of the currently selected item as virtual text inline
        -- https://cmp.saghen.dev/configuration/completion.html#ghost-text
        -- https://cmp.saghen.dev/configuration/reference.html#completion-ghost-text
        ghost_text = vim.tbl_deep_extend('force', opts.completion.ghost_text or {}, {
          enabled = true
        }),
      })

      -- Sources
      -- Modelled after LSPs, for getting completion items, trigger characters, documentation and signature help.
      -- https://lazyvim.org/extras/coding/blink
      -- https://cmp.saghen.dev/configuration/sources.html#providers
      -- https://cmp.saghen.dev/configuration/sources.html#community-sources
      opts.sources = vim.tbl_deep_extend('force', opts.sources or {}, {
        -- DEFAULT SOURCES
        -- https://cmp.saghen.dev/configuration/reference.html#sources
        default = function()
          local filetype = vim.bo.filetype
          if filetype == 'gitcommit' then
            return {
              { name = 'git' },
              { name = 'conventional_commits' },
              { name = 'snippets' },
              { name = 'avante' },
              { name = 'copilot' },
              { name = 'lsp' },
              { name = 'buffer' },
              { name = 'path' }
            }
          end
          return get_default_sources()
        end,

        -- PROVIDERS (`:BlinkCmp statu` shows which sources providers are enabled)
        -- Sources are configured via the sources.providers table, where each id (key) must have a name and module field.
        -- The id (key) may be used in the sources.default/per_filetype, cmdline.sources, and term.sources to enable the source.
        -- https://cmp.saghen.dev/configuration/sources.html#providers
        -- https://cmp.saghen.dev/configuration/reference.html#providers
        -- Community sources: https://cmp.saghen.dev/configuration/sources.html#community-sources
        providers = vim.tbl_deep_extend('force', ((opts.sources or {}).providers or {}) or {}, {
          -- LazyDev source for Neovim config
          -- https://lazyvim.org/extras/coding/blink#blinkcmp-2
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 100, -- show at a higher priority than lsp
          },

          -- Database completion (DadBod)
          -- https://cmp.saghen.dev/configuration/sources.html#providers
          dadbod = { module = 'vim_dadbod_completion.blink' },

          -- Configurable GitHub Copilot blink.cmp source for Neovim
          -- https://github.com/fang2hou/blink-copilot?tab=readme-ov-file#with--lazyvim-copilot-extra
          copilot = {
            name = 'copilot',
            module = 'blink-copilot',
            score_offset = 100,
            async = true,
            opts = {
              max_completions = 3, -- Maximum number of completions to show
              max_attempts = 4,    -- Maximum number of attempts to get completions
              kind_name = 'Copilot', ---@type string | false -- The name of the kind to display
              kind_icon = ' ', ---@type string | false -- The icon to display for the kind
              kind_hl = false, ---@type string | false -- The highlight group to use for the kind
              debounce = 200, ---@type integer | false -- Debounce is a feature that limits the number of requests sent to Copilot. Set it to false to disable it
              -- Automatically refreshes the completion list when the cursor moves
              auto_refresh = {
                backward = true, -- Automatically refresh the completion list when the cursor moves backward
                forward = true,  -- Automatically refresh the completion list when the cursor moves forward
              },
            },
          },

          -- Avante source with custom icons
          -- https://github.com/Kaiser-Yang/blink-cmp-avante?tab=readme-ov-file#lazynvim
          avante = {
            module = 'blink-cmp-avante',
            name = 'Avante',
            enabled = true,
            opts = {
              -- options for blink-cmp-avante
            },
          },

          -- Git source for commit messages and branches
          -- https://github.com/Kaiser-Yang/blink-cmp-git?tab=readme-ov-file#quick-start
          git = {
            module = 'blink-cmp-git',
            name = 'Git',
            enabled = true,
            opts = {
              commit = {
                enable = true,
                triggers = { ':' },
              },
              git_centers = {
                github = {
                  -- Those below have the same fields with `commit`
                  -- Those features will be enabled when `git` and `gh` (or `curl`) are found and
                  -- remote contains `github.com`
                  -- issue = {
                  --     get_token = function() return '' end,
                  -- },
                  -- pull_request = {
                  --     get_token = function() return '' end,
                  -- },
                  -- mention = {
                  --     get_token = function() return '' end,
                  --     get_documentation = function(item)
                  --         local default = require('blink-cmp-git.default.github')
                  --             .mention.get_documentation(item)
                  --         default.get_token = function() return '' end
                  --         return default
                  --     end
                  -- }
                },
                gitlab = {
                  -- Those below have the same fields with `commit`
                  -- Those features will be enabled when `git` and `glab` (or `curl`) are found and
                  -- remote contains `gitlab.com`
                  -- issue = {
                  --     get_token = function() return '' end,
                  -- },
                  -- NOTE:
                  -- Even for `gitlab`, you should use `pull_request` rather than`merge_request`
                  -- pull_request = {
                  --     get_token = function() return '' end,
                  -- },
                  -- mention = {
                  --     get_token = function() return '' end,
                  --     get_documentation = function(item)
                  --         local default = require('blink-cmp-git.default.gitlab')
                  --            .mention.get_documentation(item)
                  --         default.get_token = function() return '' end
                  --         return default
                  --     end
                  -- }
                },
              },
            },
          },

          -- Conventional Commits with gitlint integration and grammar checking
          -- https://github.com/disrupted/blink-cmp-conventional-commits?tab=readme-ov-file#installation
          conventional_commits = {
            name = 'Conventional Commits',
            module = 'blink-cmp-conventional-commits',
            enabled = true,
            opts = {
              -- none so far
            },
          },
        })
      })

      -- Signature
      -- Automatically triggered when typing trigger characters, defined by the LSP, such as ( for lua
      -- You may want to set signature.window.show_documentation = false to only show the signature, and not the documentation.
      -- https://cmp.saghen.dev/configuration/signature.html#signature
      -- https://cmp.saghen.dev/configuration/reference.html#signature
      opts.signature = vim.tbl_deep_extend('force', opts.signature or {}, {
        enabled = true
      })

      -- Snippets
      -- https://cmp.saghen.dev/configuration/snippets.html
      -- https://cmp.saghen.dev/configuration/reference.html#snippets
      -- opts.snippets = vim.tbl_deep_extend('force', opts.snippets or {}, {}),

      return opts
    end,
  },
}
