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

      - name: Fetch branches
        run: |
          git fetch --no-tags --prune origin "+refs/heads/${BASE}:refs/remotes/origin/${BASE}"
          git fetch --no-tags --prune origin "+refs/heads/${HEAD}:refs/remotes/origin/${HEAD}"
        env:
          BASE: ${{ github.base_ref }}
          HEAD: ${{ github.head_ref }}

      - name: JudCoCo
        uses: MeilleursAgents/JudCoCo@master
        with:
          base: origin/${{ github.base_ref }}
          head: origin/${{ github.head_ref }}
```
