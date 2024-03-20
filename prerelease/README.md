# GitHub Action: Prerelease

<!-- prettier-ignore-start -->
<!-- action-docs-description source="action.yaml" -->
## Description

< GitHub Action to compute a prerelease version based on the latest release version and the number of commits since the latest release. Meant to only be run in the context of a pull request. This will also generate a docker tag based on the computed version if the label `prerelease` is specified on the PR and docker credentials are present
<!-- action-docs-description source="action.yaml" -->
<!-- prettier-ignore-end -->

## Configuration

### Step1: Set any [Semantic Release Configuration](https://github.com/semantic-release/semantic-release/blob/master/docs/usage/configuration.md#configuration) in your repository.

### Step2: [Add Secrets](https://help.github.com/en/actions/configuring-and-managing-workflows/creating-and-storing-encrypted-secrets) in your repository for the [Semantic Release Authentication](https://github.com/semantic-release/semantic-release/blob/master/docs/usage/ci-configuration.md#authentication) Environment Variables.

### Step3: Add a [Workflow File](https://help.github.com/en/articles/workflow-syntax-for-github-actions) to your repository to create custom automated processes.

## Usage

```yaml
steps:
  - name: Action semantic release
    uses: open-turo/actions-node/prerelease@v5
    with:
      github-token: ${{ secrets.GITHUB_TOKEN }}
```

**IMPORTANT**: `GITHUB_TOKEN` does not have the required permissions to operate on protected branches.
If you are using this action for protected branches, replace `GITHUB_TOKEN`
with [Personal Access Token](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line).
If using the `@semantic-release/git` plugin for protected branches, avoid persisting credentials as part
of `actions/checkout@v4` by setting the parameter `persist-credentials: false`. This credential does not have the
required permission to operate on protected branches.

<!-- prettier-ignore-start -->
<!-- action-docs-inputs source="action.yaml" -->
## Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `checkout-repo` | <p>Perform checkout as first step of action</p> | `false` | `true` |
| `checkout-fetch-depth` | <p>The number of commits to fetch. 0 indicates all history for all branches and tags</p> | `false` | `0` |
| `create-prerelease` | <p>Whether semantic-release should create a prerelease or do a dry run. This can be useful to set to true when a prerelease requires pushing artifacts semantic-release is in charge of generating</p> | `false` | `false` |
| `github-token` | <p>GitHub token that can checkout the repository as well as create tags/releases against it. e.g. 'secrets.GITHUB_TOKEN'</p> | `true` | `${{ github.token }}` |
| `docker-config-file` | <p>Path to the docker config file (defaults to .docker-config.json) Must contain imageName, may contain dockerfile.</p> | `false` | `.docker-config.json` |
| `dockerhub-user` | <p>username for dockerhub</p> | `false` | `""` |
| `dockerhub-password` | <p>password for dockerhub</p> | `false` | `""` |
| `npm-auth-token` | <p>The Node Package Manager (npm) authentication token. This token is used to authenticate against a private NPM registry configured via a .npmrc file.</p> | `false` | `""` |
| `npm-token` | <p>The Node Package Manager (npm) authentication token. This token is used to authenticate against the NPM registry.</p> | `false` | `""` |
| `extra-plugins` | <p>Extra plugins for pre-install. You can also specify specifying version range for the extra plugins if you prefer.  Defaults to install @open-turo/semantic-release-config.</p> | `false` | `@open-turo/semantic-release-config ` |
<!-- action-docs-inputs source="action.yaml" -->
<!-- action-docs-outputs source="action.yaml" -->
## Outputs

| name | description |
| --- | --- |
| `new-release-published` | <p>Whether a new release was published</p> |
| `new-release-version` | <p>Version of the new release</p> |
| `new-release-major-version` | <p>Major version of the new release</p> |
| `image-name` | <p>Docker image name</p> |
| `image-with-tag` | <p>Full image with tag - <image-name>:<image-version></p> |
| `pull-request-number` | <p>Pull request number</p> |
| `run-url` | <p>URL to the GHA run</p> |
<!-- action-docs-outputs source="action.yaml" -->
<!-- action-docs-runs source="action.yaml" -->
## Runs

This action is a `composite` action.
<!-- action-docs-runs source="action.yaml" -->
<!-- prettier-ignore-end -->
