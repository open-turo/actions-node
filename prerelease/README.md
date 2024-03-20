# GitHub Action: Prerelease

<!-- prettier-ignore-start -->
<!-- action-docs-description source="action.yaml" -->
## Description

< GitHub Action to compute a prerelease version based on the latest release version and the number of commits since the latest release. Meant to only be run in the context of a pull request. This will also generate a docker tag based on the computed version if the label `prerelease` is specified on the PR and docker credentials are present
<!-- action-docs-description -->
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

| parameter | description | required | default |
| --- | --- | --- | --- |
| checkout-repo | Perform checkout as first step of action | `false` | true |
| checkout-fetch-depth | The number of commits to fetch. 0 indicates all history for all branches and tags | `false` | 0 |
| create-prerelease | Whether semantic-release should create a prerelease or do a dry run. This can be useful to set to true when a prerelease requires pushing artifacts semantic-release is in charge of generating | `false` | false |
| github-token | GitHub token that can checkout the repository as well as create tags/releases against it. e.g. 'secrets.GITHUB_TOKEN' | `true` | ${{ github.token }} |
| docker-config-file | Path to the docker config file (defaults to .docker-config.json) Must contain imageName, may contain dockerfile. | `false` | .docker-config.json |
| dockerhub-user | username for dockerhub | `false` |  |
| dockerhub-password | password for dockerhub | `false` |  |
| npm-auth-token | The Node Package Manager (npm) authentication token. This token is used to authenticate against a private NPM registry configured via a .npmrc file. | `false` |  |
| npm-token | The Node Package Manager (npm) authentication token. This token is used to authenticate against the NPM registry. | `false` |  |
| extra-plugins | Extra plugins for pre-install. You can also specify specifying version range for the extra plugins if you prefer.  Defaults to install @open-turo/semantic-release-config. | `false` | @open-turo/semantic-release-config  |
<!-- action-docs-inputs -->

<!-- action-docs-outputs source="action.yaml" -->
## Outputs

| parameter | description |
| --- | --- |
| new-release-published | Whether a new release was published |
| new-release-version | Version of the new release |
| new-release-major-version | Major version of the new release |
| image-name | Docker image name |
| image-with-tag | Full image with tag - <image-name>:<image-version> |
| pull-request-number | Pull request number |
| run-url | URL to the GHA run |
<!-- action-docs-outputs -->

<!-- action-docs-runs source="action.yaml" -->
## Runs

This action is a `composite` action.
<!-- action-docs-runs -->

<!-- action-docs-usage source="action.yaml"  -->
<!-- action-docs-usage -->
<!-- prettier-ignore-end -->
