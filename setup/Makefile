XDG_CONFIG_HOME 					= $(HOME)/Work/dotfiles
override DOTS_REPO_NAME     		?= roalcantara/dotfiles
override OS         				?= $(shell uname -s | tr '[:upper:]' '[:lower:]')
override DOCKER_IMAGE_NAME 			:= $(DOTS_REPO_NAME):$(OS)
override PLATFORM_DIR 				:= $(XDG_CONFIG_HOME)/setup/platforms/$(OS)

SUPPORTED_PLATFORMS := alpine
ifeq ($(filter $(OS),$(SUPPORTED_PLATFORMS)),)
    $(error "[ERROR] Unsupported platform: $(OS). Must be one of: $(SUPPORTED_PLATFORMS)")
endif

.PHONY: docker/check
docker/check:
	$(info "[$(OS)] Checking docker setup..")
	@command -v docker >/dev/null 2>&1 || { echo >&2 "[ERROR] docker is required but not installed. Aborting."; exit 1; }
	@test -f "$(PLATFORM_DIR)/Makefile" || { echo >&2 "[ERROR] $(PLATFORM_DIR)/Makefile NOT FOUND!"; exit 1; }
	@test -f "$(PLATFORM_DIR)/Dockerfile" || { echo >&2 "[ERROR] $(PLATFORM_DIR)/Dockerfile NOT FOUND!"; exit 1; }

# USAGE:
# - RUN `make docker/build OS=alpine` to build the Docker image for the OS Platform: ALPINE
.PHONY: docker/build
docker/build: docker/check ## BUILD environment
	$(info "[$(OS)] Building image $(DOCKER_IMAGE_NAME)..")
	@docker buildx build --no-cache --platform linux/amd64 \
		-t $(DOCKER_IMAGE_NAME) $(PLATFORM_DIR) || { echo >&2 "[ERROR] Failed to build docker image"; exit 1; }

# USAGE:
# - RUN `make docker/run OS=alpine` to run the Docker container for the OS Platform: ALPINE
.PHONY: docker/run
docker/run: docker/build ## BUILD and RUN Docker Container
	$(info "[$(OS)] Running container $(DOCKER_IMAGE_NAME)..")
	@cd $(PLATFORM_DIR) && docker run -it --rm $(DOCKER_IMAGE_NAME) || { echo >&2 "[ERROR] Failed to run docker container"; exit 1; }

# USAGE:
# - RUN `make setup/prepare OS=alpine` to prepare the environment for the OS: ALPINE
.PHONY: setup/prepare
setup/prepare: ## Prepare the minimal settings and configurations for the OS (darwin|debian|alpine)
	@$(MAKE) -C $(PLATFORM_DIR) $(OS)/prepare || { echo >&2 "[ERROR] Failed to prepare environment"; exit 1; }
	$(info "[$(OS)] Environment prepared ✔")