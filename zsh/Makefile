XDG_CONFIG_HOME ?= "$(HOME)/.config"
XDG_CACHE_HOME ?= "$(HOME)/.cache"
ZDOTDIR ?= "$(XDG_CONFIG_HOME)/zsh"

# ZIM installation directory
ZIM_HOME ?= "$(XDG_CACHE_HOME)/zim"
ZIM_URL := "https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh"

.PHONY: zim-install
zim/install:
	@echo "Installing ZIM framework..."
	@if [ ! -e "$(ZIM_HOME)/zimfw.zsh" ]; then \
		if command -v curl >/dev/null 2>&1; then \
			curl -fsSL --create-dirs -o "$(ZIM_HOME)/zimfw.zsh" "$(ZIM_URL)"; \
		else \
			mkdir -p "$(ZIM_HOME)" && wget -nv -O "$(ZIM_HOME)/zimfw.zsh" "$(ZIM_URL)"; \
		fi \
	fi
	@if [ ! "$(ZIM_HOME)/init.zsh" -nt "$(ZDOTDIR)/.zimrc" ]; then \
		. "$(ZIM_HOME)/zimfw.zsh" init -q; \
	fi
	@echo "ZIM framework installed successfully!"
