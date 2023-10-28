# GitHub Action Build Docker

<!-- prettier-ignore-start -->
<!-- action-docs-description -->
## Description

Builds and push docker images for the input platform, tags and image version
<!-- action-docs-description -->
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

<!-- prettier-ignore-start -->
<!-- action-docs-inputs -->
## Inputs

| parameter | description | required | default |
| --- | --- | --- | --- |
| docker-config-file | Path to the docker config file (defaults to .docker-config.json) Must contain imageName, may contain dockerfile. | `false` | .docker-config.json |
| docker-flavor | Docker flavor to use for docker metadata | `false` | latest=false  |
| dockerhub-user | username for dockerhub | `true` |  |
| dockerhub-password | password for dockerhub | `true` |  |
| github-token | Usually secrets.GITHUB_TOKEN | `true` |  |
| npm-auth-token | The Node Package Manager (npm) authentication token. This token is used to authenticate against a private NPM registry configured via a .npmrc file. Gets pass to the docker build as a secret | `false` |  |
| npm-token | The Node Package Manager (npm) authentication token. This token is used to authenticate against the NPM registry. Gets passed to the docker build as a secret | `false` |  |
| image-version | Docker image version | `true` |  |
| image-platform | Target platform to build image for (eg. linux/amd64 (default), linux/arm64, etc) | `false` | linux/amd64 |
| docker-metadata-tags | 'List of tags as key-value pair attributes' See: https://github.com/docker/metadata-action#tags-input | `false` |  |
<!-- action-docs-inputs -->
<!-- action-docs-outputs -->
## Outputs

| parameter | description |
| --- | --- |
| image-name | Docker image name |
| image-with-tag | Full image with tag - <image-name>:<image-version> |
<!-- action-docs-outputs -->
<!-- action-docs-runs -->
## Runs

This action is a `composite` action.
<!-- action-docs-runs -->
<!-- action-docs-usage  -->
<!-- action-docs-usage -->
<!-- prettier-ignore-end -->
