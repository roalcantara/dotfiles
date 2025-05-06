local paths = require("core/etc/paths")

return {
  -- catppuccin | A theme engine for Neovim | https://github.com/catppuccin/nvim
  -- https://lazyvim.org/plugins/colorscheme#catppuccin
  {
    "catppuccin",
    -- https://lazyvim.org/extras/coding/blink#catppuccin-optional
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts or {}, { integrations = { blink_cmp = true } })
    end,
  },

  -- TREESITTER | A tree-sitter based parser and syntax highlighter for Neovim
  -- https://github.com/nvim-treesitter/nvim-treesitter
  -- https://lazyvim.org/plugins/treesitter#nvim-treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "css",
        "dockerfile",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "ini",
        "make",
        "ruby",
        "scss",
        "xml",
      })
    end,
  },

  -- SNACKS | A modern UI library for Neovim | https://github.com/folke/snacks.nvim
  -- https://lazyvim.org/extras/editor/snacks_picker#snacksnvim-1
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts or {}, {
        -- SCRATCH - Type Neovim Lua code, press esc, and press enter to run the code.
        -- https://github.com/folke/snacks.nvim/blob/main/docs/scratch.md
        -- Snacks.scratch() to toggle Scratch Buffer
        -- Snacks.scratch.list() to list Scratch Buffers
        -- Snacks.scratch.select() to select a scratch buffer from a list of buffers
        scratch = {
          enabled = true,
          ft = function()
            if vim.bo.buftype == "" and vim.bo.filetype ~= "" then
              return vim.bo.filetype
            end
            return "lua"
          end,
          ---@type table<string, snacks.win.Config>
          win_by_ft = {
            lua = {
              keys = {
                ["source"] = {
                  "<cr>",
                  function(self)
                    local name = "scratch." .. vim.fn.fnamemodify(vim.api.nvim_buf_get_name(self.buf), ":e")
                    Snacks.debug.run({ buf = self.buf, name = name })
                  end,
                  desc = "Source buffer",
                  mode = { "n", "x" },
                },
              },
            },
          },
        },

        --- Beautiful declarative dashboards
        --- @see https://github.com/folke/snacks.nvim/blob/main/docs/dashboard.md
        --- @see https://lazyvim.org/extras/ui/dashboard-nvim#snacksnvim
        dashboard = {
          enabled = true,
          open_on_startup = true,
          preset = {
            pick = function(cmd, opt)
              return LazyVim.pick(cmd, opt)()
            end,
            header = require("core/ui/snacks_helper").header(),
            -- stylua: ignore
            ---@type snacks.dashboard.Item[]
            keys = {
              { icon = '󰀶 ', key = 's', desc = 'Smart Find Files', action = ':lua Snacks.picker.smart({})' },
              { icon = ' ', key = 'f', desc = 'Find File', action = ':Files' },
              { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
              { icon = ' ', key = 'g', desc = 'Find Text', action = ':lua Snacks.dashboard.pick("live_grep")' },
              { icon = ' ', key = 'r', desc = 'Recent Files', action = ':lua Snacks.dashboard.pick("oldfiles")' },
              { icon = ' ', key = 'c', desc = 'Config', action = ':lua Snacks.dashboard.pick("files", {cwd = vim.fn.stdpath("config")})' },
              { icon = ' ', key = 'x', desc = 'Lazy Extras', action = ':LazyExtras', enabled = package.loaded.lazy ~= nil },
              { icon = '󰒲 ', key = 'l', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
              { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
            },
          },
          sections = {
            { section = "header" },
            { section = "keys",  gap = 1, padding = 1 },
            {
              pane = 2,
              section = "terminal",
              cmd = "fortune -s | cowsay",
              height = 9,
              random = 10,
              indent = 5,
              padding = 2
            },
            { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
            { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
            {
              pane = 2,
              icon = " ",
              title = "Git Status",
              section = "terminal",
              enabled = function()
                return Snacks.git.get_root() ~= nil
              end,
              cmd = "git status --short --branch --renames",
              height = 5,
              padding = 1,
              ttl = 5 * 60,
              indent = 3,
            },
            { section = "startup" },
          },
        },
      })
    end,
  },

  -- GHOSTTY - A ghostty plugin for Neovim
  -- https://github.com/isak102/ghostty.nvim
  {
    "isak102/ghostty.nvim",
    cond = paths.is_executable("ghostty"),
    opts = {
      -- The autocmd pattern matched against the filename of the buffer. If this pattern
      -- matches, ghostty.nvim will run on save in that buffer. This pattern is passed to
      -- nvim_create_autocmd, check `:h autocmd-pattern` for more information. Can be
      -- either a string or a list of strings
      file_pattern = paths.to_xdg_config_home({ "ghostty", "config" }),
      -- The ghostty executable to run.
      ghostty_cmd = "ghostty",
      -- The timeout in milliseconds for the check command.
      -- If the command takes longer than this it will be killed.
      check_timeout = 1000,
    },
  },

  -- TREE-SITTER-GHOSTTY - A tree-sitter parser for ghostty
  -- https://github.com/bezhermoso/tree-sitter-ghostty
  {
    "bezhermoso/tree-sitter-ghostty",
    build = "make nvim_install",
    cond = paths.is_executable("ghostty"),
  },

  -- SHOWKEYS - Minimal Eye-candy keys screencaster for Neovim 200 ~ LOC | https://github.com/nvzone/showkeys
  -- https://youtu.be/E4qXZv34NQQ?si=612rj4bmIUpgnsDw&t=203
  {
    "nvzone/showkeys",
    cmd = "ShowkeysToggle",
    event = "VeryLazy",
    -- Called during startup, plugins' configurations typically is set in an init function
    init = function()
      vim.cmd("ShowkeysToggle")
    end,
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        winhl = "FloatBorder:Comment,Normal:Normal",
        maxkeys = 3,
        show_count = true,
        keyformat = {
          ["<BS>"] = "󰁮 ",
          ["<C>"] = "⌃",
          ["<CR>"] = "↵",
          ["<D>"] = "⌘",
          ["<Del>"] = "⌦",
          ["<DEL>"] = "⌦",
          ["<Down>"] = "↓",
          ["<End>"] = "⇲",
          ["<END>"] = "⇲",
          ["<Enter>"] = "↵",
          ["<ENTER>"] = "↵",
          ["<Esc>"] = "⎋",
          ["<ESC>"] = "⎋",
          ["<Home>"] = "⇱",
          ["<HOME>"] = "⇱",
          ["<Left>"] = "←",
          ["<M>"] = "⌥",
          ["<Return>"] = "⏎",
          ["<RETURN>"] = "⏎",
          ["<Right>"] = "→",
          ["<S>"] = "⇧",
          ["<Space>"] = "␣",
          ["<SPACE>"] = "␣",
          ["<SPC>"] = "␣",
          ["<Tab>"] = "⇥",
          ["<TAB>"] = "⇥",
          ["<Up>"] = "↑",
          ["<PageUp>"] = "⇞",
          ["<PageDown>"] = "⇟",
        },
      })
    end,
  },

  -- NVIM-COLORIZER - The fastest Neovim colorizer
  -- https://github.com/norcalli/nvim-colorizer.lua
  "norcalli/nvim-colorizer.lua",
}
