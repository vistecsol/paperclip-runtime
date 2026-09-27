# Paperclip Runtime

This replaces the separate Docker-CLI wrapper and repair image with one Dockerfile based directly on the tagged official Paperclip image. It includes Docker CLI and both repaired launcher modules. The upstream entrypoint and command are inherited; runtime user is node.

Build from this directory:

```sh
docker build --pull=false -t vts-figma-test-paperclip-runtime:0.1.0-preview.1 .
```

No intermediate paperclip-with-docker or launcher-repair image is required. The four files in this bundle must remain together. The Dockerfile verifies original launcher hashes before copying, and repaired hashes afterward. A hash mismatch stops the build: do not bypass it or change the base tag without reviewing compatibility.

Validation: packaged repair hashes match the previously tested full ACP/CLI repair. Static recipe checks passed. This combined recipe has not yet been built or runtime-tested; the prior separate repair image passed isolated readiness in 28 seconds. That result does not certify this new build.

This is the launcher repair, not the unfinished Figma plugin. No production switch or agent restart is performed by preparing this bundle. Elena owns isolated build verification and subsequent application-only recovery on VIS-9 under the existing authorization. Production database/proxy/storage remain protected. Isolated tests require vts-figma-test-* resources, verified ownership, fresh storage, no Docker-socket or production-storage mounts, effective CPU/RAM limits, sequential heavy checks, and adequate host headroom.

Base tag: ghcr.io/paperclipai/paperclip:sha-d554c47. Verified against the GHCR manifest on 27 September 2026: this tag resolves to the previously selected base. The image reports version 2026.916.1. No digest is used in FROM. The combined recipe remains unbuilt and undeployed.

## Repository and version

Canonical repository: https://github.com/vistecsol/paperclip-runtime. Initial version: `0.1.0-preview.1`. The Figma plugin is maintained separately at https://github.com/vistecsol/paperclip-figma-integration.

The launcher repair removes the redundant oversized history environment entry while retaining full history on stdin. Files were imported unchanged from the tagged build bundle recorded on VTS task VIS-5, attachment `a3292168-1d36-434b-8e40-6bb7f18407f5`. Upstream source: https://github.com/paperclipai/paperclip. Review upstream licensing for the copied adapter sources before redistribution.
