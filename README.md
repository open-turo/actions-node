# `open-turo/actions-node`

GitHub Actions for `node` based repositories. It supports `bun`, `pnpm`, `yarn`, and `npm` as package managers.

[![Release](https://img.shields.io/github/v/release/open-turo/actions-node)](https://github.com/open-turo/actions-node/releases/)
[![Tests pass/fail](https://img.shields.io/github/workflow/status/open-turo/actions-node/CI)](https://github.com/open-turo/actions-node/actions/)
[![License](https://img.shields.io/github/license/open-turo/actions-node)](./LICENSE)
[![Contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg)](https://github.com/dwyl/esta/issues)
![CI](https://github.com/open-turo/actions-node/actions/workflows/release.yaml/badge.svg)
[![semantic-release: angular](https://img.shields.io/badge/semantic--release-angular-e10079?logo=semantic-release)](https://github.com/semantic-release/semantic-release)
[![Conventional commits](https://img.shields.io/badge/conventional%20commits-1.0.2-%23FE5196?logo=conventionalcommits&logoColor=white)](https://conventionalcommits.org)
[![Join us!](https://img.shields.io/badge/Turo-Join%20us%21-593CFB.svg)](https://turo.com/jobs)

## Actions

### action: [`lint`](./lint)

Lint will run pre-commit linters and eslint against the consumer repository, optionally checking out, and installing node, bun/pnpm/yarn/npm and any other required tools with [action-setup-tools](https://github.com/open-turo/action-setup-tools).

See usage [here](./lint/README.md#usage).

Documentation is found [here](./lint/README.md).

### action: [`release`](./release)

Release will optionally checkout the consumer repository and attempt a [Semantic Release](https://semantic-release.gitbook.io/semantic-release/usage/configuration) using the root level configuration file (e.g. `.releaserc.json`) indicating branches and plugins to use to facilitate the release.

See usage [here](./release/README.md#usage).

Documentation is found [here](./release/README.md).

### action: [`test`](./test)

Executes the `test` script in `package.json`

See usage [here](./test/README.md#usage).

Documentation is found [here](./test/README.md).

## Get Help

Each Action has a detailed README for how to use it as referenced above. Please review Issues, post new Issues against this repository as needed.

## Contributions

Please see [here](https://github.com/open-turo/contributions) for guidelines on how to contribute to this project.

<!-- Links: -->

[release-date-image]: https://img.shields.io/github/release-date/open-turo/actions-node.svg
[release-url]: https://github.com/cycjimmy/semantic-release-action/releases
[semantic-image]: https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg
[semantic-url]: https://github.com/semantic-release/semantic-release
