include ../../../Makefile.mk

MODULE := $(MODULE)/Implementation/Pulsar/Logger

PROG := logger
PROG_IMPL := $(PROG)_impl

$(info *******************************************************************************)
$(info MODULE: ${MODULE})
$(info *******************************************************************************)
$(info $$PROJECT_ROOT_DIR is [${PROJECT_ROOT_DIR}])
$(info $$PROG             is [${PROG}])
$(info $$BUILD_TYPE       is [${BUILD_TYPE}])
$(info $$TARGET           is [${TARGET}])
$(info $$PLATFORM         is [${PLATFORM}])
$(info $$PROG_IMPL        is [${PROG_IMPL}])
$(info *******************************************************************************)

# --------------------------------------------------------------------------- #
# All reachable targets
# --------------------------------------------------------------------------- #
.PHONY : help clean build

# --------------------------------------------------------------------------- #
# TARGET: clean
# --------------------------------------------------------------------------- #
clean:
	$(info *******************************************************************************)
	$(info [${MODULE}] Clean)
	$(info *******************************************************************************)
	if test -d ./bin; then rm -rf ./bin; fi
	if test -d ./lib; then rm -rf ./lib; fi
	if test -d ./obj; then rm -rf ./obj; fi

# --------------------------------------------------------------------------- #
# TARGET: build
# --------------------------------------------------------------------------- #
build: build-rts
	$(info *******************************************************************************)
	$(info [${MODULE}] Build)
	$(info *******************************************************************************)
	$(GPRBUILD) $(GPRBUILD_FLAGS) -XPRJ_BUILD_TYPE=$(BUILD_TYPE) -XPRJ_TARGET=$(TARGET) -XPRJ_PLATFORM=$(PLATFORM) -P $(PROG_IMPL).gpr
