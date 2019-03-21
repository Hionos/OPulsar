Pulsar Flight System
====================

This is the open source version of the Pulsar Flight SW.

It is able to run on a Crazyflie platfrom (STM32-F405).

## Prerequisites

To build and use this project, user's development environment must contain the following tools:
- Gnat GPL 2017 ([ARM ELF 32 bits](http://mirrors.cdn.adacore.com/art/591c6413c7a447af2deed0e3), [Linux 64 bits](http://mirrors.cdn.adacore.com/art/591c6d80c7a447af2deed1d7))
- [ST-LINK/V2](https://www.st.com/en/development-tools/st-link-v2.html)
- [st-link-1.5.0](https://github.com/texane/stlink)

## Building the project

User should use Makefile to build the autopilot project.

### Common use cases

- To display help:
```
make help
```

- To build the project for STM32 platform with Crazyflie hardware:
```
make build
```

- To load the executable for STM32 platform with Crazyflie hardware:
```
make flash
```

- To clean everything:
```
make clean
```

### Command syntax

```
make [TARGET]
```

With:
```
[TARGET]:

    all:               Build everything for installation
    clean:             Clean project
    build:             Build everything for installation
    dist:              Prepare a dist directory for future installation (only callable from top level Makefile)
    help:              Display this help message
    flash:             Load the executable on hardware platform
```
