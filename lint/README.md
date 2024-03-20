# GitHub Action Lint

<!-- prettier-ignore-start -->
<!-- action-docs-description source="action.yaml" -->
## Description

GitHub Action that lints a Node based repository
<!-- action-docs-description source="action.yaml" -->
<!-- prettier-ignore-end -->

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
<!-- action-docs-inputs source="action.yaml" -->
## Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `checkout-repo` | <p>Perform checkout as first step of action</p> | `false` | `true` |
| `lint-script` | <p>Custom script to run, should be defined in package.json.</p> | `false` | `lint` |
| `github-token` | <p>GitHub token that can checkout the repository. e.g. 'secrets.GITHUB_TOKEN'</p> | `true` | `${{ github.token }}` |
| `npm-auth-token` | <p>The Node Package Manager (npm) authentication token. This token is used to authenticate against a private NPM registry configured via a .npmrc file.</p> | `false` | `""` |
| `npm-token` | <p>The Node Package Manager (npm) authentication token. This token is used to authenticate against the NPM registry.</p> | `false` | `""` |
| `internal-dependency-prefixes` | <p>Prefixes used to match internal dependencies and disallow beta versions. Can take comma-separated values e.g. '@turo,@example'.</p> | `false` | `""` |
<!-- action-docs-inputs source="action.yaml" -->
<!-- action-docs-outputs source="action.yaml" -->

<!-- action-docs-outputs source="action.yaml" -->
<!-- action-docs-runs source="action.yaml" -->
## Runs

This action is a `composite` action.
<!-- action-docs-runs source="action.yaml" -->
<!-- action-docs-usage source="action.yaml"  -->
<!-- prettier-ignore-end -->
