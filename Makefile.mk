

# Compute pulsar-software root dir.
# Use git to get it, but would be better to find another solution
PROJECT_ROOT_DIR := $(shell git rev-parse --show-toplevel)

CURRENT_DIR := $(shell pwd)

MODULE := ROOT

PROG := pulsar

TARGET := arm-eabi
PLATFORM := crazyflie

BUILD_TYPE := production

DEPLOY_DIR := dist

GPRBUILD := gprbuild
GPRBUILD_FLAGS := -p -v -XPRJ_ROOT_DIR=$(PROJECT_ROOT_DIR)

GNATCHECK := gnatcheck
GNATMETRIC := gnatmetric

GENERATED_SOURCE_DIR := generated

FLASH := st-flash
DBG_SERVER := st-util --semihosting -v --reset
GDB  := arm-eabi-gdb
ARM_OBJ_COPY := arm-eabi-objcopy
FLASH_BASE_ADDR := 0x8000000
STUTIL_PID := stutil.pid
ARM_SIZE := arm-eabi-size

# --------------------------------------------------------------------------- #
# TARGET: help
# --------------------------------------------------------------------------- #
help:
	@echo ""
	@echo "Usage:"
	@echo "make [TARGET]"
	@echo
	@echo "[TARGET]:"
	@echo
	@echo "    all:               Build everything for installation"
	@echo "    clean:             Clean project"
	@echo "    build:             Build everything for installation"
	@echo "    dist:              Prepare a dist directory for future installation (only callable from top level Makefile)"
	@echo "    help:              Display this help message"
	@echo "    flash:             Load the executable on hardware platform"
	@echo ""

# --------------------------------------------------------------------------- #
# TARGET: build-rts
# --------------------------------------------------------------------------- #
build-rts:
	cd $(PROJECT_ROOT_DIR) && if test -f runtimes/Makefile; then $(MAKE) -C runtimes build; fi

# --------------------------------------------------------------------------- #
# TARGET: all
# --------------------------------------------------------------------------- #
all: build
