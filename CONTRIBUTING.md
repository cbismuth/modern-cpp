# Contributing

## Working with Code

### Getting the source code

First of all, you need to have [Git](https://git-scm.com) installed on your system to check out the repository source code from [GitHub](https://github.com/cbismuth/modern-cpp).

Get the source code using the command line below:

```bash
git clone https://github.com/cbismuth/modern-cpp.git
```

### Building with Docker

This project uses [Docker](https://docker.com) for build control.

Underneath `cmake`, `make` and `g++` are used to build C++ source code within the latest Linux Ubuntu LTS image available. 

Build output directory named `cmake-build-debug` will be automatically copied from Docker container to host.  

GitHub Actions is also enabled on this repository, see [docker.yml](.github/workflows/docker.yml) and all [workflows](https://github.com/cbismuth/modern-cpp/actions).

### Code formatting and checks

Code formatting and checks are wrapped within the Docker build script, see [docker-build.sh](docker-build.sh).

Underneath `clang-format`, `clang-tidy` and `lcov` are used to build C++ source code, the modern way.

### IDE support

- *VS Code* - [C/C++ Extension Pack](https://github.com/microsoft/vscode-cpptools) plugin can import and build CMake projects out of the box.
- *IntelliJ* - [IntelliJ](https://www.jetbrains.com/idea) has limited support to CMake projects out of the box.
- *CLion* - [CLion](https://www.jetbrains.com/clion) can import and build CMake projects out of the box.
- *Eclipse*  - Not tested.
- *Netbeans* - Not tested.

## Contributing your work

You can open a pull request at https://github.com/cbismuth/modern-cpp.

Please be patient. Committers are busy people too. If no one responds to your patch after a few days, please make friendly reminders.

Please incorporate others' suggestions into your patch if you think they're reasonable.

Finally, remember that even a patch that is not committed is useful to the community.

### Opening a pull request

Please refer to [GitHub's documentation](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests) for an explanation of how to create a pull request.

You should open a pull request against the `main` branch. Committers will backport it to the maintenance branches once the change is merged into `main` (as far as it is possible).
