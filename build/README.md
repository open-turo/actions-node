# GitHub Action Lint

## Description

GitHub Action that lints a Node based repository

## Usage

```yaml
jobs:
  build:
    steps:
      - name: Lint
        uses: open-turo/actions-node/lint@v4
        with:
          ## example value for github-token provided below
          github-token: ${{ secrets.GITHUB_TOKEN }}
```

## Lint Checks

This action runs the following lint checks:

- [action-pre-commit](https://github.com/open-turo/action-pre-commit)
- eslint via npx
- beta release check - checks for beta versions of internal dependencies
- [lint-release-notes](https://github.com/open-turo/actions-release/tree/main/lint-release-notes)

## Notes

- By default, this action will perform actions/checkout as its first step.
- This expects that `.commitlintrc.yaml` will be present to enforce [`conventional-commit`](https://github.com/wagoid/commitlint-github-action).

<!-- prettier-ignore-start -->
<!-- action-docs-inputs -->
## Inputs

| parameter | description | required | default |
| --- | --- | --- | --- |
| checkout-repo | Perform checkout as first step of action | `false` | true |
| build-script | Custom script to run, should be defined in package.json. | `false` | build |
| github-token | GitHub token that can checkout the repository. e.g. 'secrets.GITHUB_TOKEN' | `true` | ${{ github.token }} |
| npm-auth-token | The Node Package Manager (npm) authentication token. This token is used to authenticate against a private NPM registry configured via a .npmrc file. | `false` |  |
| npm-token | The Node Package Manager (npm) authentication token. This token is used to authenticate against the NPM registry. | `false` |  |
<!-- action-docs-inputs -->
<!-- action-docs-outputs -->

<!-- action-docs-outputs -->
<!-- action-docs-runs -->
## Runs

This action is a `composite` action.
<!-- action-docs-runs -->
<!-- action-docs-usage  -->
<!-- action-docs-usage -->
<!-- prettier-ignore-end -->
