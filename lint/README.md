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
        uses: open-turo/actions-node/lint@v5
        with:
          ## example value for github-token provided below
          github-token: ${{ secrets.GITHUB_TOKEN }}
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
      - uses: open-turo/actions-node/lint@v5
        with:
          github-token: ${{ secrets.GITHUB_TOKEN }}
          s3-bucket-name: <bucket-name>
          s3-bucket-region: us-east-1
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
| `pre-commit-skip-hooks` | <p>Comma separate list of pre-commit hooks to skip. e.g. 'eslint,prettier'</p> | `false` | `eslint` |
| `github-token` | <p>GitHub token that can checkout the repository. e.g. 'secrets.GITHUB_TOKEN'</p> | `true` | `${{ github.token }}` |
| `npm-auth-token` | <p>The Node Package Manager (npm) authentication token. This token is used to authenticate against a private NPM registry configured via a .npmrc file.</p> | `false` | `""` |
| `npm-token` | <p>The Node Package Manager (npm) authentication token. This token is used to authenticate against the NPM registry.</p> | `false` | `""` |
| `internal-dependency-prefixes` | <p>Prefixes used to match internal dependencies and disallow beta versions. Can take comma-separated values e.g. '@turo,@example'.</p> | `false` | `""` |
| `s3-bucket-name` | <p>S3 bucket name to cache node_modules to speed up dependency installation.</p> | `false` | `""` |
| `s3-bucket-region` | <p>S3 bucket region to cache node_modules to speed up dependency installation.</p> | `false` | `""` |
<!-- action-docs-inputs source="action.yaml" -->
<!-- action-docs-outputs source="action.yaml" -->

<!-- action-docs-outputs source="action.yaml" -->
<!-- action-docs-runs source="action.yaml" -->
## Runs

This action is a `composite` action.
<!-- action-docs-runs source="action.yaml" -->
<!-- action-docs-usage source="action.yaml"  -->
<!-- prettier-ignore-end -->
