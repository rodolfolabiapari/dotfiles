# Agent Guidelines for Tmux Configuration

## Build/Lint/Test Commands

Since this is a tmux configuration repository, there is no traditional build process. Use these commands:

- **Apply/Reload config**: `tmux source-file ~/.config/tmux/tmux.conf` or press `q` in tmux (bound in config)
- **Validate syntax**: `tmux -f ~/.config/tmux/tmux.conf start-server` (starts without errors if valid)
- **Test config**: Start a new tmux session: `tmux -f ~/.config/tmux/tmux.conf new-session`
- **Check tmux version**: `tmux -V` (requires tmux 3.0+ for full compatibility)
- **Dry-run with verbose**: `tmux -f ~/.config/tmux/tmux.conf -vv new-session` (logs to ~/.tmux logs)

## Code Style Guidelines

### File Structure
- Single configuration file: `~/.config/tmux/tmux.conf`
- Organize settings by category with section comments (e.g., `# Prefix`, `# Status bar`, `# Theme`)
- Keep related bindings together (navigation, panes, windows, sessions)

### Formatting
- One command per line
- Use 2-space indentation for multi-line commands (e.g., display-popup, if-shell blocks)
- Separate major sections with blank lines
- Align comments consistently (space after #)
- No trailing whitespace

### Command Syntax
- Global options: `set -g <option> <value>`
- Window options: `setw -g <option> <value>`
- Window/global: `set -gw <option> <value>` for window settings that should persist
- Bindings without prefix: `bind -n <key> <command>`
- Bindings requiring prefix: `bind <key> <command>`
- Use key tables: `bind -T <table> <key> <command>` (e.g., copy-mode-vi)

### Key Binding Conventions
- Prefer `C-` for Ctrl, `M-` for Alt/Meta, `S-` for Shift
- Use modifier combinations: `C-M-h`, `C-S-Left`, etc.
- Avoid conflicting with default tmux shortcuts unless overriding intentionally
- Document non-obvious key choices with comments
- Use `send-prefix` for dual prefix setups

### Options and Values
- Boolean options: `on`/`off` (e.g., `set -g mouse on`)
- Numeric values: no quotes (e.g., `set -g history-limit 50000`)
- String values: quotes when containing spaces or special chars (e.g., `set -g default-terminal "tmux-256color"`)
- Style attributes: `"bg=color,fg=color"` format
- Format strings: `#{variable}` syntax with braces

### Comments
- Use section headers with a blank line before and after
- Explain non-obvious bindings or complex logic
- Inline comments should clarify intent, not restate the command
- Keep comments concise; reference external docs for complex patterns

### Naming Conventions
- Session/window names: descriptive but concise
- Popup commands: use clear command descriptions when possible
- Variables: tmux format variables use snake_case (e.g., `pane_current_path`)

### Error Handling
- Use `if-shell` for conditional execution based on tmux version or external commands
- Quote shell commands properly within `if-shell`
- For version checks, use: `if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' "new-bindings" "fallback-bindings"`

### Vi Mode Integration
- Use `-T copy-mode-vi` table for copy mode bindings
- Include `setw -g mode-keys vi` to enable vi mode
- Use `send -X` for copy-mode actions (e.g., `begin-selection`, `copy-selection-and-cancel`)

### Format Strings
- Use `#{}` for dynamic content in status bar, pane paths, etc.
- For boolean conditions: `#{?condition,true-value,false-value}`
- Window format: `#I:#W` (index and name)
- Pane current path: `#{pane_current_path}`

### tmux Version Compatibility
- Document version-specific bindings
- Use version checks for features available only in tmux 3.0+
- Test with `tmux -V` to ensure compatibility

### Style Consistency
- Use `-g` flag for global settings unless intentionally scoped
- Prefer `-a` (append) when adding to existing lists (e.g., `set -ag terminal-overrides`)
- Consistent ordering: settings first, then bindings, grouped by function

### External Dependencies
- Document external command dependencies (e.g., `ps`, `grep`, `sed`, `nvim`, `bash`)
- Ensure commands in `if-shell` and `display-popup -E` exist on target systems
- Provide fallbacks when possible

## Design Principles
- Keep config portable; avoid absolute paths when possible
- Use tmux-native features over external scripting
- Maintain backward compatibility with tmux 2.4+ unless dropping support explicitly
- Prefer key combinations that don't conflict with terminal emulator shortcuts