# GitHub Action Release

GitHub Action for [Semantic Release][semantic-url].

## Usage

Note: by default, this action will perform actions/checkout as its first step.

### Step1: Set any [Semantic Release Configuration](https://github.com/semantic-release/semantic-release/blob/master/docs/usage/configuration.md#configuration) in your repository.

### Step2: [Add Secrets](https://help.github.com/en/actions/configuring-and-managing-workflows/creating-and-storing-encrypted-secrets) in your repository for the [Semantic Release Authentication](https://github.com/semantic-release/semantic-release/blob/master/docs/usage/ci-configuration.md#authentication) Environment Variables.

### Step3: Add a [Workflow File](https://help.github.com/en/articles/workflow-syntax-for-github-actions) to your repository to create custom automated processes.

#### Basic Usage:

```yaml
steps:
  - name: Action semantic release
    uses: open-turo/actions-node/release@v1
    with:
      github-token: ${{ secrets.GITHUB_TOKEN }}
```

**IMPORTANT**: `GITHUB_TOKEN` does not have the required permissions to operate on protected branches.
If you are using this action for protected branches, replace `GITHUB_TOKEN` with [Personal Access Token](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line). If using the `@semantic-release/git` plugin for protected branches, avoid persisting credentials as part of `actions/checkout@v2` by setting the parameter `persist-credentials: false`. This credential does not have the required permission to operate on protected branches.

### Inputs

|      Input Parameter       | Required | Description                                                                                                            |
| :------------------------: | :------: | ---------------------------------------------------------------------------------------------------------------------- |
|       checkout-repo        |  false   | Whether to perform repository checkout as first step or not                                                            |
|        github-token        |   true   | GitHub token that can checkout the repository as well as create tags/releases against it. e.g. 'secrets.GITHUB_TOKEN'" |
|        node-version        |   true   | The version of Node.js to setup and use with Yarn                                                                      |
| artifactory-npm-auth-token |   true   | The Node Package Manager (npm) authentication token recognized by Artifactory                                          |
|          dry-run           |  false   | Whether to run semantic release in `dry-run` mode. [[Details](#dry_run)]                                               |
|       extra-plugins        |  false   | Extra plugins for pre-install. [[Details](#extra_plugins)]                                                             |

#### extra-plugins

> {Optional Input Parameter} Extra plugins for pre-install.

The action can be used with `extra_plugins` option to specify plugins which are not in the [default list of plugins of semantic release](https://semantic-release.gitbook.io/semantic-release/usage/plugins#default-plugins). When using this option, please make sure that these plugins are also mentioned in your [semantic release config's plugins](https://semantic-release.gitbook.io/semantic-release/usage/configuration#plugins) array.

For example, if you want to use `@semantic-release/git` and `@semantic-release/changelog` extra plugins, these must be added to `extra_plugins` in your actions file and `plugins` in your [release config file](https://semantic-release.gitbook.io/semantic-release/usage/configuration#configuration-file) as shown bellow:

Github Action Workflow:

```yaml
steps:
  - name: Checkout
    uses: actions/checkout@v2
  - name: Action Semantic Release
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

#### dry-run

> {Optional Input Parameter} Whether to run semantic release in `dry-run` mode.<br>It will override the dryRun attribute in your configuration file.

```yaml
jobs:
  build:
    steps:
      - name: Checkout
        uses: actions/checkout@v2
        with:
          fetch-depth: 0
      - name: Action Semantic Release
        uses: open-turo/actions-node/release@v1
        with:
          dry-run: true
          github-token: ${{ secrets.GITHUB_TOKEN }}
```

### Outputs

|     Output Parameter      | Description                                                                                                                       |
| :-----------------------: | --------------------------------------------------------------------------------------------------------------------------------- |
|   new-release-published   | Whether a new release was published (`true` or `false`)                                                                           |
|    new-release-version    | Version of the new release. (e.g. `1.3.0`)                                                                                        |
| new-release-major-version | Major version of the new release. (e.g. `1`)                                                                                      |
|    new-release-channel    | The distribution channel on which the last release was initially made available (undefined for the default distribution channel). |

#### Using Output Variables:

```yaml
jobs:
  build:
    steps:
      - uses: open-turo/actions-node/release@v1
        id: release # Need an `id` for output variables
        with:
          fetch-depth: 0
      - name: Semantic Release
        uses: open-turo/actions-node/release@v1
        id: semantic # Need an `id` for output variables
        with:
          github-token: ${{ secrets.GITHUB_TOKEN }}

      - name: Do something when a new release published
        if: steps.release.outputs.new-release-published == 'true'
        run: |
          echo ${{ steps.semantic.outputs.new-release-version }}
          echo ${{ steps.semantic.outputs.new-release-major-version }}
```
