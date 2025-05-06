-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
local function create_au(name)
  return vim.api.nvim_create_augroup('lazyvim_custom_' .. name, { clear = true })
end

--- Close with <esc>
local function on_filetype_close_with_esc_autocmd()
  vim.api.nvim_create_autocmd('FileType', {
    group = create_au('close_with_esc'),
    pattern = {
      'aerial',
      'checkhealth',
      'dbout',
      'DressingSelect',
      'floaterm',
      'gitsigns-blame',
      'grug-far',
      'help',
      'Jaq',
      'lazy',
      'lir',
      'lsp-installer',
      'lspinfo',
      'LspsagaCodeAction',
      'LspsagaDiagnostic',
      'LspsagaFinder',
      'LspsagaFloaterm',
      'LspsagaHover',
      'LspsagaRename',
      'LspsagaSignatureHelp',
      'man',
      'neotest-output-panel',
      'neotest-output',
      'neotest-summary',
      'noice',
      'notify',
      'null-ls-info',
      'PlenaryTestPopup',
      'qf',
      'snacks_notif',
      'snacks_notif_history',
      'snacks_notif_log',
      'snacks_win',
      'spectre_panel',
      'startuptime',
      'Trouble',
      'TroubleToggle',
      'tsplayground',
      'markdown',
    },
    callback = function(event)
      vim.bo[event.buf].buflisted = false
      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(event.buf) then
          vim.keymap.set('n', '<esc>', function()
            vim.cmd('close')
            pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
          end, {
            buffer = event.buf,
            silent = true,
            desc = 'Quit buffer with <Esc>',
          })
        end
      end)
    end,
    desc = 'Close buffer with <Esc>',
  })
end

--- YAML files autocmd
local function on_buf_read_detect_yaml_autocmd()
  local group = create_au('filetypedetect')
  vim.api.nvim_create_autocmd('BufRead', {
    group = group,
    pattern = { '*.yml' },
    command = 'set filetype=yaml',
    desc = 'Setup filetype=yaml for files ended with .yml',
  })

  vim.api.nvim_create_autocmd('BufNewFile', {
    group = group,
    pattern = { '*.yml' },
    command = 'set filetype=yaml',
    desc = 'Setup filetype=yaml for files ended with .yml',
  })
end

--- Disable conflicting keymaps reported by :checkhealth
local function on_vim_enter_disable_conflicting_keymaps_autocmd()
  vim.api.nvim_create_autocmd('VimEnter', {
    group = create_au('disable_conflicting_keymaps'),
    callback = function()
      require('core/map/helper').disable_keymaps {
        -- Disable conflicting keymaps from LazyVim/plugins
        { mode = 'n', lhs = '<Esc>' },
        { mode = 's', lhs = '<Esc>' },

        -- Disable gc conflicts
        { mode = 'n', lhs = 'gc' },
        { mode = 'n', lhs = 'gcc' },
        { mode = 'n', lhs = 'gco' },
        { mode = 'n', lhs = 'gcO' },
        { mode = 'n', lhs = 'gcA' },

        -- Disable text-object conflicts
        { mode = 'x', lhs = 'a' },
        { mode = 'x', lhs = 'i' },
        { mode = 'o', lhs = 'a' },
        { mode = 'o', lhs = 'i' },
        { mode = 'x', lhs = 'al' },
        { mode = 'x', lhs = 'ai' },
        { mode = 'x', lhs = 'an' },
        { mode = 'x', lhs = 'il' },
        { mode = 'x', lhs = 'ii' },
        { mode = 'x', lhs = 'in' },
        { mode = 'o', lhs = 'al' },
        { mode = 'o', lhs = 'ai' },
        { mode = 'o', lhs = 'an' },
        { mode = 'o', lhs = 'il' },
        { mode = 'o', lhs = 'ii' },
        { mode = 'o', lhs = 'in' },

        -- Disable gr conflicts
        { mode = 'n', lhs = 'gr' },
        { mode = 'n', lhs = 'gri' },
        { mode = 'n', lhs = 'gra' },
        { mode = 'n', lhs = 'grr' },
        { mode = 'n', lhs = 'grn' },
      }
    end,
    desc = 'Disable conflicting keymaps reported by :checkhealth',
  })
end

--- Setup autocmds
on_vim_enter_disable_conflicting_keymaps_autocmd()
on_filetype_close_with_esc_autocmd()
on_buf_read_detect_yaml_autocmd()
