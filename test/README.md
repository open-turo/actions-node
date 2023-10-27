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
<!-- action-docs-inputs -->
<!-- action-docs-outputs -->
<!-- action-docs-outputs -->
<!-- action-docs-runs -->
<!-- action-docs-runs -->
<!-- action-docs-usage  -->
<!-- action-docs-usage -->
<!-- prettier-ignore-end -->
