DOTFILES := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
HOME_DIR := $(HOME)
STOW := stow --no-folding -d $(DOTFILES) -t $(HOME_DIR)

## ── Package groups (single source of truth) ──────────────────────────────────
STOW_CROSS := bash zsh shellrc.d scripts starship tmux git nvim bat mise opencode agents claude kitty
STOW_OMARCHY_ONLY  := omarchy hypr
STOW_OMARCHY_MACOS := flameshot btop
STOW_MACOS_ONLY    := kitty-macos

## ── OS detection ──────────────────────────────────────────────────────────────
OS_FAMILY := $(shell uname -s)

ifeq ($(OS_FAMILY),Linux)
  ifneq ($(shell test -f /etc/arch-release && echo arch),)
    STOW_TARGET := $(STOW_CROSS) $(STOW_OMARCHY_ONLY) $(STOW_OMARCHY_MACOS)
  else
    STOW_TARGET := $(STOW_CROSS)
  endif
else ifeq ($(OS_FAMILY),Darwin)
  STOW_TARGET := $(STOW_CROSS) $(STOW_OMARCHY_MACOS) $(STOW_MACOS_ONLY)
else
  STOW_TARGET := $(STOW_CROSS)
endif

## ── Dry-run support ──────────────────────────────────────────────────────────
ifdef DRYRUN
STOW_FLAGS := -n
else
STOW_FLAGS :=
endif

.PHONY: help stow stow-dry unstow rehome list export-lists

## help: Show this help
help:
	@grep -E '^##' $(MAKEFILE_LIST) | sed 's/##//' | column -t -s ':'

## stow: Stow all packages (create symlinks from ~ to ~/.dotfiles)
stow:
	@for pkg in $(STOW_TARGET); do \
		if [ -d "$(DOTFILES)/$$pkg" ]; then \
			$(STOW) $(STOW_FLAGS) -R $$pkg && echo "  ✓ $$pkg"; \
		fi; \
	done

## stow-dry: Simulate stow (same as make DRYRUN=1 stow)
stow-dry:
	@$(MAKE) DRYRUN=1 stow

## unstow: Remove all symlinks (unstow everything)
unstow:
	@for pkg in $(STOW_TARGET); do \
		if [ -d "$(DOTFILES)/$$pkg" ]; then \
			$(STOW) $(STOW_FLAGS) -D $$pkg && echo "  ✓ unstowed $$pkg"; \
		fi; \
	done

## rehome: Unstow → stow (refresh all symlinks)
rehome: unstow stow

## list: List all stow-managed packages
list:
	@echo "Packages in $(DOTFILES):"
	@ls -1d $(DOTFILES)/*/ | xargs -n1 basename

## export-lists: Emit package lists for bootstrap.sh to consume
export-lists:
	@echo STOW_CROSS="$(STOW_CROSS)"
	@echo STOW_OMARCHY_ONLY="$(STOW_OMARCHY_ONLY)"
	@echo STOW_OMARCHY_MACOS="$(STOW_OMARCHY_MACOS)"
	@echo STOW_MACOS_ONLY="$(STOW_MACOS_ONLY)"
