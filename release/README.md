# GitHub Action Release

<!-- prettier-ignore-start -->
<!-- action-docs-description source="action.yaml" -->
## Description

GitHub Action that publishes a new release.
<!-- action-docs-description source="action.yaml" -->
<!-- prettier-ignore-end -->

## Configuration

### Step1: Set any [Semantic Release Configuration](https://github.com/semantic-release/semantic-release/blob/master/docs/usage/configuration.md#configuration) in your repository.

### Step2: [Add Secrets](https://help.github.com/en/actions/configuring-and-managing-workflows/creating-and-storing-encrypted-secrets) in your repository for the [Semantic Release Authentication](https://github.com/semantic-release/semantic-release/blob/master/docs/usage/ci-configuration.md#authentication) Environment Variables.

### Step3: Add a [Workflow File](https://help.github.com/en/articles/workflow-syntax-for-github-actions) to your repository to create custom automated processes.

## Usage

```yaml
steps:
  - name: Release
    uses: open-turo/actions-node/release@v3
    with:
      ## example value for github-token provided below
      github-token: ${{ secrets.GITHUB_TOKEN }}
      ## example value for npm-auth-token provided below
      npm-auth-token: ${{ secrets.NPM_AUTH_TOKEN }}
```

You can specify an S3 bucket to cache node_modules in order to speed up dependency installation, in which case you will need to configure AWS credentials like so:

```yaml
jobs:
  build:
    steps:
      - uses: aws-actions/configure-aws-credentials@v4
          with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
      - uses: open-turo/actions-node/release@v5
        with:
          github-token: ${{ secrets.GITHUB_TOKEN }}
          s3-bucket-name: <bucket-name>
          s3-bucket-region: <bucket-region>
```

**IMPORTANT**: `GITHUB_TOKEN` does not have the required permissions to operate on protected branches.
If you are using this action for protected branches, replace `GITHUB_TOKEN` with [Personal Access Token](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line). If using the `@semantic-release/git` plugin for protected branches, avoid persisting credentials as part of `actions/checkout@v3` by setting the parameter `persist-credentials: false`. This credential does not have the required permission to operate on protected branches.

<!-- prettier-ignore-start -->
<!-- action-docs-inputs source="action.yaml" -->
## Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `checkout-repo` | <p>Perform checkout as first step of action</p> | `false` | `true` |
| `build-script` | <p>Custom script to run, should be defined in package.json.</p> | `false` | `build` |
| `checkout-fetch-depth` | <p>The number of commits to fetch. 0 indicates all history for all branches and tags</p> | `false` | `0` |
| `github-token` | <p>GitHub token that can checkout the repository as well as create tags/releases against it. e.g. 'secrets.GITHUB_TOKEN'</p> | `true` | `${{ github.token }}` |
| `docker-cache` | <p>Whether to use Docker layer caching. Defaults to true.</p> | `false` | `true` |
| `docker-config-file` | <p>Path to the docker config file (defaults to .docker-config.json) Must contain imageName, may contain dockerfile.</p> | `false` | `.docker-config.json` |
| `docker-flavor` | <p>Docker flavor to use for docker metadata</p> | `false` | `latest=false ` |
| `dockerhub-user` | <p>username for dockerhub</p> | `false` | `""` |
| `dockerhub-password` | <p>password for dockerhub</p> | `false` | `""` |
| `image-platform` | <p>Target platform to build image for (eg. linux/amd64 (default), linux/arm64, etc)</p> | `false` | `""` |
| `npm-auth-token` | <p>The Node Package Manager (npm) authentication token. This token is used to authenticate against a private NPM registry configured via a .npmrc file.</p> | `false` | `""` |
| `npm-token` | <p>The Node Package Manager (npm) authentication token. This token is used to authenticate against the NPM registry.</p> | `false` | `""` |
| `image-platform` | <p>Target platform to build image for (eg. linux/amd64 (default), linux/arm64, etc)</p> | `false` | `linux/amd64` |
| `dry-run` | <p>Whether to run semantic release in <code>dry-run</code> mode. It will override the <code>dryRun</code> attribute in your configuration file</p> | `false` | `false` |
| `extra-plugins` | <p>Extra plugins for pre-install. You can also specify specifying version range for the extra plugins if you prefer.  Defaults to install @open-turo/semantic-release-config.</p> | `false` | `@open-turo/semantic-release-config ` |
| `s3-bucket-name` | <p>S3 bucket name to cache node_modules to speed up dependency installation.</p> | `false` | `""` |
| `s3-bucket-region` | <p>S3 bucket region to cache node_modules to speed up dependency installation.</p> | `false` | `""` |
<!-- action-docs-inputs source="action.yaml" -->
<!-- action-docs-outputs source="action.yaml" -->
## Outputs

| name | description |
| --- | --- |
| `new-release-published` | <p>Whether a new release was published</p> |
| `new-release-version` | <p>Version of the new release</p> |
| `new-release-major-version` | <p>Major version of the new release</p> |
<!-- action-docs-outputs source="action.yaml" -->
<!-- action-docs-runs source="action.yaml" -->
## Runs

This action is a `composite` action.
<!-- action-docs-runs source="action.yaml" -->
<!-- action-docs-usage source="action.yaml"  -->
<!-- prettier-ignore-end -->

## Additional Examples

### extra-plugins example

The Action can be used with `extra-plugins` option to specify plugins which are not in the [default list of plugins of semantic release](https://semantic-release.gitbook.io/semantic-release/usage/plugins#default-plugins). When using this option, please make sure that these plugins are also mentioned in your [semantic release config's plugins](https://semantic-release.gitbook.io/semantic-release/usage/configuration#plugins) array.

For example, if you want to use `@semantic-release/git` and `@semantic-release/changelog` extra plugins, these must be added to `extra-plugins` in your actions file and `plugins` in your [release config file](https://semantic-release.gitbook.io/semantic-release/usage/configuration#configuration-file) as shown bellow:

Github Action Workflow:

```yaml
steps:
  - name: Release
    uses: open-turo/actions-node/release@v1
    with:
      # You can specify specifying version range for the extra plugins if you prefer.
      github-token: ${{ secrets.GITHUB_TOKEN }}
      extra-plugins: |
        @semantic-release/changelog@3.0.0
        @semantic-release/git
```

Similar to parameter `semantic_version`. _It is recommended to manually specify a version of semantic-release plugins to prevent errors caused._

Release Config:

```diff
  plugins: [
    .
+   "@semantic-release/changelog"
+   "@semantic-release/git",
  ]
```

### dry-run example

```yaml
jobs:
  build:
    steps:
      - name: Release
        uses: open-turo/actions-node/release@v1
        with:
          dry-run: true
          github-token: ${{ secrets.GITHUB_TOKEN }}
```

### using output parameters example

```yaml
jobs:
  build:
    steps:
      - name: Release
        uses: open-turo/actions-node/release@v1
        id: semantic # Need an `id` for output variables
        with:
          github-token: ${{ secrets.GITHUB_TOKEN }}
      - name: Do something when a new release published
        if: steps.semantic.outputs.new-release-published == 'true'
        run: |
          echo ${{ steps.semantic.outputs.new-release-version }}
          echo ${{ steps.semantic.outputs.new-release-major-version }}
```

## Notes

- By default, this action will perform actions/checkout as its first step.
