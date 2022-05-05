-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

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

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/pedro/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/pedro/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/pedro/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/pedro/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/pedro/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
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
    config = { "\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25user.plugins.comment\frequire\0" },
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  ["FixCursorHold.nvim"] = {
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/FixCursorHold.nvim",
    url = "https://github.com/antoinemadec/FixCursorHold.nvim"
  },
  LuaSnip = {
    config = { "\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25user.plugins.luasnip\frequire\0" },
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["better-escape.nvim"] = {
    config = { "\27LJ\2\n_\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\fmapping\1\0\0\1\4\0\0\ajk\ajj\akj\nsetup\18better_escape\frequire\0" },
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/better-escape.nvim",
    url = "https://github.com/max397574/better-escape.nvim"
  },
  ["bufferhandler.nvim"] = {
    config = { "\27LJ\2\n\22\0\1\2\0\1\0\0029\1\0\0L\1\2\0\vnumberP\1\0\4\0\6\0\b6\0\0\0009\0\1\0003\2\2\0006\3\3\0009\3\4\0039\3\5\0032\0\0€D\0\3\0\20visible_buffers\rcokeline\a_G\0\ftbl_map\bvime\1\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0003\4\3\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\vsource\1\0\0\fbuffers\1\0\0\0\nsetup\18bufferhandler\frequire\0" },
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/bufferhandler.nvim",
    url = "/home/pedro/Desktop/Plugins/bufferhandler.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-conventionalcommits"] = {
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/cmp-conventionalcommits",
    url = "https://github.com/davidsierradz/cmp-conventionalcommits"
  },
  ["cmp-emoji"] = {
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/cmp-emoji",
    url = "https://github.com/hrsh7th/cmp-emoji"
  },
  ["cmp-git"] = {
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/cmp-git",
    url = "https://github.com/petertriho/cmp-git"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-pandoc.nvim"] = {
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/cmp-pandoc.nvim",
    url = "/home/pedro/Desktop/Plugins/cmp-pandoc.nvim"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["detect-indent.nvim"] = {
    config = { "\27LJ\2\n;\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\18detect-indent\frequire\0" },
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/detect-indent.nvim",
    url = "/home/pedro/Desktop/Plugins/detect-indent.nvim"
  },
  ["diffview.nvim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\26user.plugins.diffview\frequire\0" },
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/diffview.nvim",
    url = "https://github.com/sindrets/diffview.nvim"
  },
  ["fidget.nvim"] = {
    config = { "\27LJ\2\n4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\vfidget\frequire\0" },
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/fidget.nvim",
    url = "https://github.com/j-hui/fidget.nvim"
  },
  ["formatter.nvim"] = {
    config = { "\27LJ\2\n6\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27user.plugins.formatter\frequire\0" },
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/formatter.nvim",
    url = "https://github.com/mhartington/formatter.nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["git-conflict.nvim"] = {
    config = { "\27LJ\2\nS\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\21default_mappings\1\nsetup\17git-conflict\frequire\0" },
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/git-conflict.nvim",
    url = "https://github.com/akinsho/git-conflict.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\26user.plugins.gitsings\frequire\0" },
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["gitui.nvim"] = {
    config = { "\27LJ\2\n3\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\ngitui\frequire\0" },
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/gitui.nvim",
    url = "/home/pedro/Desktop/Plugins/gitui.nvim"
  },
  ["glow.nvim"] = {
    commands = { "Glow" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/opt/glow.nvim",
    url = "https://github.com/npxbr/glow.nvim"
  },
  ["headlines.nvim"] = {
    config = { "\27LJ\2\n¥\1\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\brmd\1\0\2\19dash_highlight\1\21headline_pattern\1\rmarkdown\1\0\0\1\0\2\19dash_highlight\1\21headline_pattern\1\nsetup\14headlines\frequire\0" },
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/headlines.nvim",
    url = "https://github.com/lukas-reineke/headlines.nvim"
  },
  ["heirline.nvim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\26user.plugins.heirline\frequire\0" },
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/heirline.nvim",
    url = "https://github.com/rebelot/heirline.nvim"
  },
  ["hover.nvim"] = {
    config = { "\27LJ\2\nè\2\0\0\t\0\19\2(6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\f\0005\3\3\0006\4\4\0009\4\5\0046\6\6\0009\6\a\0069\6\b\6)\b\0\0B\6\2\2\24\6\0\6B\4\2\2=\4\t\0036\4\4\0009\4\5\0046\6\6\0009\6\a\0069\6\n\6)\b\0\0B\6\2\2\24\6\1\6B\4\2\2=\4\v\3=\3\r\2B\0\2\0016\0\6\0009\0\14\0009\0\15\0'\2\16\0'\3\17\0006\4\0\0'\6\1\0B\4\2\0029\4\1\0045\5\18\0B\0\5\1K\0\1\0\1\0\1\tdesc\15hover.nvim\6K\6n\bset\vkeymap\17preview_opts\1\0\1\ntitle\2\15max_height\24nvim_win_get_height\14max_width\23nvim_win_get_width\bapi\bvim\tceil\tmath\1\0\1\vborder\frounded\nsetup\nhover\frequireçÌ™³\6³æŒÿ\3µæÌ™\19™³¦ÿ\3\0" },
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/hover.nvim",
    url = "https://github.com/lewis6991/hover.nvim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\n°\3\0\0\4\0\n\0\r6\0\0\0009\0\1\0005\1\3\0=\1\2\0006\0\4\0'\2\5\0B\0\2\0029\0\6\0005\2\a\0005\3\b\0=\3\t\2B\0\2\1K\0\1\0\21filetype_exclude\1\b\0\0\rNvimTree\18lsp-installer\rterminal\15toggleterm\16glowpreview\17tsplayground\thelp\1\0\1\25show_current_context\2\nsetup\21indent_blankline\frequire\1\22\0\0\nclass\n^func\vmethod\b^if\nwhile\bfor\twith\btry\vexcept\14arguments\18argument_list\vobject\15dictionary\felement\ntable\ntuple\21type_declaration\23module_declaration\nblock\17switch_match\17jsx_fragment&indent_blankline_context_patterns\6g\bvim\0" },
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["lsp_extensions.nvim"] = {
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/lsp_extensions.nvim",
    url = "https://github.com/nvim-lua/lsp_extensions.nvim"
  },
  ["lsp_menu.nvim"] = {
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/lsp_menu.nvim",
    url = "/home/pedro/Desktop/Plugins/lsp_menu.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim",
    url = "https://github.com/ray-x/lsp_signature.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["lua-dev.nvim"] = {
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/lua-dev.nvim",
    url = "https://github.com/folke/lua-dev.nvim"
  },
  ["nabla.nvim"] = {
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/nabla.nvim",
    url = "https://github.com/jbyuki/nabla.nvim"
  },
  ["null-ls.nvim"] = {
    config = { "\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25user.plugins.null-ls\frequire\0" },
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["numb.nvim"] = {
    config = { "\27LJ\2\n2\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\tnumb\frequire\0" },
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/numb.nvim",
    url = "https://github.com/nacro90/numb.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\n6\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27user.plugins.autopairs\frequire\0" },
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-bufferline"] = {
    config = { "\27LJ\2\n5\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\26user.plugins.cokeline\frequire\0" },
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/nvim-bufferline",
    url = "https://github.com/noib3/nvim-bufferline"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21user.plugins.cmp\frequire\0" },
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\nZ\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\5\0\0\bcss\t!vim\f!packer\14!NvimTree\nsetup\14colorizer\frequire\0" },
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-hclipboard"] = {
    config = { "\27LJ\2\n8\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nstart\15hclipboard\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/opt/nvim-hclipboard",
    url = "https://github.com/kevinhwang91/nvim-hclipboard"
  },
  ["nvim-lsp-installer"] = {
    config = { "\27LJ\2\nD\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\23nvim-lsp-installer\frequire\0" },
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer",
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\n5\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\26user.plugins.nvimtree\frequire\0" },
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\n7\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28user.plugins.treesitter\frequire\0" },
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-rescript"] = {
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/nvim-treesitter-rescript",
    url = "https://github.com/nkrkv/nvim-treesitter-rescript"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-treesitter-textsubjects"] = {
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textsubjects",
    url = "https://github.com/RRethy/nvim-treesitter-textsubjects"
  },
  ["nvim-ts-autotag"] = {
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/nvim-ts-autotag",
    url = "https://github.com/windwp/nvim-ts-autotag"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow",
    url = "https://github.com/p00f/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    config = { "\27LJ\2\n?\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\22nvim-web-devicons\frequire\0" },
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["pandoc.nvim"] = {
    config = { "\27LJ\2\nÙ\1\0\0\6\0\v\0\0196\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\t\0005\3\a\0004\4\5\0005\5\3\0>\5\1\0045\5\4\0>\5\2\0045\5\5\0>\5\3\0045\5\6\0>\5\4\4=\4\b\3=\3\n\2B\0\2\1K\0\1\0\fdefault\1\0\0\targs\1\0\0\1\3\0\0\r--filter\20pandoc-crossref\1\3\0\0\17--pdf-engine\rtectonic\1\2\0\0\22--number-sections\1\2\0\0\17--standalone\nsetup\vpandoc\frequire\0" },
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/pandoc.nvim",
    url = "/home/pedro/Desktop/Plugins/pandoc.nvim"
  },
  playground = {
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["repl.nvim"] = {
    config = { "\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22user.plugins.repl\frequire\0" },
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/repl.nvim",
    url = "/home/pedro/Desktop/Plugins/repl.nvim"
  },
  ["schemastore.nvim"] = {
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/schemastore.nvim",
    url = "https://github.com/b0o/schemastore.nvim"
  },
  ["slides.nvim"] = {
    config = { "\27LJ\2\n8\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\vslides\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/opt/slides.nvim",
    url = "https://github.com/aspeddro/slides.nvim"
  },
  ["smart-splits.nvim"] = {
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/smart-splits.nvim",
    url = "https://github.com/mrjones2014/smart-splits.nvim"
  },
  ["spellsitter.nvim"] = {
    config = { "\27LJ\2\n9\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\16spellsitter\frequire\0" },
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/spellsitter.nvim",
    url = "https://github.com/lewis6991/spellsitter.nvim"
  },
  ["stabilize.nvim"] = {
    config = { "\27LJ\2\ni\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\vnested(QuickFixCmdPost,DiagnosticChanged *\nsetup\14stabilize\frequire\0" },
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/stabilize.nvim",
    url = "https://github.com/luukvbaal/stabilize.nvim"
  },
  ["startuptime.vim"] = {
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/startuptime.vim",
    url = "https://github.com/tweekmonster/startuptime.vim"
  },
  ["telescope-fzf-native.nvim"] = {
    config = { "\27LJ\2\nH\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\bfzf\19load_extension\14telescope\frequire\0" },
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope-github.nvim"] = {
    config = { "\27LJ\2\nG\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\agh\19load_extension\14telescope\frequire\0" },
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/telescope-github.nvim",
    url = "https://github.com/nvim-telescope/telescope-github.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n6\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27user.plugins.telescope\frequire\0" },
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["toggleterm.nvim"] = {
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/toggleterm.nvim",
    url = "https://github.com/akinsho/toggleterm.nvim"
  },
  ["vim-illuminate"] = {
    config = { "\27LJ\2\n2\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1è\3=\1\2\0K\0\1\0\21Illuminate_delay\6g\bvim\0" },
    loaded = true,
    path = "/home/pedro/.local/share/nvim/site/pack/packer/start/vim-illuminate",
    url = "https://github.com/RRethy/vim-illuminate"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: better-escape.nvim
time([[Config for better-escape.nvim]], true)
try_loadstring("\27LJ\2\n_\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\fmapping\1\0\0\1\4\0\0\ajk\ajj\akj\nsetup\18better_escape\frequire\0", "config", "better-escape.nvim")
time([[Config for better-escape.nvim]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
try_loadstring("\27LJ\2\n°\3\0\0\4\0\n\0\r6\0\0\0009\0\1\0005\1\3\0=\1\2\0006\0\4\0'\2\5\0B\0\2\0029\0\6\0005\2\a\0005\3\b\0=\3\t\2B\0\2\1K\0\1\0\21filetype_exclude\1\b\0\0\rNvimTree\18lsp-installer\rterminal\15toggleterm\16glowpreview\17tsplayground\thelp\1\0\1\25show_current_context\2\nsetup\21indent_blankline\frequire\1\22\0\0\nclass\n^func\vmethod\b^if\nwhile\bfor\twith\btry\vexcept\14arguments\18argument_list\vobject\15dictionary\felement\ntable\ntuple\21type_declaration\23module_declaration\nblock\17switch_match\17jsx_fragment&indent_blankline_context_patterns\6g\bvim\0", "config", "indent-blankline.nvim")
time([[Config for indent-blankline.nvim]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25user.plugins.comment\frequire\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)
-- Config for: heirline.nvim
time([[Config for heirline.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\26user.plugins.heirline\frequire\0", "config", "heirline.nvim")
time([[Config for heirline.nvim]], false)
-- Config for: gitui.nvim
time([[Config for gitui.nvim]], true)
try_loadstring("\27LJ\2\n3\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\ngitui\frequire\0", "config", "gitui.nvim")
time([[Config for gitui.nvim]], false)
-- Config for: headlines.nvim
time([[Config for headlines.nvim]], true)
try_loadstring("\27LJ\2\n¥\1\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\brmd\1\0\2\19dash_highlight\1\21headline_pattern\1\rmarkdown\1\0\0\1\0\2\19dash_highlight\1\21headline_pattern\1\nsetup\14headlines\frequire\0", "config", "headlines.nvim")
time([[Config for headlines.nvim]], false)
-- Config for: bufferhandler.nvim
time([[Config for bufferhandler.nvim]], true)
try_loadstring("\27LJ\2\n\22\0\1\2\0\1\0\0029\1\0\0L\1\2\0\vnumberP\1\0\4\0\6\0\b6\0\0\0009\0\1\0003\2\2\0006\3\3\0009\3\4\0039\3\5\0032\0\0€D\0\3\0\20visible_buffers\rcokeline\a_G\0\ftbl_map\bvime\1\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0003\4\3\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\vsource\1\0\0\fbuffers\1\0\0\0\nsetup\18bufferhandler\frequire\0", "config", "bufferhandler.nvim")
time([[Config for bufferhandler.nvim]], false)
-- Config for: repl.nvim
time([[Config for repl.nvim]], true)
try_loadstring("\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22user.plugins.repl\frequire\0", "config", "repl.nvim")
time([[Config for repl.nvim]], false)
-- Config for: detect-indent.nvim
time([[Config for detect-indent.nvim]], true)
try_loadstring("\27LJ\2\n;\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\18detect-indent\frequire\0", "config", "detect-indent.nvim")
time([[Config for detect-indent.nvim]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\26user.plugins.nvimtree\frequire\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: git-conflict.nvim
time([[Config for git-conflict.nvim]], true)
try_loadstring("\27LJ\2\nS\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\21default_mappings\1\nsetup\17git-conflict\frequire\0", "config", "git-conflict.nvim")
time([[Config for git-conflict.nvim]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "config", "nvim-lspconfig")
time([[Config for nvim-lspconfig]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27user.plugins.telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: nvim-lsp-installer
time([[Config for nvim-lsp-installer]], true)
try_loadstring("\27LJ\2\nD\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\23nvim-lsp-installer\frequire\0", "config", "nvim-lsp-installer")
time([[Config for nvim-lsp-installer]], false)
-- Config for: telescope-github.nvim
time([[Config for telescope-github.nvim]], true)
try_loadstring("\27LJ\2\nG\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\agh\19load_extension\14telescope\frequire\0", "config", "telescope-github.nvim")
time([[Config for telescope-github.nvim]], false)
-- Config for: fidget.nvim
time([[Config for fidget.nvim]], true)
try_loadstring("\27LJ\2\n4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\vfidget\frequire\0", "config", "fidget.nvim")
time([[Config for fidget.nvim]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
try_loadstring("\27LJ\2\nZ\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\5\0\0\bcss\t!vim\f!packer\14!NvimTree\nsetup\14colorizer\frequire\0", "config", "nvim-colorizer.lua")
time([[Config for nvim-colorizer.lua]], false)
-- Config for: telescope-fzf-native.nvim
time([[Config for telescope-fzf-native.nvim]], true)
try_loadstring("\27LJ\2\nH\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\bfzf\19load_extension\14telescope\frequire\0", "config", "telescope-fzf-native.nvim")
time([[Config for telescope-fzf-native.nvim]], false)
-- Config for: diffview.nvim
time([[Config for diffview.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\26user.plugins.diffview\frequire\0", "config", "diffview.nvim")
time([[Config for diffview.nvim]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21user.plugins.cmp\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: hover.nvim
time([[Config for hover.nvim]], true)
try_loadstring("\27LJ\2\nè\2\0\0\t\0\19\2(6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\f\0005\3\3\0006\4\4\0009\4\5\0046\6\6\0009\6\a\0069\6\b\6)\b\0\0B\6\2\2\24\6\0\6B\4\2\2=\4\t\0036\4\4\0009\4\5\0046\6\6\0009\6\a\0069\6\n\6)\b\0\0B\6\2\2\24\6\1\6B\4\2\2=\4\v\3=\3\r\2B\0\2\0016\0\6\0009\0\14\0009\0\15\0'\2\16\0'\3\17\0006\4\0\0'\6\1\0B\4\2\0029\4\1\0045\5\18\0B\0\5\1K\0\1\0\1\0\1\tdesc\15hover.nvim\6K\6n\bset\vkeymap\17preview_opts\1\0\1\ntitle\2\15max_height\24nvim_win_get_height\14max_width\23nvim_win_get_width\bapi\bvim\tceil\tmath\1\0\1\vborder\frounded\nsetup\nhover\frequireçÌ™³\6³æŒÿ\3µæÌ™\19™³¦ÿ\3\0", "config", "hover.nvim")
time([[Config for hover.nvim]], false)
-- Config for: nvim-bufferline
time([[Config for nvim-bufferline]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\26user.plugins.cokeline\frequire\0", "config", "nvim-bufferline")
time([[Config for nvim-bufferline]], false)
-- Config for: stabilize.nvim
time([[Config for stabilize.nvim]], true)
try_loadstring("\27LJ\2\ni\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\vnested(QuickFixCmdPost,DiagnosticChanged *\nsetup\14stabilize\frequire\0", "config", "stabilize.nvim")
time([[Config for stabilize.nvim]], false)
-- Config for: vim-illuminate
time([[Config for vim-illuminate]], true)
try_loadstring("\27LJ\2\n2\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1è\3=\1\2\0K\0\1\0\21Illuminate_delay\6g\bvim\0", "config", "vim-illuminate")
time([[Config for vim-illuminate]], false)
-- Config for: spellsitter.nvim
time([[Config for spellsitter.nvim]], true)
try_loadstring("\27LJ\2\n9\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\16spellsitter\frequire\0", "config", "spellsitter.nvim")
time([[Config for spellsitter.nvim]], false)
-- Config for: numb.nvim
time([[Config for numb.nvim]], true)
try_loadstring("\27LJ\2\n2\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\tnumb\frequire\0", "config", "numb.nvim")
time([[Config for numb.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28user.plugins.treesitter\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: null-ls.nvim
time([[Config for null-ls.nvim]], true)
try_loadstring("\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25user.plugins.null-ls\frequire\0", "config", "null-ls.nvim")
time([[Config for null-ls.nvim]], false)
-- Config for: nvim-web-devicons
time([[Config for nvim-web-devicons]], true)
try_loadstring("\27LJ\2\n?\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\22nvim-web-devicons\frequire\0", "config", "nvim-web-devicons")
time([[Config for nvim-web-devicons]], false)
-- Config for: pandoc.nvim
time([[Config for pandoc.nvim]], true)
try_loadstring("\27LJ\2\nÙ\1\0\0\6\0\v\0\0196\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\t\0005\3\a\0004\4\5\0005\5\3\0>\5\1\0045\5\4\0>\5\2\0045\5\5\0>\5\3\0045\5\6\0>\5\4\4=\4\b\3=\3\n\2B\0\2\1K\0\1\0\fdefault\1\0\0\targs\1\0\0\1\3\0\0\r--filter\20pandoc-crossref\1\3\0\0\17--pdf-engine\rtectonic\1\2\0\0\22--number-sections\1\2\0\0\17--standalone\nsetup\vpandoc\frequire\0", "config", "pandoc.nvim")
time([[Config for pandoc.nvim]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\26user.plugins.gitsings\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: LuaSnip
time([[Config for LuaSnip]], true)
try_loadstring("\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25user.plugins.luasnip\frequire\0", "config", "LuaSnip")
time([[Config for LuaSnip]], false)
-- Config for: formatter.nvim
time([[Config for formatter.nvim]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27user.plugins.formatter\frequire\0", "config", "formatter.nvim")
time([[Config for formatter.nvim]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27user.plugins.autopairs\frequire\0", "config", "nvim-autopairs")
time([[Config for nvim-autopairs]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Glow lua require("packer.load")({'glow.nvim'}, { cmd = "Glow", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'slides.nvim'}, { ft = "markdown" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au InsertCharPre * ++once lua require("packer.load")({'nvim-hclipboard'}, { event = "InsertCharPre *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
