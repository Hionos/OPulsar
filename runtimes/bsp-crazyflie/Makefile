PROJECT_ROOT_DIR ?= $(shell pwd)

ARM_GCC_EXEC := $(shell which arm-eabi-gcc)

ifneq ($(ARM_GCC_EXEC),)
	ARM_TOOLCHAIN_PATH := $(shell dirname `which arm-eabi-gcc`)
endif

ifeq ($(ARM_TOOLCHAIN_PATH),)
	@echo "ARM Toolchain not found, cannot build runtime" \;
	@exit 1 \;
endif

GPRBUILD := gprbuild
GPRBUILD_FLAGS := -p -j0
GPRINSTALL := gprinstall
GPRINSTALL_FLAGS := -p
GPRINSTALL_PREFIX_FLAG := --prefix=$(PROJECT_ROOT_DIR)/dist -XPREFIX=
GPRCLEAN := gprclean

RUNTIMES_BUILD := ravenscar-sfp-stm32
RUNTIMES_CLEAN := ravenscar-sfp-stm32-clean

.PHONY : all clean  $(RUNTIMES_BUILD) $(RUNTIMES_CLEAN)

$(info *******************************************************************************)
$(info MODULE: embedded-runtimes / ${CURRENT_MODULE_BRANCH})
$(info *******************************************************************************)
$(info $$RUNTIMES           is [${RUNTIMES_BUILD}])
$(info $$ARM_TOOLCHAIN_PATH is [${ARM_TOOLCHAIN_PATH}])
$(info *******************************************************************************)

# --------------------------------------------------------------------------- #
# TARGET: all
# --------------------------------------------------------------------------- #
all: $(RUNTIMES_BUILD)

# --------------------------------------------------------------------------- #
# TARGET: clean
# --------------------------------------------------------------------------- #
clean: $(RUNTIMES_CLEAN)
clean:
	if test -d ./dist; then rm -rf ./dist; fi

# --------------------------------------------------------------------------- #
# TARGET: ravenscar-zfp-stm32
# --------------------------------------------------------------------------- #
ravenscar-zfp-stm32: export PATH := $(ARM_TOOLCHAIN_PATH):$(shell echo $$PATH)
ravenscar-zfp-stm32:
	cd BSPs && $(GPRBUILD) $(GPRBUILD_FLAGS) -P ravenscar_zfp_stm32.gpr
	cd BSPs && $(GPRINSTALL) $(GPRINSTALL_FLAGS) $(GPRINSTALL_PREFIX_FLAG)ravenscar-zfp-stm32 -P ravenscar_zfp_stm32.gpr

# --------------------------------------------------------------------------- #
# TARGET: ravenscar-zfp-stm32-clean
# --------------------------------------------------------------------------- #
ravenscar-zfp-stm32-clean: export PATH := $(ARM_TOOLCHAIN_PATH):$(shell echo $$PATH)
ravenscar-zfp-stm32-clean:
	if test -d ./BSPs/cortex-m/stm32/stm32/zfp/adalib; then rm -rf ./BSPs/cortex-m/stm32/stm32/zfp/adalib; fi
	if test -d ./BSPs/cortex-m/stm32/stm32/zfp/obj; then rm -rf ./BSPs/cortex-m/stm32/stm32/zfp/obj; fi

# --------------------------------------------------------------------------- #
# TARGET: ravenscar-sfp-stm32
# --------------------------------------------------------------------------- #
ravenscar-sfp-stm32: export PATH := $(ARM_TOOLCHAIN_PATH):$(shell echo $$PATH)
ravenscar-sfp-stm32:
	cd BSPs && $(GPRBUILD) $(GPRBUILD_FLAGS) -P ravenscar_sfp_stm32.gpr
	cd BSPs && $(GPRINSTALL) $(GPRINSTALL_FLAGS) $(GPRINSTALL_PREFIX_FLAG)ravenscar-sfp-stm32 -P ravenscar_sfp_stm32.gpr

# --------------------------------------------------------------------------- #
# TARGET: ravenscar-sfp-stm32-clean
# --------------------------------------------------------------------------- #
ravenscar-sfp-stm32-clean: export PATH := $(ARM_TOOLCHAIN_PATH):$(shell echo $$PATH)
ravenscar-sfp-stm32-clean:
	if test -d ./BSPs/cortex-m/stm32/stm32/ravenscar-sfp/adalib; then rm -rf ./BSPs/cortex-m/stm32/stm32/ravenscar-sfp/adalib; fi
	if test -d ./BSPs/cortex-m/stm32/stm32/ravenscar-sfp/obj; then rm -rf ./BSPs/cortex-m/stm32/stm32/ravenscar-sfp/obj; fi

# --------------------------------------------------------------------------- #
# TARGET: ravenscar-full-stm32
# --------------------------------------------------------------------------- #
ravenscar-full-stm32: export PATH := $(ARM_TOOLCHAIN_PATH):$(shell echo $$PATH)
ravenscar-full-stm32:
	cd BSPs && $(GPRBUILD) $(GPRBUILD_FLAGS) -P ravenscar_full_stm32.gpr
	cd BSPs && $(GPRINSTALL) $(GPRINSTALL_FLAGS) $(GPRINSTALL_PREFIX_FLAG)ravenscar-full-stm32 -P ravenscar_full_stm32.gpr

# --------------------------------------------------------------------------- #
# TARGET: ravenscar-full-stm32-clean
# --------------------------------------------------------------------------- #
ravenscar-full-stm32-clean: export PATH := $(ARM_TOOLCHAIN_PATH):$(shell echo $$PATH)
ravenscar-full-stm32-clean:
	if test -d ./BSPs/cortex-m/stm32/stm32/ravenscar-full/adalib; then rm -rf ./BSPs/cortex-m/stm32/stm32/ravenscar-full/adalib; fi
	if test -d ./BSPs/cortex-m/stm32/stm32/ravenscar-full/obj; then rm -rf ./BSPs/cortex-m/stm32/stm32/ravenscar-full/obj; fi
