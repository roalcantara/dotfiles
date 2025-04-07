.PHONY: setup/check
setup/check:
	@: # This is a "no-op" command that prevents the "Nothing to be done" message

.PHONY: alpine/prepare
alpine/prepare: ## Prepare ALPINE system environment
	$(info "[alpine] Installing system dependencies..")
	@command -v apk >/dev/null 2>&1 || { echo >&2 "[ERROR] apk is required but not installed. Aborting."; exit 1; }
	@sudo apk update && \
	sudo apk add --no-cache \
		curl \
		file \
		git \
		gpg \
		make \
		openssh-client \
		procps \
		sudo \
		&& sudo rm -rf /var/lib/apt/lists/* || { echo >&2 "[ERROR] Failed to install system dependencies"; exit 1; }
	$(info "[alpine] System dependencies installed ✔")