# GitHub Action Lint

GitHub Action runs lint on a node based GitHub repository

## Usage

```yaml
jobs:
  build:
    steps:
      - name: Lint
        uses: open-turo/actions-node/lint@v1
        with:
          ## example value for github-token provided below
          github-token: ${{ secrets.GITHUB_TOKEN }}
```

Note: by default, this action will perform actions/checkout as its first step.

## Lint Checks

This action runs the following lint checks:

- [action-pre-commit](https://github.com/open-turo/action-pre-commit)

## Notes

- This expects that `.commitlintrc.yaml` will be present to enforce [`conventional-commit`](https://github.com/wagoid/commitlint-github-action).
- Checkout must have history to ensure that commit message linting works.
