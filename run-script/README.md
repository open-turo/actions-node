# GitHub Action Run Script

<!-- prettier-ignore-start -->
<!-- action-docs-description -->

## Description

GitHub Action that installs dependencies and runs a script in a Node based repository

<!-- action-docs-description -->
<!-- prettier-ignore-end -->

## Usage

```yaml
jobs:
  build:
    steps:
      - name: Run script
        uses: open-turo/actions-node/run-script@v7
        with:
          script: build
          ## example value for github-token provided below
          github-token: ${{ secrets.GITHUB_TOKEN }}
```

You can pass additional flags to the script:

```yaml
jobs:
  test:
    steps:
      - name: Run tests
        uses: open-turo/actions-node/run-script@v7
        with:
          script: test
          script-flags: --coverage
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
      - uses: open-turo/actions-node/run-script@v7
        with:
          script: build
          github-token: ${{ secrets.GITHUB_TOKEN }}
          s3-bucket-name: <bucket-name>
          s3-bucket-region: <bucket-region>
```

## Notes

- By default, this action will perform actions/checkout as its first step.
- The `script` input should correspond to a script defined in your `package.json`.
- For npm, flags are passed after `--` (e.g. `npm run test -- --coverage`). For yarn, flags are appended directly.

<!-- prettier-ignore-start -->
<!-- action-docs-inputs source="action.yaml" -->
## Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `checkout-repo` | <p>Perform checkout as first step of action</p> | `false` | `true` |
| `script` | <p>Script to run, should be defined in package.json.</p> | `true` | `""` |
| `script-flags` | <p>Additional flags and args to pass to the script.</p> | `false` | `""` |
| `github-token` | <p>GitHub token that can checkout the repository. e.g. 'secrets.GITHUB_TOKEN'</p> | `true` | `${{ github.token }}` |
| `npm-auth-token` | <p>The Node Package Manager (npm) authentication token. This token is used to authenticate against a private NPM registry configured via a .npmrc file.</p> | `false` | `""` |
| `npm-token` | <p>The Node Package Manager (npm) authentication token. This token is used to authenticate against the NPM registry.</p> | `false` | `""` |
| `s3-bucket-name` | <p>S3 bucket name to cache node_modules to speed up dependency installation.</p> | `false` | `""` |
| `s3-bucket-region` | <p>S3 bucket region to cache node_modules to speed up dependency installation.</p> | `false` | `""` |
<!-- action-docs-inputs source="action.yaml" -->
<!-- action-docs-outputs source="action.yaml" -->

<!-- action-docs-outputs source="action.yaml" -->
<!-- action-docs-runs source="action.yaml" -->
## Runs

This action is a `composite` action.
<!-- action-docs-runs source="action.yaml" -->
<!-- prettier-ignore-end -->
