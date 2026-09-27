# One build: official Paperclip + Docker CLI + verified launcher repair.
FROM ghcr.io/paperclipai/paperclip:sha-d554c47
USER root
LABEL com.vts.purpose="paperclip-runtime"
# Refuse to overwrite an unexpected upstream launcher version.
RUN echo 'd2681e44c91cfd3384dbeac9bd6e520a511b53f86b8270c1a93cce8eaeed5571  /app/packages/adapters/codex-local/src/server/execute.ts' | sha256sum -c - && \
    echo 'bafc66cd31eeccf714824267aee9f75563842a12c823cf60717c5397c7228a47  /app/packages/adapter-utils/src/acpx-engine/execute.ts' | sha256sum -c -
RUN apt-get update \
    && apt-get install -y --no-install-recommends docker-cli \
    && rm -rf /var/lib/apt/lists/*
COPY --chown=node:node codex-execute.ts /app/packages/adapters/codex-local/src/server/execute.ts
COPY --chown=node:node acp-execute.ts /app/packages/adapter-utils/src/acpx-engine/execute.ts
RUN echo '88162843ff3719d124ea4a64d4ac31dc752b14fb62bcbe8a429120ee41caa7cb  /app/packages/adapters/codex-local/src/server/execute.ts' | sha256sum -c - && \
    echo '7ca365eb7b9c5d7c0e3d57e2d62fbda61254d27b0e936963b4e1af07daafad19  /app/packages/adapter-utils/src/acpx-engine/execute.ts' | sha256sum -c -
USER node
