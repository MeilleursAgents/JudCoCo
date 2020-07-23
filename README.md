# JudCoCo

Judge of Conventional Commit - Write better commit description


## Main script

### Inputs

* `base`: **\[required\]** The base branch used for git comparison. Default `"master"`.
* `head`: **\[required\]** The HEAD ref used for git comparison, you current branch

### Example usage as a Github action

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

## Git hooks

*JudCoCo* also provides git hooks for the best developer experience possible.

### Example usage with [`pre-commit`](https://pre-commit.com/)

Once you
[have it installed](https://pre-commit.com/#install), add this to the
`.pre-commit-config.yaml` file in your repository:

```yaml
# Make sure to set the default_stages in your config file
# to prevent installing hooks multiple times inadvertently
default_stages: [commit]

repos:
  - repo: https://github.com/MeilleursAgents/JudCoCo
    # Replace by any tag/version: https://github.com/MeilleursAgents/JudCoCo/tags
    rev: master
    hooks:
      # This hook will run during the 'commit-msg' stage
      - id: check-commit-msg
      # [Advance]: infer ticket number from branch name
      # and add it to the commit message
      # This hook will run during the 'prepare-commit-msg' stage
      # - id: prepare-commit-msg
```

Then run `pre-commit install -t commit-msg [&& pre-commit install -t prepare-commit-msg]` and you're ready to go.
