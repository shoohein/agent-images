.PHONY: build-base build-opencode build-codex-cli build-claude-code build-copilot build-all build-all-force

DOCKER_BUILD_BASE_FLAGS ?=
DOCKER_BUILD_AGENT_FLAGS ?=
ifeq ($(FORCE),1)
DOCKER_BUILD_BASE_FLAGS += --no-cache --pull
DOCKER_BUILD_AGENT_FLAGS += --no-cache
endif

BASE_IMAGE_REPO ?= agent/base
BASE_IMAGE_TAG ?= local
BASE_IMAGE_NAME ?= $(BASE_IMAGE_REPO):$(BASE_IMAGE_TAG)
AGENT_BASE_BUILD_ARGS = --build-arg BASE_IMAGE_REPO=$(BASE_IMAGE_REPO) --build-arg BASE_IMAGE_TAG=$(BASE_IMAGE_TAG)

OPENCODE_VERSION ?= latest
OPENCODE_IMAGE_NAME ?= agent/opencode:$(OPENCODE_VERSION)

CODEX_CLI_VERSION ?= latest
CODEX_CLI_IMAGE_NAME ?= agent/codex:$(CODEX_CLI_VERSION)

CLAUDE_CODE_VERSION ?= latest
CLAUDE_CODE_IMAGE_NAME ?= agent/claude:$(CLAUDE_CODE_VERSION)

COPILOT_VERSION ?= latest
COPILOT_IMAGE_NAME ?= agent/copilot:$(COPILOT_VERSION)

build-base:
	docker build $(DOCKER_BUILD_BASE_FLAGS) -f src/base/Dockerfile -t $(BASE_IMAGE_NAME) src/base

build-opencode: build-base
	docker build $(DOCKER_BUILD_AGENT_FLAGS) \
		-f src/opencode/Dockerfile \
		$(AGENT_BASE_BUILD_ARGS) \
		--build-arg VERSION=$(OPENCODE_VERSION) \
		-t $(OPENCODE_IMAGE_NAME) \
		src/opencode

build-codex-cli: build-base
	docker build $(DOCKER_BUILD_AGENT_FLAGS) \
		-f src/codex/Dockerfile \
		$(AGENT_BASE_BUILD_ARGS) \
		--build-arg VERSION=$(CODEX_CLI_VERSION) \
		-t $(CODEX_CLI_IMAGE_NAME) \
		src/codex

build-claude-code: build-base
	docker build $(DOCKER_BUILD_AGENT_FLAGS) \
		-f src/claude/Dockerfile \
		$(AGENT_BASE_BUILD_ARGS) \
		--build-arg VERSION=$(CLAUDE_CODE_VERSION) \
		-t $(CLAUDE_CODE_IMAGE_NAME) \
		src/claude

build-copilot: build-base
	docker build $(DOCKER_BUILD_AGENT_FLAGS) \
		-f src/copilot/Dockerfile \
		$(AGENT_BASE_BUILD_ARGS) \
		--build-arg VERSION=$(COPILOT_VERSION) \
		-t $(COPILOT_IMAGE_NAME) \
		src/copilot

build-all: build-base build-opencode build-codex-cli build-claude-code build-copilot
build-all-force:
	$(MAKE) build-all FORCE=1
