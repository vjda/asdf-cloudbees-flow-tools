# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

asdf plugin test cloudbees-flow-tools https://github.com/vjda/asdf-cloudbees-flow-tools.git "ectool --version"
```

Tests are automatically run in GitHub Actions on push and PR.
