DOTFILES := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

.PHONY: help stow unstow rehome list

## help: Show this help
help:
	@grep -E '^##' $(MAKEFILE_LIST) | sed 's/##//' | column -t -s ':'

## stow: Stow all packages (create symlinks from ~ to ~/.dotfiles)
stow:
	@for pkg in bash zsh scripts starship tmux git nvim alacritty foot kitty ghostty omarchy btop; do \
		if [ -d "$(DOTFILES)/$$pkg" ]; then \
			stow -d $(DOTFILES) -R $$pkg && echo "  ✓ $$pkg"; \
		fi; \
	done

## unstow: Remove all symlinks (unstow everything)
unstow:
	@for pkg in bash zsh scripts starship tmux git nvim alacritty foot kitty ghostty omarchy btop; do \
		if [ -d "$(DOTFILES)/$$pkg" ]; then \
			stow -d $(DOTFILES) -D $$pkg && echo "  ✓ unstowed $$pkg"; \
		fi; \
	done

## rehome: Unstow → stow (refresh all symlinks)
rehome: unstow stow

## list: List all stow-managed packages
list:
	@echo "Packages in $(DOTFILES):"
	@ls -1d $(DOTFILES)/*/ | xargs -n1 basename