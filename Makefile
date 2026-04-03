.PHONY: help stow clean push format macos-settings

help: ## Show this help message
	@echo "Available commands:"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  %-15s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

stow: ## Create symlinks using stow
	@echo "Creating symlinks..."
	@stow -v .

clean: ## Remove symlinks
	@echo "Removing symlinks..."
	@stow -v -D .

push: ## Commit and push changes to git
	@echo "Committing and pushing changes..."
	@git add .
	@git status
	@git commit -m "Update Dotfiles"
	@git push

format: ## Format dotfiles with shfmt, prettier, and taplo
	@echo "Formatting dotfiles..."
	find . -name "*.sh" -o -name "*.zsh" | xargs shfmt -w
	find . -name "*.jsonc" | xargs prettier --write
	find . -name "*.toml" | xargs taplo fmt

macos-settings: ## Apply Mac OS settings
	@echo "Applying Mac OS settings..."
	./scripts/macos-settings.sh