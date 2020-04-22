# JudCoCo

Judge of Conventional Commit - Write better commit description

## Inputs

### `base`

**Required** The base branch used for git comparison. Default `"master"`.

### `head`

**Required** The HEAD ref used for git comparison, you current branch

## Example usage

```yaml
---

name: Git
on: [pull_request]
jobs:
  build:
    name: Branch is clean
    runs-on: ubuntu-latest
    steps:
      - name: Check out code
        uses: actions/checkout@v2
        with:
          ref: ${{ github.event.pull_request.head.sha }}
          fetch-depth: 0

      - name: Fetch base branch
        run: |
          git fetch --no-tags --prune origin "+refs/heads/${BASE}:refs/remotes/origin/${BASE}"
        env:
          BASE: ${{ github.base_ref }}

      - name: JudCoCo
        uses: MeilleursAgents/JudCoCo@master
        with:
          base: origin/${{ github.base_ref }}
          head: HEAD
```
