-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local h = require('core/map/helper').helpers
local map = require('core/map/helper').map
local cmd_and_map = require('core/map/helper').cmd_and_map

-- User Commands
require('config/commands')

-- DEBUG
cmd_and_map('Scratch', h.toggle.scratch, 'n', '<D-S-s>', '[⌘ ⇧ s] Open Scratch Buffer')
cmd_and_map('Notifications', h.pick.notifications, 'n', '<D-S-n>', '[⌘ ⇧ n] Notifications')

-- NAVIGATION
cmd_and_map('GoToBOL', h.go_to.BoL, 'n', '<D-Left>', '[⌘ ←]  Move Cursor to BOL')
cmd_and_map('GoToEOL', h.go_to.EoL, 'n', '<D-Right>', '[⌘ →] Move Cursor to EOL')
cmd_and_map('GoToBOF', h.go_to.BoF, 'n', '<D-Up>', '[⌘ ↑] Move Cursor to BOF')
cmd_and_map('GoToEOF', h.go_to.EoF, 'n', '<D-Down>', '[⌘ ↓]  Move Cursor to EOF')
cmd_and_map('BufferPrev', h.go_to.buf.prev, 'n', '<D-M-Left>', '[⌥ ⌘ ←] Prev Buffer')
cmd_and_map('BufferNext', h.go_to.buf.next, 'n', '<D-M-Right>', '[⌥ ⌘ →] Next Buffer')
map('n', '<D-Up>', 'gg', '[⌘ ↑] Move Cursor to BOF')
map('v', '<D-Up>', 'gg', '[⌘ ↑] Move Cursor to BOF')
map('i', '<D-Up>', '<Esc>ggi', '[⌘ ↑] Move Cursor to BOF')

-- EDIT
map('n', '<D-s>', ':w<CR>', '[⌘ s] Save File')
map('i', '<D-s>', '<C-o>:w<CR>', '[⌘ s] Save File')
map('v', '<D-s>', '<Esc>:w<CR>gv', '[⌘ s] Save File')
map('n', '<D-q>', ':q<CR>', '[⌘ q] Quit')
map('i', '<D-q>', '<C-o>:q<CR>', '[⌘ q] Quit')
map('v', '<D-q>', '<Esc>:q<CR>', '[⌘ q] Quit')
map('n', '<D-M-q>', ':q!<CR>', '[⌘ q] Quit (force!)')
map('i', '<D-M-q>', '<C-o>:q!<CR>', '[⌘ q] Quit (force!)')
map('v', '<D-M-q>', '<Esc>:q!<CR>', '[⌘ q] Quit (force!)')

-- MOVE LINES
map('n', '<M-Down>', '<cmd>execute \'move .+\' . v:count1<cr>==', 'Move Down')
map('n', '<M-Up>', '<cmd>execute \'move .-\' . (v:count1 + 1)<cr>==', 'Move Up')
map('i', '<M-Down>', '<esc><cmd>m .+1<cr>==gi', 'Move Down')
map('i', '<M-Up>', '<esc><cmd>m .-2<cr>==gi', 'Move Up')
map('v', '<M-Down>', ':<C-u>execute "\'<,\'>move \'>+" . v:count1<cr>gv=gv', 'Move Down')
map('v', '<M-Up>', ':<C-u>execute "\'<,\'>move \'<-" . (v:count1 + 1)<cr>gv=gv', 'Move Up')

-- CREATE MULTILINE CURSOR WITH SHIFT + ARROW KEYS
map('n', '<S-Up>', '<Plug>(VM-Add-Cursor-Up)', 'Add Cursor Up')
map('n', '<S-Down>', '<Plug>(VM-Add-Cursor-Down)', 'Add Cursor Down')
map('n', '<S-Left>', '<Plug>(VM-Add-Cursor-Left)', 'Add Cursor Left')
map('n', '<S-Right>', '<Plug>(VM-Add-Cursor-Right)', 'Add Cursor Right')

-- SHIFT + ARROW KEYS to SELECT 1 LINE
map('n', '<S-Down>', '<C-V>1j', 'Select 1 line Down')
map('x', '<S-Down>', '1j', 'Select 1 line Down')
map('n', '<S-Up>', '<C-V>1k', 'Select 1 line Up')
map('x', '<S-Up>', '1k', 'Select 1 line Up')
map('v', '<S-Down>', '<esc><C-V>1j', 'Select 1 line Down')
map('v', '<S-Up>', '<esc><C-V>1k', 'Select 1 line Up')

-- ALT + SHIFT + ARROW KEYS to SELECT until the end of the next word
map('n', '<A-S-Down>', '<cmd>execute "normal! e"<cr>', 'Select until the end of the next word')
map('n', '<A-S-Up>', '<cmd>execute "normal! b"<cr>', 'Select until the end of the previous word')
map('v', '<A-S-Down>', '<cmd>execute "normal! e"<cr>', 'Select until the end of the next word')
map('v', '<A-S-Up>', '<cmd>execute "normal! b"<cr>', 'Select until the end of the previous word')

-- CMD + SHIFT + ARROW KEYS to SELECT WHOLE LINE
map('n', '<D-S-Down>', '<cmd>execute "normal! gj"<cr>', 'Select Whole Line Down')
map('n', '<D-S-Up>', '<cmd>execute "normal! gk"<cr>', 'Select Whole Line Up')
map('v', '<D-S-Down>', '<cmd>execute "normal! gj"<cr>', 'Select Whole Line Down')
map('v', '<D-S-Up>', '<cmd>execute "normal! gk"<cr>', 'Select Whole Line Up')

cmd_and_map('Close', h.buf.close, 'n', '<D-w>', '[⌘ w] Close Current Editor')
cmd_and_map('Cut', h.edit.cut, 'n', '<D-x>', '[⌘ x] Cut selection to clipboard')
cmd_and_map('Copy', h.edit.copy, 'n', '<D-c>', '[⌘ c] Copy selection to clipboard')
cmd_and_map('Paste', h.edit.paste, 'n', '<D-v>', '[⌘ v] Paste selection to clipboard')
cmd_and_map('Undo', h.edit.undo, 'n', '<D-z>', '[⌘ z] Undo')
cmd_and_map('SelectAll', h.edit.select_all, 'n', '<D-a>', '[⌘ a] Select all')
cmd_and_map('Redo', h.edit.redo, 'n', '<D-y>', '[⌘ y] Redo')
cmd_and_map('New', h.edit.new, 'n', '<D-n>', '[⌘ n] New File')
cmd_and_map('ReplaceAll', h.edit.replace_all, 'n', '<D-g>', '[⌘ g] Replace all occurrences of selection')
cmd_and_map('RenameFile', h.edit.undo, 'n', '<D-\\>', '[⌘ \\] Toggle Sidebar Left')

-- SEARCH and PICKERS
cmd_and_map('Grep', h.pick.grep, 'n', '<D-F>', '[⌘ F] Find in Project Files')
cmd_and_map('Find', h.pick.find, 'n', '<D-f>', '[⌘ f] Find in Current File')
cmd_and_map('Files', h.pick.files, 'n', '<D-p>', '[⌘ p] Search files by name')
cmd_and_map('Smart', h.pick.smart, 'n', '<D-M-p>', '[⌘ ⌥ p] Smart Find Files')
cmd_and_map('Commands', h.pick.commands, 'n', '<D-S-p>', '[⌘ ⇧ P] Command Palette')
cmd_and_map('Maps', h.pick.keymaps, 'n', '<D-M-m>', '[⌘ ⌥ m] Toggle Keymaps')
cmd_and_map('Help', h.pick.help, 'n', '<D-;>', '[⌘ ;] Toggle Help')
cmd_and_map('Menus', h.toggle.menus, 'n', '<D-m>', '[⌘ m] Toggle Menus')
cmd_and_map('Ftypes', h.pick.filetype, 'n', '<D-l>', '[⌘ l] Pick FileTypes')
cmd_and_map('News', h.toggle.news, 'n', '<D-M-n>', '[⌘ ⌥ n] Neovim News')

-- UI
map('n', '<D-[>', 'zc', '[⌘ [ ] Fold Region')
map('n', '<D-]>', 'zo', '[⌘ [ ] Unfold Region')
map('n', '<D-S-[>', 'zM', '[⌘ ⇧ [ ] Fold All Region')
map('n', '<D-S-]>', 'zR', '[⌘ ⇧ ] ] Unfold All Region')

-- INDENTING
-- VISUAL MODE: indent with Tab and Shift+Tab
map('v', '<Tab>', '>gv', 'Indent Right')
map('v', '<S-Tab>', '<gv', 'Indent Left')
-- NORMAL MODE: indent current line with Tab and Shift+Tab
map('n', '<Tab>', '>>', 'Indent Line Right')
map('n', '<S-Tab>', '<<', 'Indent Line Left')
-- INSERT MODE: indent in insert mode
-- map('i', '<Tab>', h.edit.indent, 'Indent Line Right or Insert Spaces', { expr = true })
-- map('i', '<S-Tab>', '<Esc><<i', 'Indent Line Left')

-- COMMENTING
map('n', '<Esc>/', '<Plug>(comment_toggle_linewise_current)', 'Add Comment Above')
map('v', '<Esc>/', '<Plug>(comment_toggle_linewise_visual)', 'Add Comment Above')

-- DIAGNOSTICS
cmd_and_map('Diagnostics', h.toggle.diagnostics, 'n', '<D-d>', '[⌘ ^ d] Toggle Diagnostics')
cmd_and_map(
  'DiagnosticsWorkspace',
  h.toggle.diagnostics_in_wks,
  'n',
  '<D-C-S-D>',
  '[⌘ ^ ⇧ D] Toggle Diagnostics in Wks'
)
cmd_and_map('ToggleZenMode', h.toggle.zen_mode, 'n', '<D-C-z>', '[⌘ ⌃ z] Toggle Zen Mode')
cmd_and_map('ToggleSideBarLeft', h.toggle.sidebar_left, 'n', '<D-\\>', '[⌘ \\] Toggle SideBar left (Explorer)')

-- LSP
map('n', '<D-M-f>', h.lsp.format, '[⌘ ⌃ f] Format Document')
-- map('n', '<D-S-Space>', h.lsp.signature_help, '[⌘ ⇧ ␣] Toggle Hover Documentation')
map('n', '<D-M-Enter>', h.lsp.rename, '[⌘ ⌥ ↵] Rename symbol (calls <Space>cr)')
cmd_and_map('LspDefinitions', h.lsp.definitions, 'n', '<D-i>', '[⌘ i] Go to Definitions')
cmd_and_map('LspDeclarations', h.lsp.declarations, 'n', '<D-M-d>', '[⌘ ⌥ D] Go to Declaration')
cmd_and_map('LspImplementations', h.lsp.implementations, 'n', '<D-M-i>', '[⌘ ⌥ i] Go to Implementation')
cmd_and_map('LspTypeDefinitions', h.lsp.type_definitions, 'n', '<D-M-t>', '[⌘ ⌥ t] Go to Type Definition')
cmd_and_map('LspReferences', h.lsp.references, 'n', '<D-M-r>', '[⌘ ⌥ r] Find All References')
cmd_and_map('LspToggleCodeActions', h.lsp.code_actions, 'n', '<D-.>', '[⌘ .] Toggle Code Actions')
cmd_and_map('LspSymbols', h.lsp.syms, 'n', '<D-t>', '[⌘ t] Symbols in File')
cmd_and_map('LspSymbolsWks', h.lsp.syms_in_wks, 'n', '<D-M-w>', '[⌘ ⌥ w] Symbols in Workspace')
