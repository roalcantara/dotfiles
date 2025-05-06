#!/usr/bin/env bash
SHELL := /bin/bash
.SHELLFLAGS := -eu -o pipefail -c

# Brew shared packages
override BREW_NEOVIM_FORMULAES_SHARED ?= \
  git \
  lua \
  node \
  python \
  ruby \
  shellcheck \
  curl \
  wget \
  lazygit \
  frizbee \
  fortune \
  cowsay

# Brew essential packages
override BREW_NEOVIM_FORMULAES_DEPS ?= \
  wrk \
  hub

# Brew formulaes used across multiple projects
override BREW_NEOVIM_FORMULAES_OPT ?= \
  tectonic \
  viu

# Brew formulaes required for developing and working with Neovim (installed from HEAD)
override BREW_NEOVIM_FORMULAES_CORE := neovim

# Brew packages to install
override BREW_NEOVIM_FORMULAES := $(BREW_NEOVIM_FORMULAES_SHARED) $(BREW_NEOVIM_FORMULAES_DEPS) $(BREW_NEOVIM_FORMULAES_OPT)

# Brew formulaes, casks and dependencies to uninstall when removing Neovim completely
override BREW_NEOVIM_FORMULAES_RM ?= $(BREW_NEOVIM_FORMULAES) \
  libtermkey \
  libvterm \
  pkg-config \
  tree-sitter \
  luarocks \
  luajit \
  ninja \
  acl \
  libxml2 \
  gettext \
  lpeg \
  luv \
  unibilium \
  utf8proc

# Brew formulae/casks folders to remove manually when uninstalling Neovim completely
override BREW_NEOVIM_FORMULAES_FOLDERS_TO_RM ?= /usr/local/etc/luarocks \
	/usr/local/etc/wgetrc

override NEOVIM_MASON_DEPS ?= \
	ast-grep \
    bash-language-server \
    css-lsp \
    diagnostic-languageserver \
    docker-compose-language-service \
    dockerfile-language-server \
    eslint-lsp \
    html-lsp \
    json-lsp \
    lua-language-server \
    marksman \
    neocmakelsp \
	prettier \
    pyright \
    ruby-lsp \
    shfmt \
    stylua \
    taplo \
    vim-language-server \
    vtsls \
    yaml-language-server

.PHONY: nvim/all
nvim/all:
	@make -s help | fzf --cycle | cut -d ' ' -f1 | xargs -r make

nvim/add/pkgs/brew: ## INSTALLS brew pre-requisites
	@$(call log,|NEOVIM| Installing neovim's required BREW dependencies: '$(BREW_NEOVIM_FORMULAES)')
	brew install $(BREW_NEOVIM_FORMULAES) || true

nvim/add/pkgs/brew/neovim: ## INSTALLS neovim's required BREW packages
	@$(call log,|NEOVIM| Installing neovim's required BREW packages: '$(BREW_NEOVIM_FORMULAES_CORE)')
	brew install $(BREW_NEOVIM_FORMULAES_CORE) || true;

nvim/add/pkgs/npm: ## INSTALLS neovim's required NPM packages
	@$(call log,|NEOVIM| Installing required NPM packages at '$(npm_config_cache)'...)
	@npm -g install neovim @mermaid-js/mermaid-cli

nvim/add/pkgs/pip: ## INSTALLS neovim's required PIP packages
	@$(call log,|NEOVIM| Checking for python3...)
	@if ! command -v python3 >/dev/null 2>&1; then \
		brew install python; \
	fi

	@$(call log,|NEOVIM| Checking if virtual environment exists...)
	@if [ ! -d ~/.config/nvim/env ]; then \
		python3 -m venv ~/.config/nvim/env; \
	fi

	@$(call log,|NEOVIM| Installing required PIP packages...)
	@source ~/.config/nvim/env/bin/activate && pip install pynvim

nvim/add/pkgs/gem: ## INSTALLS neovim's required GEM packages
	@$(call log,|NEOVIM| Installing required GEM packages at '$(GEM_HOME)'...)
	@gem update --system --no-document
	@gem install neovim rubocop

.PHONY: nvim/add/pkgs
nvim/add/pkgs: nvim/add/pkgs/npm nvim/add/pkgs/pip nvim/add/pkgs/gem ## INSTALLS neovim's required packages (https://neovim.io/doc/user/provider.html)

.PHONY: nvim/build/plugins/lsp
nvim/build/plugins/lsp: ## Sync neovim plugins (https://github.com/quietinvestor/nvim-userland/blob/main/Dockerfile)
	nvim --headless -c "lua require('lazy').load({plugins = {'mason-lspconfig.nvim'}})" -c "MasonInstall $(NEOVIM_MASON_DEPS)" +qa

.PHONY: nvim/build/plugins
nvim/build/plugins: ## BUILD PLUGINS: Sync and setup neovim's plugins
	@$(call log,|NEOVIM| Syncing and configuring plugins...)
	nvim --headless +verbose \
				+'Lazy! sync' \
				+'Lazy! clean' \
				+'Lazy! clear' \
				+'TSUpdateSync' \
		        -c "lua require('lazy').load({plugins = {'mason-lspconfig.nvim'}})" \
				-c "MasonInstall $(NEOVIM_MASON_DEPS)" +qa

.PHONY: nvim/rebuild/plugins
nvim/rebuild/plugins: nvim/clear/plugins nvim/build/plugins ## REBUILD PLUGINS: Clear and build neovim's plugins

nvim/rm/pkgs/brew: ## UNINSTALLS neovim's additional BREW packages
	brew uninstall $(BREW_NEOVIM_FORMULAES_RM) || true

nvim/rm/pkgs/brew/neovim: ## UNINSTALLS neovim's required BREW packages and folders
	brew uninstall --ignore-dependencies $(BREW_NEOVIM_FORMULAES_CORE) || true
	rm -rf $(BREW_NEOVIM_FORMULAES_FOLDERS_TO_RM) || true

nvim/rm/pkgs/pip: ## UNINSTALLS neovim's required PIP packages
	@$(call log,|NEOVIM| Uninstalling neovim's required PIP packages...)
	@rm -rf ~/.config/nvim/env

nvim/rm/pkgs/gem: ## UNINSTALLS neovim's required GEM packages
	@$(call log,|NEOVIM| Uninstalling neovim's required GEM packages from '$(GEM_HOME)'...)
	@gem uninstall neovim rubocop

nvim/rm/pkgs/npm: ## UNINSTALLS neovim's required NPM packages
	@$(call log,|NEOVIM| Uninstalling neovim's required NPM packages from '$(npm_config_cache)'...)
	@npm -g uninstall neovim @mermaid-js/mermaid-cli

nvim/rm/pkgs: nvim/rm/pkgs/pip nvim/rm/pkgs/gem nvim/rm/pkgs/npm ## UNINSTALLS neovim's required packages (https://neovim.io/doc/user/provider.html)

nvim/clear/plugins: ## CLEAR PLUGINS: Removes all neovim's plugins
	rm -rf ~/.config/nvim/lazy-lock.json ~/.local/state/nvim ~/.local/share/nvim ~/.cache/nvim

nvim/clear/backups: ## CLEAR BACKUPS: Removes all neovim's backups
	mv ~/.local/share/nvim{,.bak}
	mv ~/.local/state/nvim{,.bak}
	mv ~/.cache/nvim{,.bak}

.PHONY: nvim/install
nvim/install: nvim/add/pkgs/brew nvim/add/pkgs/brew/neovim nvim/add/pkgs nvim/build/plugins ## INSTALLS neovim, packages and plugins (https://neovim.io/doc/user/provider.html)
	@$(call log,|NEOVIM| Installation complete ✔✔)
	@nvim -V1 -v

.PHONY: nvim/uninstall
nvim/uninstall: nvim/rm/pkgs/brew/neovim nvim/rm/pkgs/brew nvim/rm/pkgs nvim/purge ## UNINSTALLS neovim, packages and plugins
	brew autoremove && brew update && brew upgrade && brew upgrade --cask && brew cleanup --prune=all && brew doctor

.PHONY: nvim/reinstall
nvim/reinstall: nvim/uninstall nvim/install ## REINSTALL: uninstall and install neovim, packages and plugins

.PHONY: nvim/purge
nvim/purge: nvim/clear/plugins nvim/clear/backups ## Removes all neovin's plugins and backups

.PHONY: nvim/help
nvim/help: ## Display available tasks
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z\-_0-9%:\/]+:.*?## / {printf "\033[36m%-30s→\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sed s/://
