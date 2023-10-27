# GitHub Action Test

## Description

GitHub Action that tests a node based repository

## Usage

```yaml
jobs:
  test:
    steps:
      - name: Test
        uses: open-turo/actions-node/test@v3
        with:
          ## example value for github-token provided below
          github-token: ${{ secrets.GITHUB_TOKEN }}
```

## Notes

- By default, this action will perform actions/checkout as its first step.

<!-- prettier-ignore-start -->
<!-- action-docs-inputs -->
## Inputs

| parameter | description | required | default |
| --- | --- | --- | --- |
| checkout-repo | Perform checkout as first step of action | `false` | true |
| github-token | GitHub token that can checkout the repository. e.g. 'secrets.GITHUB_TOKEN' | `true` | ${{ github.token }} |
| npm-auth-token | The Node Package Manager (npm) authentication token. This token is used to authenticate against a private NPM registry configured via a .npmrc file. | `false` |  |
| npm-token | The Node Package Manager (npm) authentication token. This token is used to authenticate against the NPM registry. | `false` |  |
| test-flags | Flags and args for test command | `false` |  |
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
