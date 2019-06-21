include ../Makefile.mk

MODULE := $(MODULE)/Implementation

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
$(info $$GPR_RUNTIME_PATH is [${GPR_RUNTIME_PATH}])

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
	if test -f pulsar/autopilot/Makefile; then $(MAKE) -C pulsar/autopilot $(@F); fi
	if test -f pulsar/battery_manager/Makefile; then $(MAKE) -C pulsar/battery_manager $(@F); fi
	if test -f pulsar/fast_loop/Makefile; then $(MAKE) -C pulsar/fast_loop $(@F); fi
	if test -f pulsar/flight_control/Makefile; then $(MAKE) -C pulsar/flight_control $(@F); fi
	if test -f pulsar/logger/Makefile; then $(MAKE) -C pulsar/logger $(@F); fi
	if test -f pulsar/motors_mixing/Makefile; then $(MAKE) -C pulsar/motors_mixing $(@F); fi
	if test -f pulsar/navigation_reference/Makefile; then $(MAKE) -C pulsar/navigation_reference $(@F); fi
	if test -f pulsar/notification_manager/Makefile; then $(MAKE) -C pulsar/notification_manager $(@F); fi
	if test -f pulsar/remote_control/Makefile; then $(MAKE) -C pulsar/remote_control $(@F); fi
	if test -f pulsar/state_machine/Makefile; then $(MAKE) -C pulsar/state_machine $(@F); fi
	if test -d ./boards/obj; then rm -rf ./boards/obj; fi
	if test -d ./hal/obj; then rm -rf ./hal/obj; fi
	if test -d ./pulsar/obj; then rm -rf ./pulsar/obj; fi
	if test -d ./bin; then rm -rf ./bin; fi
	if test -d ./obj; then rm -rf ./obj; fi
	if test -d ./lib; then rm -rf ./lib; fi
	if test -d ./reports; then rm -rf ./reports; fi

# --------------------------------------------------------------------------- #
# TARGET: build
# --------------------------------------------------------------------------- #
build: build-rts
	$(info *******************************************************************************)
	$(info [${MODULE}] Build)
	$(info *******************************************************************************)
	if test -f pulsar/autopilot/Makefile; then $(MAKE) -C pulsar/autopilot $(@F); fi
	if test -f pulsar/battery_manager/Makefile; then $(MAKE) -C pulsar/battery_manager $(@F); fi
	if test -f pulsar/fast_loop/Makefile; then $(MAKE) -C pulsar/fast_loop $(@F); fi
	if test -f pulsar/flight_control/Makefile; then $(MAKE) -C pulsar/flight_control $(@F); fi
	if test -f pulsar/logger/Makefile; then $(MAKE) -C pulsar/logger $(@F); fi
	if test -f pulsar/motors_mixing/Makefile; then $(MAKE) -C pulsar/motors_mixing $(@F); fi
	if test -f pulsar/navigation_reference/Makefile; then $(MAKE) -C pulsar/navigation_reference $(@F); fi
	if test -f pulsar/notification_manager/Makefile; then $(MAKE) -C pulsar/notification_manager $(@F); fi
	if test -f pulsar/remote_control/Makefile; then $(MAKE) -C pulsar/remote_control $(@F); fi
	if test -f pulsar/state_machine/Makefile; then $(MAKE) -C pulsar/state_machine $(@F); fi
	$(GPRBUILD) $(GPRBUILD_FLAGS) -XPRJ_BUILD_TYPE=$(BUILD_TYPE) -XPRJ_TARGET=$(TARGET) -XPRJ_PLATFORM=$(PLATFORM) -P $(PROG_IMPL).gpr
ifeq ($(TARGET),arm-eabi)
	$(ARM_OBJ_COPY) -O binary bin/$(TARGET)/$(BUILD_TYPE)/$(PROG).elf bin/$(TARGET)/$(BUILD_TYPE)/$(PROG).elf.bin
	$(ARM_SIZE) bin/$(TARGET)/$(BUILD_TYPE)/$(PROG).elf

endif