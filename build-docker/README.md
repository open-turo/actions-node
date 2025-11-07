# GitHub Action Build Docker

<!-- prettier-ignore-start -->
<!-- action-docs-description source="action.yaml"  -->
<!-- prettier-ignore-end -->

## Usage

This action will build and publish a docker image with appropriate tags.

It assumes that the repo has a configuration file in `<repo-root>/.docker-config.json` with the following properties:

- `imageName`: the image name (org/image-name)
- `dockerfile`: the path to the dockerfile to build - defaults to `./Dockerfile`

Example:

```json
{
  "imageName": "turo/hello-world-msvc",
  "dockerfile": "./Dockerfile"
}
```

#### Basic Usage:

```yaml
steps:
  - uses: open-turo/actions-node/release@v4
    name: Release
    id: release
    with:
      checkout-repo: true
      github-token: ${{ secrets.GITHUB_TOKEN }}
      dry-run: false
  - uses: open-turo/actions-jvm/build-docker@v1
    id: docker-build
    with:
      dockerhub-user: ${{ secrets.DOCKER_USERNAME }}
      dockerhub-password: ${{ secrets.DOCKER_PASSWORD }}
      github-token: ${{ secrets.GITHUB_TOKEN }}
      image-version: ${{ steps.release.outputs.new-release-version }}
      docker-metadata-tags: |
        type=ref,event=branch
        type=ref,event=pr
        type=semver,pattern={{version}},value=${{ steps.release.outputs.new-release-version }}
```

#### Multi-Architecture Builds:

When building for multiple architectures in parallel (e.g., ARM64 and AMD64), this action automatically manages separate Docker layer caches for each architecture to prevent cache conflicts.

```yaml
build-arm64:
  steps:
    - uses: open-turo/actions-node/build-docker@v7
      with:
        dockerhub-user: ${{ secrets.DOCKER_USERNAME }}
        dockerhub-password: ${{ secrets.DOCKER_PASSWORD }}
        github-token: ${{ secrets.GITHUB_TOKEN }}
        image-version: ${{ steps.release.outputs.new-release-version }}
        image-platform: linux/arm64/v8 # Uses cache key: buildcache-arm64-v8
        docker-cache: true

build-amd64:
  steps:
    - uses: open-turo/actions-node/build-docker@v7
      with:
        dockerhub-user: ${{ secrets.DOCKER_USERNAME }}
        dockerhub-password: ${{ secrets.DOCKER_PASSWORD }}
        github-token: ${{ secrets.GITHUB_TOKEN }}
        image-version: ${{ steps.release.outputs.new-release-version }}
        image-platform: linux/amd64 # Uses cache key: buildcache-amd64
        docker-cache: true
```

**How it works:**

- The action automatically derives a cache suffix from the `image-platform` input
- Each architecture gets its own dedicated cache location (e.g., `buildcache-amd64`, `buildcache-arm64-v8`)
- Parallel builds no longer conflict or overwrite each other's caches
- Cache hit rates improve significantly for multi-architecture workflows

<!-- prettier-ignore-start -->
<!-- action-docs-inputs source="action.yaml" -->
## Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `docker-config-file` | <p>Path to the docker config file (defaults to .docker-config.json) Must contain imageName, may contain dockerfile.</p> | `false` | `.docker-config.json` |
| `docker-flavor` | <p>Docker flavor to use for docker metadata</p> | `false` | `latest=false ` |
| `docker-push` | <p>Whether to push the image to the registry. Defaults to true.</p> | `false` | `true` |
| `docker-cache` | <p>Whether to use Docker layer caching. Defaults to true.</p> | `false` | `true` |
| `dockerhub-user` | <p>username for dockerhub</p> | `true` | `""` |
| `dockerhub-password` | <p>password for dockerhub</p> | `true` | `""` |
| `github-token` | <p>Usually secrets.GITHUB_TOKEN</p> | `true` | `""` |
| `npm-auth-token` | <p>The Node Package Manager (npm) authentication token. This token is used to authenticate against a private NPM registry configured via a .npmrc file. Gets pass to the docker build as a secret</p> | `false` | `""` |
| `npm-token` | <p>The Node Package Manager (npm) authentication token. This token is used to authenticate against the NPM registry. Gets passed to the docker build as a secret</p> | `false` | `""` |
| `image-version` | <p>Docker image version</p> | `true` | `""` |
| `image-platform` | <p>Target platform to build image for (eg. linux/amd64 (default), linux/arm64, etc)</p> | `false` | `linux/amd64` |
| `docker-metadata-tags` | <p>'List of tags as key-value pair attributes' See: https://github.com/docker/metadata-action#tags-input</p> | `false` | `""` |
<!-- action-docs-inputs source="action.yaml" -->
<!-- action-docs-outputs source="action.yaml"  -->

## Outputs

| parameter      | description                                                            |
| -------------- | ---------------------------------------------------------------------- |
| cache-key      | The cache key used for Docker layer caching (architecture-specific)    |
| image-digest   | The digest for the docker image                                        |
| image-name     | Docker image name                                                      |
| image-with-tag | Full image with tag - <image-name>:<image-version>                     |

<!-- action-docs-runs source="action.yaml"  -->

## Runs

This action is a `composite` action.

<!-- action-docs-usage source="action.yaml"   -->
<!-- prettier-ignore-end -->
