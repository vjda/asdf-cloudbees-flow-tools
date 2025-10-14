<div align="center">

# asdf-cloudbees-flow-tools [![Build](https://github.com/vjda/asdf-cloudbees-flow-tools/actions/workflows/build.yml/badge.svg)](https://github.com/vjda/asdf-cloudbees-flow-tools/actions/workflows/build.yml) [![Lint](https://github.com/vjda/asdf-cloudbees-flow-tools/actions/workflows/lint.yml/badge.svg)](https://github.com/vjda/asdf-cloudbees-flow-tools/actions/workflows/lint.yml)

[cloudbees-flow-tools](https://docs.cloudbees.com/docs/cloudbees-cd/latest/tools-and-utilities/cloudbees-tool-archive) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

**TODO: adapt this section**

- `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add cloudbees-flow-tools
# or
asdf plugin add cloudbees-flow-tools https://github.com/vjda/asdf-cloudbees-flow-tools.git
```

cloudbees-flow-tools:

```shell
# Show all installable versions
asdf list-all cloudbees-flow-tools

# Install specific version
asdf install cloudbees-flow-tools latest

# Set a version globally (on your ~/.tool-versions file)
asdf global cloudbees-flow-tools latest

# Now cloudbees-flow-tools commands are available
ectool --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/vjda/asdf-cloudbees-flow-tools/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Víctor Javier Díaz Ayuste](https://github.com/vjda/)
