FROM debian:trixie-slim

# User ID and Group ID for agent
ARG UID=1000
ARG GID=1000
ARG WORKDIR=/workspace

# Prepare NodeSource repository keys
# - curl/gnupg/openssl are used to securely add the NodeSource apt repository
# - Node.js installation itself is done in the next RUN block
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
       ca-certificates curl gnupg openssl \
    && mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key -o /tmp/nodesource.gpg.key \
    && gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg /tmp/nodesource.gpg.key \
    && rm -f /tmp/nodesource.gpg.key \
    && chmod 644 /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_22.x nodistro main" \
        >/etc/apt/sources.list.d/nodesource.list \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install runtimes and common tools for agent workflows
# - nodejs/python3: runtime for agent CLIs and helper scripts
# - keep python3 only; pip/venv/dev headers are intentionally omitted
# - git/sudo/jq: repository and shell operations
# - ripgrep/fd-find/less/tree: investigation and navigation
# - make/zip/unzip/time: build, packaging, and profiling helpers
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        nodejs python3 git sudo jq \
        ripgrep fd-find less tree make zip unzip time \
    && ln -sf /usr/bin/fdfind /usr/local/bin/fd \
    && apt-get purge -y --auto-remove gnupg \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Go-based yq (YAML/JSON/XML/CSV/TOML processor)
ARG TARGETARCH
RUN arch=${TARGETARCH:-$(uname -m)} && \
    case "$arch" in \
        amd64|x86_64) yq_arch="amd64" ;; \
        arm64|aarch64) yq_arch="arm64" ;; \
        *) echo "Unsupported architecture: $arch"; exit 1 ;; \
    esac && \
    curl -fsSL "https://github.com/mikefarah/yq/releases/latest/download/yq_linux_${yq_arch}" \
        -o /usr/local/bin/yq && \
    chmod +x /usr/local/bin/yq

# Create agent user
RUN groupadd -g ${GID} agent \
    && useradd -ml -u ${UID} -g ${GID} agent

WORKDIR ${WORKDIR}
USER agent
