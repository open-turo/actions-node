# GitHub Action Test

GitHub Action that runs tests present within a node based GitHub repository.

## Usage

```yaml
jobs:
  test:
    steps:
      - name: Test
        uses: open-turo/actions-node/test@v1
```

Note: by default, this action will perform actions/checkout as its first step.

## Test

It will run:

```shell
yarn --pure-lockfile
yarn test --coverage
```
