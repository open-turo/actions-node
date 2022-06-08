# GitHub Action Lint

## Description

GitHub Action that lints a Node based repository

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

## Inputs

| parameter     | description                                                                | required | default |
| ------------- | -------------------------------------------------------------------------- | -------- | ------- |
| checkout-repo | Perform checkout as first step of action                                   | `false`  | true    |
| github-token  | GitHub token that can checkout the repository. e.g. 'secrets.GITHUB_TOKEN' | `true`   |         |

## Runs

This action is an `composite` action.

## Lint Checks

This action runs the following lint checks:

- [action-pre-commit](https://github.com/open-turo/action-pre-commit)

## Notes

- By default, this action will perform actions/checkout as its first step.
- This expects that `.commitlintrc.yaml` will be present to enforce [`conventional-commit`](https://github.com/wagoid/commitlint-github-action).
