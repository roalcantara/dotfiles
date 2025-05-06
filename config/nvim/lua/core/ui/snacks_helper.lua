local M = {}

local is_git_repo = function()
  return Snacks.git.get_root() ~= nil
end

local pickers = {
  commands = Snacks.picker.commands,
  explorer = Snacks.picker.explorer,
  recent = Snacks.picker.recent,
  smart = Snacks.picker.smart,
}

--- Snacks picker
--- @param name string Snacks picker action
--- @see https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
--- @return function
local function pick(name)
  return function(opts)
    opts = opts or {}
    if pickers[name] then
      return pickers[name]()
    end

    local picker = Snacks.picker[name]
    if picker then
      return picker(opts)
    end

    return vim.notify("Snacks picker " .. name .. " not found", vim.log.levels.ERROR)
  end
end

--- Snacks pickers
--- @see https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
M.pick = {
  --- Search and pick autocmds
  ---@see https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#autocmds
  autocmds = pick("autocmds"),

  --- Search and pick Neovim buffers
  --- @see https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#buffers
  buffers = pick("buffers"),

  --- Search and pick for Neovim command history
  --- @see https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#command_history
  command_history = pick("command_history"),

  --- Search and pick for Neovim commands
  --- @see https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#commands
  commands = pick("commands"),

  --- Search and pick for Neovim diagnostics
  --- @see https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#diagnostics
  diagnostics = pick("diagnostics"),

  --- Search and pick for Neovim buffer diagnostics
  --- @see https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#diagnostics_buffer
  diagnostics_buffer = pick("diagnostics_buffer"),

  --- Search and pick for Neovim colorschemes with live preview
  --- @see https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#colorschemes
  colorschemes = pick("colorschemes"),

  --- A file explorer for snacks
  --- @ see https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#autocmds
  explorer = pick("explorer"),

  --- Neovim help tags
  --- @see https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#help
  help = pick("help"),

  --- Search and pick for icons
  --- @see https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#icons
  icons = pick("icons"),

  --- Search and pick for a lazy.nvim plugin spec
  --- @see https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#lazy
  lazy = pick("lazy"),

  --- Search lines in the current buffer
  --- @see https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#lines
  find = pick("lines"),

  --- Search and pick for notifications
  --- @see https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#notifications
  notifications = pick("notifications"),

  --- Search and pick for recent
  --- @see https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#recent
  recent = pick("recent"),

  --- Search and pick for
  --- @see http://github.com/folke/snacks.nvim/blob/main/docs/picker.md#lsp_config
  lsp_config = pick("lsp_config"),

  --- Search and pick for lsp_declarations
  --- @see http://github.com/folke/snacks.nvim/blob/main/docs/picker.md#lsp_declarations
  lsp_declarations = pick("lsp_declarations"),

  --- Search and pick for lsp_definitions
  --- @see http://github.com/folke/snacks.nvim/blob/main/docs/picker.md#lsp_definitions
  lsp_definitions = pick("lsp_definitions"),

  --- Search and pick for
  --- @see http://github.com/folke/snacks.nvim/blob/main/docs/picker.md#l
  lsp_implementations = pick("lsp_implementations"),

  --- Search and pick for lsp_references
  --- @see http://github.com/folke/snacks.nvim/blob/main/docs/picker.md#lsp_references
  lsp_references = pick("lsp_references"),

  --- Search and pick for lsp_symbols
  --- @see http://github.com/folke/snacks.nvim/blob/main/docs/picker.md#lsp_symbols
  lsp_symbols = pick("lsp_symbols"),

  --- Search and pick for lsp_type_definitions
  --- @see http://github.com/folke/snacks.nvim/blob/main/docs/picker.md#lsp_type_definitions
  lsp_type_definitions = pick("lsp_type_definitions"),

  --- Search and pick for lsp_workspace_symbols
  --- @see http://github.com/folke/snacks.nvim/blob/main/docs/picker.md#lsp_workspace_symbols
  lsp_workspace_symbols = pick("lsp_workspace_symbols"),

  --- Search smart for files, buffers, lines, etc
  --- @see https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#smart
  smart = pick("smart"),

  --- Search and pick for keymaps
  --- @see https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#keymaps
  keymaps = pick("keymaps"),

  --- Search and pick for files or git_files
  --- @see https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#files
  --- @see https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#git_files
  files = function()
    if is_git_repo() then
      return Snacks.picker.git_files({
        finder = "git_files",
        show_empty = true,
        format = "file",
        untracked = true,
        submodules = false,
      })
    end

    return Snacks.picker.files({
      finder = "files",
      format = "file",
      show_empty = true,
      hidden = true,
      ignored = false,
      follow = false,
      supports_live = true,
    })
  end,

  --- Search and pick for in grep or git_giles
  --- @see https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#lines
  --- @see https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#git_grep
  grep = function()
    if is_git_repo() then
      return Snacks.picker.git_grep({
        finder = "git_grep",
        format = "file",
        untracked = true,
        need_search = true,
        submodules = false,
        show_empty = true,
        supports_live = true,
        live = true,
      })
    end

    return Snacks.picker.grep({
      finder = "grep",
      regex = true,
      format = "file",
      show_empty = true,
      live = true, -- live grep by default
      supports_live = true,
    })
  end,

  --- Search and pick for Neovim filetypes
  filetype = function()
    local filetypes = {}
    for _, path in ipairs(vim.api.nvim_get_runtime_file("ftplugin/*", true)) do
      local ft = vim.fn.fnamemodify(path, ":t:r")
      filetypes[ft] = true
    end

    local sorted_filetypes = vim.tbl_keys(filetypes)
    table.sort(sorted_filetypes)

    Snacks.picker.select(sorted_filetypes, {
      prompt = "Select a filetype",
    }, function(choice)
      local filetype = choice
      if filetype then
        vim.bo.filetype = filetype
        Snacks.notify.info("Filetype set to " .. filetype)
      end
    end)
  end,

  --- Ssearch for Neovim Options
  options = function()
    -- Check if snacks is available
    local has_snacks, snacks = pcall(require, "snacks")
    if not has_snacks then
      vim.notify("Snacks.nvim is not installed", vim.log.levels.ERROR)
      return
    end

    -- Get all options as a structured table
    local all_options = vim.api.nvim_get_all_options_info()
    local items = {}

    -- Convert options to items for picker
    for name, option in pairs(all_options) do
      -- Get current value
      local current_value
      local success, value = pcall(function()
        return vim.api.nvim_get_option_value(name, {})
      end)
      if success then
        if type(value) == "boolean" then
          current_value = value and "true" or "false"
        elseif type(value) == "table" then
          current_value = vim.inspect(value):sub(1, 50) -- Limit length
        else
          current_value = tostring(value)
        end
      else
        current_value = "N/A"
      end

      -- Format display text
      local display_text =
        string.format("%-25s %-10s %-10s %s", name, option.shortname or "", option.type or "", current_value or "")

      table.insert(items, {
        id = name,
        text = display_text,
        data = option,
        value = current_value,
      })
    end

    -- Sort items by option name
    table.sort(items, function(a, b)
      return a.id < b.id
    end)

    -- Use snacks.picker to display options
    snacks.picker({
      title = "Neovim Options",
      items = items,
      format = "text",
      on_choice = function(selection)
        if selection then
          -- Create a detailed view of the option
          local option = selection.data
          local details = {
            "Option: " .. option.name,
            "Short name: " .. (option.shortname or ""),
            "Type: " .. (option.type or ""),
            "Scope: " .. (option.scope or ""),
            "Current value: " .. selection.value,
            "Default value: " .. vim.inspect(option.default),
            "Was set: " .. (option.was_set and "Yes" or "No"),
          }

          -- Show the details
          vim.notify(table.concat(details, "\n"), vim.log.levels.INFO)

          -- Could also show help for the option
          -- vim.cmd("help '" .. option.name .. "'")
        end
      end,
    })
  end,
}

--- Snacks Edit Actions
M.edit = {
  --- Renames the provided file, or the current buffer's file
  --- @see https://github.com/folke/snacks.nvim/blob/main/docs/rename.md#snacksrenamerename_file
  rename_file = function()
    return Snacks.rename.rename_file()
  end,
}

--- Buffers management
--- @see https://github.com/folke/snacks.nvim/blob/main/docs/bufdelete.md
M.buf = {
  --- Delete buffers without disrupting window layout
  --- @param opts? number|snacks.bufdelete.Opts
  --- @return snacks.bufdelete.Opts
  --- @see https://github.com/folke/snacks.nvim/blob/main/docs/bufdelete.md#snacksbufdeletedelete
  close = function(opts)
    return Snacks.bufdelete.delete(opts)
  end,

  --- Delete all buffers except the current one
  --- @param opts? snacks.bufdelete.Opts
  --- @return snacks.bufdelete.Opts
  --- @see https://github.com/folke/snacks.nvim/blob/main/docs/bufdelete.md#snacksbufdeleteother
  close_others = function(opts)
    return Snacks.bufdelete.other(opts)
  end,

  --- Delete all buffers
  --- @param opts? snacks.bufdelete.Opts
  --- @return snacks.bufdelete.Opts
  --- @see https://github.com/folke/snacks.nvim/blob/main/docs/bufdelete.md#snacksbufdeleteall
  close_all = function(opts)
    return Snacks.bufdelete.all(opts)
  end,
}

--- Toggle Snacks Features
--- @return snacks.toggle.Config
--- @see https://github.com/folke/snacks.nvim/blob/main/docs/toggle.md
M.toggle = {
  --- Toggle Efficient animation library including over 45 easing functions
  --- @see https://github.com/folke/snacks.nvim/blob/main/docs/animate.md
  --- @@see https://github.com/folke/snacks.nvim/blob/main/docs/toggle.md#snackstoggleanimate
  animate = function()
    return Snacks.toggle.animate()
  end,

  --- Toggle the current diagnostics
  --- @param opts? snacks.toggle.Config
  --- @return snacks.toggle.Config
  --- @see https://github.com/folke/snacks.nvim/blob/main/docs/toggle.md#snackstogglediagnostics
  diagnostics = function(opts)
    return Snacks.toggle.diagnostics(opts)
  end,

  --- Toggle Zen mode • distraction-free coding. Integrates with Snacks.toggle to toggle various UI elements and with Snacks.dim to dim code out of scope.
  --- @see https://github.com/folke/snacks.nvim/blob/main/docs/zen.md
  zen_mode = function()
    return Snacks.toggle.zen()
  end,

  --- Toggle Profiler - A low overhead Lua profiler for Neovim
  --- @see https://github.com/folke/snacks.nvim/blob/main/docs/toggle.md#snackstoggleprofiler
  profile = function()
    return Snacks.toggle.profiler()
  end,

  --- Toggle dim mode - Focus on the active scope by dimming the rest
  --- @see https://github.com/folke/snacks.nvim/blob/main/docs/toggle.md#snackstoggledim
  dim = function()
    return Snacks.toggle.dim()
  end,

  --- Toggle a terminal window. The terminal id is based on the cmd, cwd, env and vim.v.count1 options.
  --- @see https://github.com/folke/snacks.nvim/blob/main/docs/terminal.md#snacksterminaltoggle
  terminal = function()
    return Snacks.terminal.toggle()
  end,

  --- Toggle Scratch - For testing code, creating notes or just messing around.
  --- @see https://github.com/folke/snacks.nvim/blob/main/docs/scratch.md
  scratch = function()
    return Snacks.scratch.open()
  end,

  --- Toggle Neovim news
  --- @see https://github.com/folke/snacks.nvim/blob/main/docs/win.md#-usage
  news = function()
    return Snacks.win({
      file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
      width = 0.6,
      height = 0.6,
      wo = {
        spell = false,
        wrap = false,
        signcolumn = "yes",
        statuscolumn = " ",
        conceallevel = 3,
      },
    })
  end,
}

--- Custom Header with Neovim and LazyVim versions
--- @return string
M.header = function()
  local nvim = require("core/etc/nvim")

  return [[
      ███╗   ██╗ ██╗   ██╗ ██╗ ███╗   ███╗
      ████╗  ██║ ██║   ██║ ██║ ████╗ ████║
      ██╔██╗ ██║ ██║   ██║ ██║ ██╔████╔██║
      ██║╚██╗██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║
      ██║ ╚████║  ╚████╔╝  ██║ ██║ ╚═╝ ██║
      ╚═╝  ╚═══╝   ╚═══╝   ╚═╝ ╚═╝     ╚═╝
    ]] .. "(v" .. nvim.get_nvim_version() .. " / LazyVim v" .. nvim.get_lazyvim_version() .. ")"
end

return M
