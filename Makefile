include ./Makefile.mk

$(info *******************************************************************************)
$(info MODULE: ${MODULE})
$(info *******************************************************************************)
$(info $$PROJECT_ROOT_DIR is [${PROJECT_ROOT_DIR}])
$(info $$PROG             is [${PROG}])
$(info $$BUILD_TYPE       is [${BUILD_TYPE}])
$(info $$TARGET           is [${TARGET}])
$(info $$PLATFORM         is [${PLATFORM}])
$(info *******************************************************************************)

# --------------------------------------------------------------------------- #
# Function to help the deployment into a configurable directory
# --------------------------------------------------------------------------- #
define func_deploy =
	if test -d ./$(1); then rm -rf ./$(1); fi
	mkdir -p ./$(1)
	mkdir -p ./$(1)/bin
	if test -d ./implementation/bin/$(TARGET)/$(BUILD_TYPE); then cp ./implementation/bin/$(TARGET)/$(BUILD_TYPE)/pulsar* ./$(1)/bin/.; fi
	if test -d ./reports; then cp -rf ./reports ./$(1)/.; fi
endef

# --------------------------------------------------------------------------- #
# All reachable targets
# --------------------------------------------------------------------------- #
.PHONY : help build-rts clean build dev dist flash

# --------------------------------------------------------------------------- #
# TARGET: clean
# --------------------------------------------------------------------------- #
clean:
	$(info *******************************************************************************)
	$(info [${MODULE}] Clean)
	$(info *******************************************************************************)
	if test -d ./$(DEPLOY_DIR); then rm -rf ./$(DEPLOY_DIR); fi
	if test -d ./reports; then rm -rf ./reports; fi
	if test -f implementation/Makefile; then $(MAKE) -C implementation $(@F); fi
	if test -f runtimes/Makefile; then $(MAKE) -C runtimes $(@F); fi
	rm -rf *.TMP

# --------------------------------------------------------------------------- #
# TARGET: build
# --------------------------------------------------------------------------- #
build: build-rts
	$(info *******************************************************************************)
	$(info [${MODULE}] Build)
	$(info *******************************************************************************)
ifeq ($(TARGET),arm-eabi)
	if test -f runtimes/Makefile; then $(MAKE) -C runtimes $(@F); fi
endif
	if test -f implementation/Makefile; then $(MAKE) -C implementation $(@F); fi

# --------------------------------------------------------------------------- #
# TARGET: reports
# --------------------------------------------------------------------------- #
reports:
	$(info *******************************************************************************)
	$(info [${MODULE}] Reports)
	$(info *******************************************************************************)
	if test -f implementation/Makefile; then REPORTS_DIR=$(REPORTS_DIR) $(MAKE) -C implementation $(@F); fi

# --------------------------------------------------------------------------- #
# TARGET: dist
# --------------------------------------------------------------------------- #
dist:
	$(info *******************************************************************************)
	$(info [${MODULE}] Dist)
	$(info *******************************************************************************)
	$(call func_deploy,$(DEPLOY_DIR)/pulsar-$(TARGET)-$(PLATFORM)-$(CURRENT_VERSION))
	if test -f ./$(DEPLOY_DIR)/pulsar-$(TARGET)-$(PLATFORM)-$(CURRENT_VERSION).tar.gz; then rm -rf ./$(DEPLOY_DIR)/pulsar-$(TARGET)-$(PLATFORM)-$(CURRENT_VERSION).tar.gz; fi
	cd $(DEPLOY_DIR) && tar -zcf pulsar-$(TARGET)-$(PLATFORM)-$(CURRENT_VERSION).tar.gz *

# --------------------------------------------------------------------------- #
# TARGET: flash
# --------------------------------------------------------------------------- #
flash:
	$(info *******************************************************************************)
	$(info [${MODULE}] Flash)
	$(info *******************************************************************************)
ifeq ($(TARGET),arm-eabi)
	$(FLASH) --reset --format binary write implementation/bin/$(TARGET)/$(BUILD_TYPE)/$(PROG).elf.bin $(FLASH_BASE_ADDR)
endif
