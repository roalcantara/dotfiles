#!/usr/bin/env bash
SHELL := /bin/bash

# Detect system architecture
ARCH := $(shell uname -m)
ifeq ($(ARCH),arm64)
  IS_ARM := true
  PLATFORM := linux/amd64
else
  IS_ARM := false
  PLATFORM := linux/$(ARCH)
endif

# Brew essential packages
override BREW_FORMULAES_CORE ?= \
  eslint \
  flake8 \
  kotlin \
  ktlint \
  lazygit \
  lua-language-server \
  make \
  markdownlint-cli2 \
  marksman \
  prettier \
  selene \
  shellcheck \
  shellharden \
  shfmt \
  sqlfluff \
  stylelint \
  stylua \
  taplo \
  tidy-html5 \
  typescript \
  vint \
  yamllint

# Brew formulaes required for developing and working with Neovim
override BREW_NEOVIM_FORMULAES_CORE ?= wrk

# Brew unlinked formulaes required for developing and working with Neovim (installed from HEAD)
override BREW_NEOVIM_FORMULAES_CORE_HEAD_UNLINKED ?= utf8proc

# Brew linked formulaes required for developing and working with Neovim (installed from HEAD)
override BREW_NEOVIM_FORMULAES_CORE_HEAD_LINKED ?= neovim

# Brew formulaes required for developing and working with Neovim (installed from HEAD)
override BREW_NEOVIM_FORMULAES_CORE_HEAD ?= $(join $(BREW_NEOVIM_FORMULAES_CORE_HEAD_UNLINKED), $(BREW_NEOVIM_FORMULAES_CORE_HEAD_LINKED))

# Brew casks required for developing and working with Neovim
override BREW_NEOVIM_CASKS_CORE ?= docker

# Brew formulaes used across multiple projects
override BREW_NEOVIM_FORMULAES_OPT ?= \
  frizbee \
  fsouza/prettierd/prettierd \
  isort \
  kotlin-language-server \
  php \
  pngpaste \
  proselint \
  python-lsp-server \
  scullionw/tap/dirstat-rs \
  tectonic \
  tflint \
  typescript-language-server \
  viu \
  yaml-language-server

# Brew formulaes, casks and dependencies to uninstall when removing Neovim completely
override BREW_NEOVIM_FORMULAES_RM ?= $(join $(BREW_NEOVIM_FORMULAES_OPT), $(BREW_FORMULAES_CORE), $(BREW_NEOVIM_FORMULAES_CORE), $(BREW_NEOVIM_FORMULAES_CORE_HEAD_LINKED), $(BREW_NEOVIM_CASKS_CORE)) \
  libtermkey \
  libvterm \
  pkg-config \
  tree-sitter \
  luarocks \
  luajit \
  ninja \
  lua

# Brew formulae/casks folders to remove manually when uninstalling Neovim completely
override BREW_NEOVIM_FORMULAES_FOLDERS_TO_RM ?= /usr/local/etc/luarocks \
	/usr/local/etc/wgetrc

default:
	@make -s nvim/all

nvim/all:
	@make -s help | fzf --cycle | cut -d ' ' -f1 | xargs -r make

nvim/brew/install: ## INSTALLS brew dependencies
	$(foreach p,$(BREW_PKGS), brew install $(p) || true;)

nvim/brew/install/neovim: ## INSTALLS neovim
	$(foreach p,$(BREW_NEOVIM_FORMULAES_CORE_HEAD), brew install --HEAD $(p) || true;)

nvim/npm/install: ## INSTALLS NPM linters
	@echo "--- INSTALLING NPM requirements"
	npm -g install neovim @mermaid-js/mermaid-cli

nvim/pip/install: ## INSTALLS pip3 requirements
	@echo "--- INSTALLING pip3 requirements"
	python3 -m venv ~/.config/nvim/env && source ~/.config/nvim/env/bin/activate && pip install pynvim

nvim/gem/install: ## INSTALLS gem requirements
	@echo "--- INSTALLING gem requirements"
	gem update --system
	gem install neovim rubocop

.PHONY: nvim/deps/install
nvim/deps/install: nvim/npm/install nvim/pip/install nvim/gem/install ## Install Neovim Providers (https://neovim.io/doc/user/provider.html)

nvim/sync: ## Sync Packer plugins
	nvim -v --headless +qa
	nvim -v --headless '+Lazy! sync' +qa
	@echo "--- Syncing plugins and configurations ✔✔"

.PHONY: nvim/configure
nvim/configure: nvim/sync ## Syncs and configures Neovim plugins
	nvim -v --headless '+Lazy! sync' +qa
	@echo "--- Configuration complete ✔✔"

.PHONY: nvim/reconfigure
nvim/reconfigure: nvim/clear nvim/configure ## Reconfigures Neovim from scratch

.PHONY: nvim/install
nvim/install: nvim/brew/install nvim/brew/install/neovim nvim/deps/install nvim/configure

nvim/clear: ## Removes all nvim files
	rm -rf ~/.config/nvim/lazy-lock.json ~/.local/state/nvim ~/.local/share/nvim ~/.cache/nvim

nvim/clear/backups: ## Removes all nvim backups
	mv ~/.local/share/nvim{,.bak}
	mv ~/.local/state/nvim{,.bak}
	mv ~/.cache/nvim{,.bak}

.PHONY: nvim/purge
nvim/purge: nvim/clear nvim/clear/backups ## Removes all nvim files and backups

nvim/brew/uninstall: ## UNINSTALLS brew dependencies
	$(foreach p,$(BREW_NEOVIM_FORMULAES_OPT), brew uninstall $(p) || true;)

nvim/brew/uninstall/neovim: ## UNINSTALLS neovim
	$(foreach p,$(BREW_NEOVIM_FORMULAES_CORE), brew uninstall --ignore-dependencies $(p) || true;)
	$(foreach p,$(BREW_NEOVIM_FORMULAES_CORE_HEAD_UNLINKED), brew unlink $(p) && brew uninstall $(p) || true;)
	$(foreach p,$(BREW_NEOVIM_FORMULAES_FOLDERS_TO_RM), rm -rf $(p) || true;)

nvim/pip/uninstall: ## UNINSTALLS pip3 requirements
	rm -rf .venv

nvim/gem/uninstall: ## UNINSTALLS gem requirements
	gem uninstall neovim rubocop

nvim/npm/uninstall: ## UNINSTALLS NPM requirements
	npm -g uninstall neovim @mermaid-js/mermaid-cli

nvim/deps/uninstall: nvim/pip/uninstall nvim/gem/uninstall nvim/npm/uninstall ## UNINSTALLS neovim and all dependencies

.PHONY: nvim/uninstall
nvim/uninstall: nvim/brew/uninstall nvim/brew/uninstall/neovim nvim/deps/uninstall nvim/purge ## UNINSTALLS neovim and all dependencies
	brew autoremove && brew update && brew upgrade && brew upgrade --cask && brew cleanup --prune=all && brew doctor

.PHONY: nvim/reinstall
nvim/reinstall: nvim/uninstall nvim/install ## Clear Install and Compile Packer plugins

.PHONY: nvim/help
nvim/help: ## Display available tasks
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z\-_0-9%:\/]+:.*?## / {printf "\033[36m%-30s→\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sed s/://