# AGENTS.md - Neovim Configuration Guidelines

## Repository Overview
This is a Neovim configuration using LazyVim framework. All code is Lua-based plugin configuration.

## Testing & Validation

### Manual Testing (Primary Method)
Since this is a Neovim config, testing is done by:
1. `nvim` - Start Neovim to test changes
2. `:checkhealth` - Verify Neovim health and plugin status
3. `:Lazy` - Check plugin installation status
4. Restart Neovim after config changes to ensure proper loading

### Debugging
- Use `:messages` to view startup messages
- Check `:Lazy log` for plugin errors
- Review `~/.local/state/nvim/lazy.log` for detailed logs

### No Automated Tests
This repository does not have unit/integration tests. Validation is manual through Neovim startup and feature testing.

## Build & Lint Commands

### Formatting
```bash
stylua lua/
```
Uses `stylua.toml` config: 2-space indentation, 120 column width.

### Linting
No dedicated linter. Use Neovim itself:
```bash
nvim --headless -c "quit" 2>&1 | grep -i error
```
To validate Lua syntax without running UI.

## Code Style Guidelines

### File Structure
- Config files: `lua/config/*.lua` (options, keymaps, autocmds)
- Plugin specs: `lua/plugins/*.lua`
- Custom plugins: `plugin/after/**/*.lua`
- Follow LazyVim conventions: use "mine-" prefix for overrides

### Imports & Requires
```lua
-- Use local require relative to lua/ directory
local opts = require("config.options")
local keymap = require("config.keymaps")

-- Plugin specs import via LazyVim
{ import = "plugins" }
{ "plugin/name", opts = {} }
```

### Formatting (Stylua)
- Indent: 2 spaces (no tabs)
- Column width: 120
- Always use `expandtab` in Vim
- Keep lines reasonably short for readability

### Naming Conventions
- **Files**: lowercase with hyphens (kebab-case): `gitsigns.lua`, `omarchy-theme.lua`
- **Variables & functions**: lowercase_with_underscores (snake_case) or camelCase
- **Constants**: UPPER_CASE for truly constant values
- **Tables/Modules**: match filename
- **Lua modules**: use dot notation path matching directory structure

### Types
Lua is dynamically typed. Document types when complex:
```lua
---@type table<string, boolean>
local enabled_features = {}
```
Use type hints sparingly; rely on documentation strings.

### Error Handling
- Wrap plugin setups in `pcall()` for fault tolerance:
  ```lua
  local status, _ = pcall(function()
    require("some-plugin").setup()
  end)
  ```
- Use `vim.notify()` for user-facing messages
- Avoid `error()` in config; prefer warnings

### Plugin Configuration Pattern
```lua
return {
  "plugin/name",
  opts = {
    -- plugin options
  },
  dependencies = {
    -- required plugins
  },
  event = "VeryLazy", -- or "BufRead", etc.
  keys = {
    -- key mappings
  },
}
```
Follow LazyVim's lazy-loading conventions.

### Comments
- Use `--` for single-line comments
- Include brief description at top of files
- Comment non-obvious logic
- Avoid redundant comments

### Vim Options
Set options in `lua/config/options.lua`:
```lua
vim.opt.relativenumber = true
vim.opt.expandtab = true
```
Use `vim.g` for global variables only when required by plugins.

## Existing Project Conventions
- Prefix custom plugin overrides with "mine-" (e.g., `mine-telescope.lua`)
- Use `plugin/after/` for late-loading customizations
- Keep config modular: separate keymaps, autocmds, options
- Follow LazyVim defaults; only override when necessary

## No Build System
This is pure configuration. No compilation or package management beyond:
- `:Lazy install` - install plugins
- `:Lazy sync` - update/install plugins
- `:Lazy clean` - remove unconfigured plugins

## Notes for Agents
- Always check existing file patterns before creating new config files
- Preserve LazyVim conventions; don't break implicit loading order
- Respect existing "after/" directory for load-order overrides
- Test config changes by starting Neovim with `nvim -u NORC` to isolate issues
