# Neovim Config Notes

## Structure
- `init.lua` - Entry point, loads options, mapping, lazy
- `lua/config/options.lua` - Vim options (52 lines)
- `lua/config/mapping.lua` - Keymaps (51 lines)
- `lua/config/lazy.lua` - Lazy plugin manager setup

## Plugins (each in own file)
- tokyonight.nvim - colorscheme
- lualine.nvim - statusline
- telescope.nvim - fuzzy finder (depends: plenary.nvim)
- telescope-fzf-native.nvim - fzf sorter

## Directives
- [x] Plugin has its own file
- [x] Configuration + keymaps in dedicated plugin file