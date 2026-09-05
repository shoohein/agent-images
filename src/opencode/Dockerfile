ARG BASE_IMAGE_REPO=agent/base
ARG BASE_IMAGE_TAG=local
FROM ${BASE_IMAGE_REPO}:${BASE_IMAGE_TAG}

ARG VERSION=latest

USER root
RUN PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=1 PUPPETEER_SKIP_DOWNLOAD=1 \
    npm install -g @opencode-ai/cli@${VERSION} --omit=dev --no-audit --no-fund \
    && npm cache clean --force \
    && rm -rf /root/.npm

COPY --chmod=0755 entrypoint.sh /usr/local/bin/entrypoint.sh

USER agent
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["opencode2"]
