#!/usr/bin/env bash
SHELL := /bin/bash
.SHELLFLAGS := -eu -o pipefail -c

## ENVIRONMENT VARIABLES
PACKAGE_MANAGER := brew
HOMEBREW_URL := https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
HOMEBREW_PREFIX = $(shell if [ -d "/opt/homebrew" ]; then echo "/opt/homebrew"; elif [ -d "/home/linuxbrew/.linuxbrew" ]; then echo "/home/linuxbrew/.linuxbrew"; else echo "/usr/local"; fi)
BREW = $(HOMEBREW_PREFIX)/bin/brew
BREW_FILE = $(HOME)/.config/homebrew/Brewfile

## FUNCTIONS
define _log
	@echo " $(1) [$(OS)/$(ARCH)] $(2)"
endef
define log # Usage: $(call log, "Hello, world!")
	$(call _log,info,$(1))
endef
define warn # Usage: $(call warn, "Hello, world!")
	$(call _log,warn,$(1))
endef
define err # Usage: $(call err, "Hello, world!")
	$(call _log,err ,$(1))
endef
define get_zsh_path
	$(shell eval "$$($(BREW) shellenv)" && which zsh)
endef
define with_pkgs
	@eval "$$($(BREW) shellenv)" \
		&& echo "[INFO] ($(OS)/$(ARCH)) $(PACKAGE_MANAGER) environment loaded via with_pkgs ✔"
endef

.PHONY: brew/setup brew/install brew/update brew/clean brew/load brew/dump brew/bundle brew/check

brew/setup: ## Install homebrew if not already installed
	@$(call log,Homebrew: Installing... $(HOMEBREW_URL))
	@if command -v brew >/dev/null; then \
		echo "[INFO] ($(OS)/$(ARCH)) Homebrew is already installed"; \
	else \
		NONINTERACTIVE=1 /bin/bash -c "$$(curl -fsSL $(HOMEBREW_URL))" && \
		if command -v brew >/dev/null; then \
			eval "$$($(BREW) shellenv)"; \
		fi && \
		echo "[INFO] ($(OS)/$(ARCH)) Homebrew: Installed successfully ✔✔"; \
	fi

brew/load: ## Load the packer environment
	@eval "$$($(BREW) shellenv)" \
		&& echo "[INFO] ($(OS)/$(ARCH)) $(PACKAGE_MANAGER) environment loaded via brew/load ✔"

brew/install: brew/load ## Install packages with Homebrew
	@$(call log,Brewfile: Installing packages from $(BREW_FILE)...)
	@if [[ ! -f "$(BREW_FILE)" ]]; then \
		echo "[ERROR] ($(OS)/$(ARCH)) Brewfile not found at $(BREW_FILE)"; \
		exit 1; \
	fi
	@$(BREW) bundle --file=$(BREW_FILE) \
		&& echo "[INFO] ($(OS)/$(ARCH)) Brewfile: Packages installed successfully ✔✔"

brew/update: brew/load ## Update packages using Homebrew
	@$(call log,Updating Homebrew and packages...)
	@$(BREW) update \
		&& $(BREW) upgrade \
		&& $(BREW) cleanup \
		&& $(BREW) bundle --file=$(BREW_FILE)

brew/clean: brew/load ## Clean up Homebrew packages
	@$(call log,Cleaning up Homebrew packages...)
	@$(BREW) autoremove \
		&& $(BREW) update \
		&& $(BREW) upgrade \
		&& $(BREW) upgrade --cask \
		&& $(BREW) cleanup --prune=all \
		&& $(BREW) doctor

brew/dump: brew/load ## Generate a Brewfile from currently installed packages
	@$(call log,Dumping currently installed Homebrew packages to Brewfile at $(BREW_FILE)...)
	@if [[ ! -f "$(BREW_FILE)" ]]; then \
		echo "[ERROR] ($(OS)/$(ARCH)) Brewfile not found at $(BREW_FILE)"; \
		exit 1; \
	fi
	@$(BREW) bundle dump --file=$(BREW_FILE) --force
	@$(call log,Brewfile created at $(BREW_FILE) ✔)

brew/bundle: brew/load ## Install packages from Brewfile
	@$(call log,Installing packages from Brewfile at $(BREW_FILE)...)
	@if [[ ! -f "$(BREW_FILE)" ]]; then \
		echo "[ERROR] ($(OS)/$(ARCH)) Brewfile not found at $(BREW_FILE)"; \
		exit 1; \
	fi
	@$(BREW) bundle --file=$(BREW_FILE)
	@$(call log,Brewfile: Packages installed successfully ✔)

brew/check: brew/load ## Check for differences between Brewfile and installed packages
	@$(call log,Checking Brewfile against installed packages at $(BREW_FILE)...)
	@if [[ ! -f "$(BREW_FILE)" ]]; then \
		echo "[ERROR] ($(OS)/$(ARCH)) Brewfile not found at $(BREW_FILE)"; \
		exit 1; \
	fi
	@$(BREW) bundle check --file=$(BREW_FILE)
	@$(call log,Brewfile: Packages checked successfully ✔)
