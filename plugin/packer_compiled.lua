-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "C:\\Users\\SB00A~1.SCH\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\share\\lua\\5.1\\?.lua;C:\\Users\\SB00A~1.SCH\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\share\\lua\\5.1\\?\\init.lua;C:\\Users\\SB00A~1.SCH\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\luarocks\\rocks-5.1\\?.lua;C:\\Users\\SB00A~1.SCH\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\luarocks\\rocks-5.1\\?\\init.lua"
local install_cpath_pattern = "C:\\Users\\SB00A~1.SCH\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\lua\\5.1\\?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0" },
    loaded = true,
    path = "C:\\Users\\s.schubert\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    loaded = true,
    path = "C:\\Users\\s.schubert\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "C:\\Users\\s.schubert\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "C:\\Users\\s.schubert\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  cmp_luasnip = {
    loaded = true,
    path = "C:\\Users\\s.schubert\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["lazygit.nvim"] = {
    loaded = true,
    path = "C:\\Users\\s.schubert\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\lazygit.nvim",
    url = "https://github.com/kdheepak/lazygit.nvim"
  },
  ["lspkind.nvim"] = {
    loaded = true,
    path = "C:\\Users\\s.schubert\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\lspkind.nvim",
    url = "https://github.com/onsails/lspkind.nvim"
  },
  ["lua-dev.nvim"] = {
    loaded = true,
    path = "C:\\Users\\s.schubert\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\lua-dev.nvim",
    url = "https://github.com/folke/lua-dev.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n`\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\foptions\1\0\0\1\0\1\ntheme\15catppuccin\nsetup\flualine\frequire\0" },
    loaded = true,
    path = "C:\\Users\\s.schubert\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["mason-lspconfig"] = {
    loaded = true,
    path = "C:\\Users\\s.schubert\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\mason-lspconfig",
    url = "https://github.com/williamboman/mason-lspconfig"
  },
  ["mason.nvim"] = {
    loaded = true,
    path = "C:\\Users\\s.schubert\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["null-ls.nvim"] = {
    config = { "\27LJ\2\nﬂ\1\0\0\a\0\f\0\0306\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\n\0004\3\4\0006\4\0\0'\6\1\0B\4\2\0029\4\3\0049\4\4\0049\4\5\4>\4\1\0036\4\0\0'\6\1\0B\4\2\0029\4\3\0049\4\6\0049\4\a\4>\4\2\0036\4\0\0'\6\1\0B\4\2\0029\4\3\0049\4\b\0049\4\t\4>\4\3\3=\3\v\2B\0\2\1K\0\1\0\fsources\1\0\0\nspell\15completion\veslint\16diagnostics\vstylua\15formatting\rbuiltins\nsetup\fnull-ls\frequire\0" },
    loaded = true,
    path = "C:\\Users\\s.schubert\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  nvim = {
    config = { "\27LJ\2\nö\3\0\0\a\0\24\0\0316\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\22\0005\3\3\0005\4\4\0005\5\6\0005\6\5\0=\6\a\0055\6\b\0=\6\t\0055\6\n\0=\6\v\0055\6\f\0=\6\r\5=\5\14\0045\5\16\0005\6\15\0=\6\a\0055\6\17\0=\6\t\0055\6\18\0=\6\v\0055\6\19\0=\6\r\5=\5\20\4=\4\21\3=\3\23\2B\0\2\1K\0\1\0\17integrations\1\0\0\15native_lsp\15underlines\1\2\0\0\14underline\1\2\0\0\14underline\1\2\0\0\14underline\1\0\0\1\2\0\0\14underline\17virtual_text\16information\1\2\0\0\vitalic\rwarnings\1\2\0\0\vitalic\nhints\1\2\0\0\vitalic\verrors\1\0\0\1\2\0\0\vitalic\1\0\1\fenabled\2\1\0\4\15treesitter\2\bcmp\2\23treesitter_context\2\14telescope\2\nsetup\15catppuccin\frequire\0" },
    loaded = true,
    path = "C:\\Users\\s.schubert\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim",
    url = "https://github.com/catppuccin/nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\n@\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\19nvim-autopairs\frequire\0" },
    loaded = true,
    path = "C:\\Users\\s.schubert\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "C:\\Users\\s.schubert\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\nì\1\0\0\4\0\5\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0B\0\3\1K\0\1\0\1\0\a\vrgb_fn\2\rRRGGBBAA\2\vRRGGBB\2\bRGB\2\bcss\2\vcss_fn\2\vhsl_fn\2\1\5\0\0\bcss\tscss\thtml\15javascript\nsetup\14colorizer\frequire\0" },
    loaded = true,
    path = "C:\\Users\\s.schubert\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-dap"] = {
    config = { "\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = true,
    path = "C:\\Users\\s.schubert\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-dap-ui"] = {
    loaded = true,
    path = "C:\\Users\\s.schubert\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-dap-ui",
    url = "https://github.com/rcarriga/nvim-dap-ui"
  },
  ["nvim-dap-virtual-text"] = {
    loaded = true,
    path = "C:\\Users\\s.schubert\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-dap-virtual-text",
    url = "https://github.com/theHamsta/nvim-dap-virtual-text"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "C:\\Users\\s.schubert\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "C:\\Users\\s.schubert\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-context"] = {
    config = { "\27LJ\2\ne\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\3\venable\2\14max_lines\3\0\rthrottle\2\nsetup\23treesitter-context\frequire\0" },
    loaded = true,
    path = "C:\\Users\\s.schubert\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-treesitter-context",
    url = "https://github.com/romgrk/nvim-treesitter-context"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "C:\\Users\\s.schubert\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "C:\\Users\\s.schubert\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "C:\\Users\\s.schubert\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "C:\\Users\\s.schubert\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "C:\\Users\\s.schubert\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["rust-tools.nvim"] = {
    config = { "\27LJ\2\n+\0\0\3\1\1\0\6-\0\0\0009\0\0\0009\0\0\0+\2\1\0B\0\2\1K\0\1\0\1\0\14move_item+\0\0\3\1\1\0\6-\0\0\0009\0\0\0009\0\0\0+\2\2\0B\0\2\1K\0\1\0\1\0\14move_item‡\2\1\2\a\2\19\0,6\2\0\0'\4\1\0B\2\2\0029\2\2\2\18\4\0\0\18\5\1\0B\2\3\1-\2\0\0'\4\3\0-\5\1\0009\5\4\0059\5\4\0055\6\5\0=\1\6\6B\2\4\1-\2\0\0'\4\a\0-\5\1\0009\5\b\0059\5\b\0055\6\t\0=\1\6\6B\2\4\1-\2\0\0'\4\n\0-\5\1\0009\5\v\0059\5\v\0055\6\f\0=\1\6\6B\2\4\1-\2\0\0'\4\r\0003\5\14\0005\6\15\0=\1\6\6B\2\4\1-\2\0\0'\4\16\0003\5\17\0005\6\18\0=\1\6\6B\2\4\1K\0\1\0\2¿\0¿\1\0\0\0\16<C-Shift-p>\1\0\0\0\16<C-Shift-n>\1\0\0\14runnables\16<leader>crr\1\0\0\22code_action_group\16<leader>cra\vbuffer\1\0\0\18hover_actions\14<C-space>\26on_attach_keybindings\15core.mason\frequireç\1\1\0\b\0\n\0\0166\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\2\3\0019\3\4\0005\5\b\0005\6\6\0003\a\5\0=\a\a\6=\6\t\5B\3\2\0012\0\0ÄK\0\1\0\vserver\1\0\0\14on_attach\1\0\0\0\nsetup\rnnoremap\16core.keymap\15rust-tools\frequire\0" },
    loaded = true,
    path = "C:\\Users\\s.schubert\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\rust-tools.nvim",
    url = "https://github.com/simrat39/rust-tools.nvim"
  },
  ["telescope-ui-select.nvim"] = {
    loaded = true,
    path = "C:\\Users\\s.schubert\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\telescope-ui-select.nvim",
    url = "https://github.com/nvim-telescope/telescope-ui-select.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\nD\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\27core.plugins.telescope\frequire\0" },
    loaded = true,
    path = "C:\\Users\\s.schubert\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["todo-comments.nvim"] = {
    config = { "\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18todo-comments\frequire\0" },
    loaded = true,
    path = "C:\\Users\\s.schubert\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\todo-comments.nvim",
    url = "https://github.com/folke/todo-comments.nvim"
  },
  ["toggleterm.nvim"] = {
    config = { "\27LJ\2\nœ\1\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\vwinbar\1\0\1\fenabled\2\15float_opts\1\0\1\vborder\vcurved\1\0\5\22terminal_mappings\2\20insert_mappings\2\20start_in_insert\1\17persist_mode\2\17persist_size\2\nsetup\15toggleterm\frequire\0" },
    loaded = true,
    path = "C:\\Users\\s.schubert\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\toggleterm.nvim",
    url = "https://github.com/akinsho/toggleterm.nvim"
  },
  undotree = {
    loaded = true,
    path = "C:\\Users\\s.schubert\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\undotree",
    url = "https://github.com/mbbill/undotree"
  },
  ["vim-fugitive"] = {
    commands = { "G" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "C:\\Users\\s.schubert\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-illuminate"] = {
    loaded = true,
    path = "C:\\Users\\s.schubert\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-illuminate",
    url = "https://github.com/RRethy/vim-illuminate"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "C:\\Users\\s.schubert\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-surround",
    url = "https://github.com/tpope/vim-surround"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-treesitter-context
time([[Config for nvim-treesitter-context]], true)
try_loadstring("\27LJ\2\ne\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\3\venable\2\14max_lines\3\0\rthrottle\2\nsetup\23treesitter-context\frequire\0", "config", "nvim-treesitter-context")
time([[Config for nvim-treesitter-context]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\nD\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\27core.plugins.telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
try_loadstring("\27LJ\2\nì\1\0\0\4\0\5\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0B\0\3\1K\0\1\0\1\0\a\vrgb_fn\2\rRRGGBBAA\2\vRRGGBB\2\bRGB\2\bcss\2\vcss_fn\2\vhsl_fn\2\1\5\0\0\bcss\tscss\thtml\15javascript\nsetup\14colorizer\frequire\0", "config", "nvim-colorizer.lua")
time([[Config for nvim-colorizer.lua]], false)
-- Config for: todo-comments.nvim
time([[Config for todo-comments.nvim]], true)
try_loadstring("\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18todo-comments\frequire\0", "config", "todo-comments.nvim")
time([[Config for todo-comments.nvim]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\n`\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\foptions\1\0\0\1\0\1\ntheme\15catppuccin\nsetup\flualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: nvim-dap
time([[Config for nvim-dap]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "config", "nvim-dap")
time([[Config for nvim-dap]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
try_loadstring("\27LJ\2\n@\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\19nvim-autopairs\frequire\0", "config", "nvim-autopairs")
time([[Config for nvim-autopairs]], false)
-- Config for: null-ls.nvim
time([[Config for null-ls.nvim]], true)
try_loadstring("\27LJ\2\nﬂ\1\0\0\a\0\f\0\0306\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\n\0004\3\4\0006\4\0\0'\6\1\0B\4\2\0029\4\3\0049\4\4\0049\4\5\4>\4\1\0036\4\0\0'\6\1\0B\4\2\0029\4\3\0049\4\6\0049\4\a\4>\4\2\0036\4\0\0'\6\1\0B\4\2\0029\4\3\0049\4\b\0049\4\t\4>\4\3\3=\3\v\2B\0\2\1K\0\1\0\fsources\1\0\0\nspell\15completion\veslint\16diagnostics\vstylua\15formatting\rbuiltins\nsetup\fnull-ls\frequire\0", "config", "null-ls.nvim")
time([[Config for null-ls.nvim]], false)
-- Config for: rust-tools.nvim
time([[Config for rust-tools.nvim]], true)
try_loadstring("\27LJ\2\n+\0\0\3\1\1\0\6-\0\0\0009\0\0\0009\0\0\0+\2\1\0B\0\2\1K\0\1\0\1\0\14move_item+\0\0\3\1\1\0\6-\0\0\0009\0\0\0009\0\0\0+\2\2\0B\0\2\1K\0\1\0\1\0\14move_item‡\2\1\2\a\2\19\0,6\2\0\0'\4\1\0B\2\2\0029\2\2\2\18\4\0\0\18\5\1\0B\2\3\1-\2\0\0'\4\3\0-\5\1\0009\5\4\0059\5\4\0055\6\5\0=\1\6\6B\2\4\1-\2\0\0'\4\a\0-\5\1\0009\5\b\0059\5\b\0055\6\t\0=\1\6\6B\2\4\1-\2\0\0'\4\n\0-\5\1\0009\5\v\0059\5\v\0055\6\f\0=\1\6\6B\2\4\1-\2\0\0'\4\r\0003\5\14\0005\6\15\0=\1\6\6B\2\4\1-\2\0\0'\4\16\0003\5\17\0005\6\18\0=\1\6\6B\2\4\1K\0\1\0\2¿\0¿\1\0\0\0\16<C-Shift-p>\1\0\0\0\16<C-Shift-n>\1\0\0\14runnables\16<leader>crr\1\0\0\22code_action_group\16<leader>cra\vbuffer\1\0\0\18hover_actions\14<C-space>\26on_attach_keybindings\15core.mason\frequireç\1\1\0\b\0\n\0\0166\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\2\3\0019\3\4\0005\5\b\0005\6\6\0003\a\5\0=\a\a\6=\6\t\5B\3\2\0012\0\0ÄK\0\1\0\vserver\1\0\0\14on_attach\1\0\0\0\nsetup\rnnoremap\16core.keymap\15rust-tools\frequire\0", "config", "rust-tools.nvim")
time([[Config for rust-tools.nvim]], false)
-- Config for: toggleterm.nvim
time([[Config for toggleterm.nvim]], true)
try_loadstring("\27LJ\2\nœ\1\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\vwinbar\1\0\1\fenabled\2\15float_opts\1\0\1\vborder\vcurved\1\0\5\22terminal_mappings\2\20insert_mappings\2\20start_in_insert\1\17persist_mode\2\17persist_size\2\nsetup\15toggleterm\frequire\0", "config", "toggleterm.nvim")
time([[Config for toggleterm.nvim]], false)
-- Config for: nvim
time([[Config for nvim]], true)
try_loadstring("\27LJ\2\nö\3\0\0\a\0\24\0\0316\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\22\0005\3\3\0005\4\4\0005\5\6\0005\6\5\0=\6\a\0055\6\b\0=\6\t\0055\6\n\0=\6\v\0055\6\f\0=\6\r\5=\5\14\0045\5\16\0005\6\15\0=\6\a\0055\6\17\0=\6\t\0055\6\18\0=\6\v\0055\6\19\0=\6\r\5=\5\20\4=\4\21\3=\3\23\2B\0\2\1K\0\1\0\17integrations\1\0\0\15native_lsp\15underlines\1\2\0\0\14underline\1\2\0\0\14underline\1\2\0\0\14underline\1\0\0\1\2\0\0\14underline\17virtual_text\16information\1\2\0\0\vitalic\rwarnings\1\2\0\0\vitalic\nhints\1\2\0\0\vitalic\verrors\1\0\0\1\2\0\0\vitalic\1\0\1\fenabled\2\1\0\4\15treesitter\2\bcmp\2\23treesitter_context\2\14telescope\2\nsetup\15catppuccin\frequire\0", "config", "nvim")
time([[Config for nvim]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file G lua require("packer.load")({'vim-fugitive'}, { cmd = "G", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)


_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
