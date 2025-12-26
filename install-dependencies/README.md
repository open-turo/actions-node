# GitHub Action Install Dependencies

<!-- prettier-ignore-start -->
<!-- action-docs-description source="action.yaml" -->
## Description

GitHub Action that installs dependencies in a Node based repository
<!-- action-docs-description source="action.yaml" -->
<!-- prettier-ignore-end -->

## Usage

```yaml
jobs:
  build:
    steps:
      - name: Install Dependencies
        uses: open-turo/actions-node/install-dependencies@v5
        with:
          ## example value for github-token provided below
          github-token: ${{ secrets.GITHUB_TOKEN }}
          npm-token: ${{ secrets.NPM_TOKEN }}
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
      - uses: open-turo/actions-node/install-dependencies@v5
        with:
          github-token: ${{ secrets.GITHUB_TOKEN }}
          s3-bucket-name: <bucket-name>
          s3-bucket-region: us-east-1
```

## Notes

- By default, this action will perform actions/checkout as its first step.
- This action checks for `bun.lock`, `pnpm-lock.yaml`, `yarn.lock`, and `package-lock.json` to determine which package manager to use to install dependencies; it supports `bun`, `pnpm`, `yarn`, and `npm` (with priority given to bun, then pnpm, then yarn, then npm).

<!-- prettier-ignore-start -->
<!-- action-docs-inputs source="action.yaml" -->
## Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `checkout-repo` | <p>Perform checkout as first step of action</p> | `false` | `true` |
| `github-token` | <p>GitHub token that can checkout the repository. e.g. 'secrets.GITHUB_TOKEN'</p> | `true` | `${{ github.token }}` |
| `npm-auth-token` | <p>The Node Package Manager (npm) authentication token. This token is used to authenticate against a private NPM registry configured via a .npmrc file.</p> | `false` | `""` |
| `npm-token` | <p>The Node Package Manager (npm) authentication token. This token is used to authenticate against the NPM registry.</p> | `false` | `""` |
| `s3-bucket-name` | <p>S3 bucket name to cache node_modules to speed up dependency installation.</p> | `false` | `""` |
| `s3-bucket-region` | <p>S3 bucket region to cache node_modules to speed up dependency installation.</p> | `false` | `""` |
<!-- action-docs-inputs source="action.yaml" -->
<!-- action-docs-outputs source="action.yaml" -->
## Outputs

| name | description |
| --- | --- |
| `cache-hit` | <p>Whether the cache was hit when installing dependencies</p> |
| `package-manager` | <p>The package manager used to install dependencies</p> |
<!-- action-docs-outputs source="action.yaml" -->
<!-- action-docs-runs source="action.yaml" -->
## Runs

This action is a `composite` action.
<!-- action-docs-runs source="action.yaml" -->
<!-- action-docs-usage source="action.yaml"  -->
<!-- prettier-ignore-end -->
