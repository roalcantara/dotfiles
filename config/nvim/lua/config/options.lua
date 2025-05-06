-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local paths = require('core/etc/paths')

-- Set options and variables
--- **SEE:** https://neovim.io/doc/user/options.html
local options = {
  --- Set Buffer-scoped variables (`vim.b:`) for the current buffer. Invalid or unset key returns nil.
  --- Can be indexed with an integer to access variables for a specific buffer.
  --- **SEE:** https://neovim.io/doc/user/lua.html#vim.b
  b = {},
  --- Set Window-scoped variables (`vim.w:`) for the current window. Invalid or unset key returns nil.
  --- Can be indexed with an integer to access variables for a specific window.
  --- **SEE:** https://neovim.io/doc/user/lua.html#vim.w
  w = {},
  --- Set Tabpage-scoped variables (`vim.t:`) for the current tabpage. Invalid or unset key returns nil.
  --- Can be indexed with an integer to access variables for a specific tabpage.
  --- **SEE:** https://neovim.io/doc/user/lua.html#vim.t
  t = {},
  --- Set global editor variables (`vim.g:`). Key with no value returns nil.
  --- **SEE:** https://neovim.io/doc/user/lua.html#vim.g
  g = {},
  --- Set VIM variables (`vim.v:`). Invalid or unset key returns nil.
  --- **SEE:** https://neovim.io/doc/user/lua.html#vim.v
  v = {},
  --- Set options (`:set`). Buffer/window-scoped options target the current buffer/window. Invalid key is an error.
  --- **SEE:** https://neovim.io/doc/user/lua.html#vim.o
  o = {},
  --- Set global and buffer-scoped options for the current tab page (`:set map-options`).
  --- **SEE:** https://neovim.io/doc/user/lua.html#vim.opt
  opt = {},
  --- Set global options (`:setglobal`).
  --- **SEE:** https://neovim.io/doc/user/lua.html#vim.go
  go = {},
  --- Set buffer-scoped options for the buffer with number _{bufnr}_ (`:setlocal`).
  --- If _{bufnr}_ is omitted then the current buffer is used. Invalid _{bufnr}_ or key is an error.
  --- **SEE:** https://neovim.io/doc/user/lua.html#vim.bo
  bo = {},
  --- Set windows-scoped options for the window with handle _{winid}_ and buffer with number _{bufnr}_.
  --- Like `:setlocal` if setting a global-local option or if _{bufnr}_ is provided, like `:set` otherw ise.
  --- **SEE:** https://neovim.io/doc/user/lua.html#vim.wo
  wo = {},
}

-- When running without a GUI
if #vim.api.nvim_list_uis() == 0 then
  options.g = {
    shortmess = '',   -- try to prevent echom from cutting messages off or prompting
    more = false,     -- don't pause listing when screen is filled
    cmdheight = 9999, -- helps avoiding |hit-enter| prompts.
    columns = 9999,   -- set the widest screen possible
    swapfile = false, -- don't use a swap file
  }
else
  options.g = {
    deprecation_warnings = true,               -- enable deprecation warnings
    loaded_perl_provider = 0,                  -- disable perl provider
    cmdwinheight = 7,                          -- [go] Number of lines to use for the command-line window
    suffixes = '.bak,~,.o,.h,.info,.swp,.obj', -- [go] List of file suffixes to add to the 'wildignore' list
  }
  options.o = {
    -- Search and Completion
    hlsearch = true,    -- When there is a previous search pattern, highlight all its matches
    breakindent = true, -- [wo] Every wrapped line will continue visually indented
    timeout = true,     -- [go] This option and 'timeoutlen' determine the behavior when part of a mapped key sequence has been received
    incsearch = true,   -- [go] Highlight match while typing search pattern

    -- Folds
    foldcolumn = '1', -- '0' is not bad
    foldlevel = 99, -- Using ufo provider need a large value, feel free to decrease the value
    foldlevelstart = 99, -- Start unfolded
    foldenable = true, -- Enable folds by default
    fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]], -- Custom fill characters

    -- Editor UI
    background = 'dark',       -- [bo] Set background
    guifont = 'JetBrainsMonoNL Nerd Font:h16',
    laststatus = 0,            -- global statusline
    showtabline = 0,           -- [go] Tells when the tab pages line is displayed => 0: never, 2: always, 1: only if there are at least two tab pages
    cmdheight = 0,             -- [go, t] Number of screen lines to use for the command-line. Helps avoiding hit-enter prompts.
    showcmdloc = 'statusline', -- Show cmd in the statusline (https://github.com/nvim-lualine/lualine.nvim/issues/949)

    -- Line Display
    number = true,      -- [bo] set numbered lines
    numberwidth = 3,    -- [wo] minimal number of columns to use for the line number {default 4}
    colorcolumn = '+1', -- [wo] colour the 81st (or 73rd) column so that we don`t type over our limit
    scrolloff = 8,      -- [go, wo] Minimum nr. of lines above and below cursor

    -- Text Editing
    autoindent = true,     -- [bo] Copy indent from current line when starting a new line
    smarttab = true,       -- [go] Use 'shiftwidth' when inserting <Tab>
    softtabstop = 2,       -- [bo] uses 'shiftwidth' counts for while performing editing operations
    textwidth = 72,        -- [bo] Maximum width of text that is being inserted
    expandtab = true,      -- [bo] Use spaces instead of tabs
    preserveindent = true, -- [bo] Preserve the indent structure of the file

    -- Menus
    pumheight = 25,        -- [bo] Maximum number of entries in a popup
    wildignorecase = true, -- [go] ignored when completing file names and directories
    wildmenu = true,       -- command-line completion operates in an enhanced modes

    -- File Handling
    encoding = 'utf-8',     -- [bo] The encoding used inside the buffer
    fileencoding = 'utf-8', -- [bo] The encoding written to file
    swapfile = false,       -- [bo] Use a swapfile for the buffer.
    modeline = true,        -- [go] Enable modeline
    writebackup = false,    -- [bo] If a file is being edited by another program (or was written to a file) while you are editing it, it is still being saved and will be updated when you are done
    autoread = true,        -- [bo] If a file is changed outside of Neovim and you haven't changed it, automatically read it again.

    -- Mouse | https://neovim.io/doc/user/options.html#'mousem'
    mousemodel = 'extend', -- Enables all mouse features including: 1. Right click opens a menu, 2. Shift + left click extends selection, 3. Right drag extends selection
  }
  options.opt = {
    wildignore = { -- [go] Allow specified keys to cross line boundaries
      '*.hg',
      '*.svn',
      '*.aux',
      '*.out',
      '*.toc',
      '*.o',
      '*.obj',
      '*.dll',
      '*.jar',
      '*.pyc',
      '*.rbc',
      '*.class',
      '*.gif',
      '*.ico',
      '*.jpg',
      '*.jpeg',
      '*.png',
      '*.avi',
      '*.wav',
      '*.webm',
      '*.eot',
      '*.otf',
      '*.ttf',
      '*.woff',
      '*.doc',
      '*.pdf',
      '*.tar.gz',
      '*.tar.bz2',
      '*.rar',
      '*.tar.xz',
      '.sass-cache',
      '*/vendor/gems/*',
      '*/vendor/cache/*',
      '*/.bundle/*',
      '*.gem',
      '*.*~',
      '*~ ',
      '*.swp',
      '.lock',
      '*.DS_Stoe',
      '._*',
      'tags.lock',
      '**/node_modules/**',
      '**/bower_modules/**',
    },
    -- save/restore just these (with `:{mk,load}view`)
    viewoptions = {
      'cursor',
      'folds',
    },
    -- A list of file patterns that specify files to be skipped
    backupskip = {
      '/tmp/*',         -- skip all files in /tmp
      '/private/tmp/*', -- skip all files in /private/tmp
    },
    -- Influences the working of <BS>, <Del>, CTRL-W and CTRL-U in Insert mode.
    backspace = {
      'start',  -- allow backspacing over the start of insert; CTRL-W and CTRL-U
      'eol',    -- allow backspacing over line breaks (join lines)
      'indent', -- allow backspacing over autoindent
      -- 'stop'                     -- once at the start of insert
      -- 'nostop'                   -- like start, except CTRL-W and CTRL-U do not stop at the start of insert
    },
    -- termguicolors
    -- https://neovim.io/doc/user/options.html#'termguicolors'
    termguicolors = true,

    -- AVANTE.NVIM: Views can only be fully collapsed with the global statusline
    -- https://github.com/yetone/avante.nvim?tab=readme-ov-file#installation
    -- laststatus = 3, -- global statusline
  }
  options.go = {
    emoji = true,                  -- [go] When on all Unicode emoji characters are considered to be full width
    equalalways = false,           -- [go] Windows are automatically made the same size
    switchbuf = 'useopen,uselast', -- [go] Sets behavior when switching to another buffer
    whichwrap = 'h,l,<,>,[,],~',   -- [go] Allow specified keys to cross line boundaries
    wildignorecase = true,         -- [go] Ignore case when completing file names
    wrapscan = true,               -- [go] Searches wrap around the end of the file
  }
end

for ctx, values in pairs(options) do
  for option, value in pairs(values) do
    if value then
      if type(value) == 'function' then
        value(vim[ctx][option])
      else
        vim[ctx][option] = value
      end
    end
  end
end

vim.scriptencoding = 'utf-8' -- set script encoding

-- Add custom runtime path (usually ~/.config/nvim) if it's not already there
local config_path = paths.to_config()
if not vim.tbl_contains(vim.opt.runtimepath:get(), config_path) then
  vim.opt.runtimepath:append(config_path)
end

-- vim: ts=2 sts=2 sw=2 et
