# Omarchy Agent Guidelines

This file provides instructions for agentic coding agents working on the Omarchy project.

## Project Overview

Omarchy is a beautiful, modern & opinionated Linux distribution focused on desktop customization and system configuration. The project consists primarily of bash scripts for system setup, configuration management, and helper utilities.

## Directory Structure

- `bin/` - Main executable scripts (omarchy-* commands)
- `config/` - Default configuration files copied to user's ~/.config/
- `default/` - Default templates and configurations
- `install/` - Installation scripts and helpers
- `migrations/` - System migration scripts
- `themes/` - Theme configurations and assets
- `helpers/` - Shared utility functions

## Build/Lint/Test Commands

Since Omarchy is primarily a collection of bash scripts, there are no traditional build steps. However, the following validation practices are recommended:

### Shell Script Validation
```bash
# Check syntax of all shell scripts
find . -name "*.sh" -exec shellcheck {} \;

# Check syntax of a specific script
shellcheck bin/omarchy-cmd-missing

# Check syntax of all bin scripts
shellcheck bin/*

# Run shfmt for formatting checks
find . -name "*.sh" -exec shfmt -d {} \;
```

### Running Specific Tests
Omarchy doesn't have a formal test suite, but individual scripts can be tested by:
1. Running them directly with `--help` or similar flags if supported
2. Testing in isolated environments
3. Using bats (Bash Automated Testing System) for more formal testing

To run a single script test:
```bash
# Example: Test omarchy-cmd-missing
bin/omarchy-cmd-missing ls nonexistentcommand && echo "Works correctly"

# Example: Test omarchy-cmd-present
bin/omarchy-cmd-present ls && echo "ls is present"
```

## Code Style Guidelines

### General Formatting
- **Indentation**: Two spaces, no tabs
- **Line Length**: Aim for 80-100 characters, break long lines logically
- **Shebangs**: Must be `#!/bin/bash` (never `#!/usr/bin/env bash`)
- **Executable Bit**: All scripts in `bin/` must be executable (`chmod +x`)

### Bash-Specific Guidelines
- **Conditionals**: 
  - Use `[[ ]]` for string/file tests
  - Use `(( ))` for numeric tests
  - In `[[ ]]`, don't quote variables, but do quote string literals when comparing values (e.g., `[[ $branch == "dev" ]]`)
  - Prefer `(( ))` over numeric operators inside `[[ ]]` (e.g., `(( count < 50 ))`, not `[[ $count -lt 50 ]]`)
- **String Handling**:
  - Quote variables that may contain spaces: `"$APP_DIR/File Name.desktop"`
  - Prefer quoting over escaping spaces with `\ `
- **Command Substitution**: Prefer `$(command)` over backticks

### Command Naming Convention
All commands follow the pattern `omarchy-[purpose]-[specific]`:
- `cmd-` - Check if commands exist, misc utilities
- `pkg-` - Package management helpers
- `hw-` - Hardware detection (return exit codes for conditionals)
- `refresh-` - Copy default config to user's `~/.config/`
- `restart-` - Restart a component
- `launch-` - Open applications
- `install-` - Install optional software
- `setup-` - Interactive setup wizards
- `toggle-` - Toggle features on/off
- `theme-` - Theme management
- `update-` - Update components

### Helper Commands Usage
Use these instead of raw shell commands:
- `omarchy-cmd-missing` / `omarchy-cmd-present` - Check for commands
- `omarchy-pkg-missing` / `omarchy-pkg-present` - Check for packages
- `omarchy-pkg-add` - Install packages (handles pacman and AUR)
- `omarchy-hw-*` - Hardware detection commands (e.g., `omarchy-hw-asus-rog`)

### Error Handling
- Check return codes of commands when appropriate
- Use `set -euo pipefail` in scripts that need strict error handling
- Provide meaningful error messages to users
- For helper scripts, follow existing patterns in the codebase

### Configuration Structure
- `config/` - Default configs copied to `~/.config/`
- `default/themed/*.tpl` - Templates with `{{ variable }}` placeholders for theme colors
- `themes/*/colors.toml` - Theme color definitions (accent, background, foreground, color0-15)

## Refresh Pattern

To copy a default config to user config with automatic backup:

```bash
omarchy-refresh-config hypr/hyprlock.conf
```

This copies `~/.local/share/omarchy/config/hypr/hyprlock.conf` to `~/.config/hypr/hyprlock.conf`.

## Migrations

To create a new migration, run `omarchy-dev-add-migration --no-edit`. This creates a migration file named after the unix timestamp of the last commit.

Migration format:
- No shebang line
- Start with an `echo` describing what the migration does
- Use `$OMARCHY_PATH` to reference the omarchy directory
- Make migrations idempotent when possible

Example:
```bash
echo "Disable fingerprint in hyprlock if fingerprint auth is not configured"

if omarchy-cmd-missing fprintd-list || ! fprintd-list "$USER" 2>/dev/null | grep -q "finger"; then
  sed -i 's/fingerprint:enabled = .*/fingerprint:enabled = false/' ~/.config/hypr/hyprlock.conf
fi
```

## Best Practices

### Script Organization
- Keep scripts focused on a single responsibility
- Use helper functions from `install/helpers/` when applicable
- Document complex logic with comments
- Follow existing patterns in the codebase

### User Interaction
- Provide clear output and progress indicators
- Handle edge cases gracefully
- Request confirmation for destructive operations
- Respect user preferences and existing configurations

### Security Considerations
- Validate inputs when scripts accept parameters
- Avoid executing untrusted code
- Use least privilege principles
- Be cautious with system modifications

## Contributing

When adding new functionality:
1. Follow existing naming conventions
2. Place executables in `bin/` with proper permissions
3. Add documentation in comments at the top of scripts
4. Test thoroughly in various scenarios
5. Consider idempotency and safety

This AGENTS.md file should be updated as the project evolves and new patterns emerge.