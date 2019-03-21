include ../../../Makefile.mk

MODULE := $(MODULE)/Implementation/Pulsar/Notification_Manager

PROG := notification_manager
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
.PHONY : help clean build build-tests run-tests reports

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
	if test -d ./reports; then rm -rf ./reports; fi
	if test -d tests/generated; then rm -rf tests/generated; fi

# --------------------------------------------------------------------------- #
# TARGET: build
# --------------------------------------------------------------------------- #
build: build-rts
	$(info *******************************************************************************)
	$(info [${MODULE}] Build)
	$(info *******************************************************************************)
	$(GPRBUILD) $(GPRBUILD_FLAGS) -XPRJ_BUILD_TYPE=$(BUILD_TYPE) -XPRJ_TARGET=$(TARGET) -XPRJ_PLATFORM=$(PLATFORM) -P $(PROG_IMPL).gpr

# --------------------------------------------------------------------------- #
# TARGET: build-tests
# --------------------------------------------------------------------------- #
build-tests:
	$(info *******************************************************************************)
	$(info [${MODULE}] Build Tests)
	$(info *******************************************************************************)
	# Do syntax analysis on feature files for all stable and work in progress tests
	cd tests && $(XREQ_EXEC) --step $(STEP_DEFINITIONS) --output ./$(GENERATED_SOURCE_DIR) --check-only $(WIP_TESTS) $(STABLE_TESTS)
ifneq ($(STABLE_TESTS),)
	# Do fill/generate step definitions for stable tests only
	cd tests && $(XREQ_EXEC) --fill-steps-in $(STEP_DEFINITIONS) --output ./$(GENERATED_SOURCE_DIR) $(STABLE_TESTS)
	# Generate ada source code for stable tests only
	cd tests && $(XREQ_EXEC) --target $(TARGET) --quiet --progress --executable $(PROG_TESTS) --step ./features/$(STEP_DEFINITIONS) --output ./$(GENERATED_SOURCE_DIR) $(STABLE_TESTS)
ifeq ($(TARGET),native)
	$(GPRBUILD) $(GPRBUILD_FLAGS) -XPRJ_BUILD_TYPE=$(BUILD_TYPE) -XPRJ_TARGET=$(TARGET) -XPRJ_PLATFORM=$(PLATFORM) -P $(PROG_TESTS).gpr
endif
ifeq ($(TARGET),arm-eabi)
	$(GPRBUILD) $(GPRBUILD_FLAGS) -XPRJ_BUILD_TYPE=$(BUILD_TYPE) -XPRJ_TARGET=$(TARGET) -XPRJ_PLATFORM=$(PLATFORM) -P $(PROG_TESTS).gpr
	$(ARM_OBJ_COPY) -O binary bin/$(TARGET)/$(BUILD_TYPE)/$(PROG_TESTS).elf bin/$(TARGET)/$(BUILD_TYPE)/$(PROG_TESTS).elf.bin
	$(ARM_SIZE) bin/$(TARGET)/$(BUILD_TYPE)/$(PROG_TESTS).elf
endif
endif

# --------------------------------------------------------------------------- #
# TARGET: run-tests
# --------------------------------------------------------------------------- #
run-tests:
	$(info *******************************************************************************)
	$(info [${MODULE}] Run Tests)
	$(info *******************************************************************************)
ifneq ($(STABLE_TESTS),)
	mkdir -p ./obj/$(TARGET)/$(BUILD_TYPE)/reports/xreq
ifeq ($(TARGET),native)
	$(GNATCOV) run -P $(PROG_IMPL).gpr --recursive -c stmt+mcdc -o obj/$(TARGET)/$(BUILD_TYPE)/$(PROG_TESTS).trace bin/$(TARGET)/$(BUILD_TYPE)/$(PROG_TESTS) $(XREQ_EXEC_FLAGS)
endif
ifeq ($(TARGET),arm-eabi)
	$(FLASH) --reset --format binary write bin/$(TARGET)/$(BUILD_TYPE)/$(PROG_TESTS).elf.bin $(FLASH_BASE_ADDR)
	$(DBG_SERVER) > obj/$(TARGET)/$(BUILD_TYPE)/$(TARGET)_$(BUILD_TYPE)_$(PLATFORM)_$(PROG).log 2>&1 & echo $$! > $(STUTIL_PID);
	$(GDB) --command ../../../.gdbinit bin/$(TARGET)/$(BUILD_TYPE)/$(PROG_TESTS).elf
	kill `cat $(STUTIL_PID)` && rm $(STUTIL_PID)
endif
endif

# --------------------------------------------------------------------------- #
# TARGET: reports
# --------------------------------------------------------------------------- #
reports:
	$(info *******************************************************************************)
	$(info [${MODULE}] Reports)
	$(info *******************************************************************************)
	mkdir -p ./obj/$(TARGET)/$(BUILD_TYPE)/reports/coverage
	mkdir -p $(REPORTS_DIR)/$(PROG)/$(TARGET)/coverage
	mkdir -p $(REPORTS_DIR)/$(PROG)/$(TARGET)/xreq
ifeq ($(STABLE_TESTS),)
	cp ../../../templates/no_coverage_report.html $(REPORTS_DIR)/$(PROG)/$(TARGET)/coverage/index.html
	cp ../../../templates/no_test_report.html $(REPORTS_DIR)/$(PROG)/$(TARGET)/xreq/xreq_report.html
else
ifeq ($(TARGET),native)
	$(GNATCOV) coverage -P $(PROG_IMPL).gpr --recursive -c stmt+mcdc --annotate=dhtml --output-dir obj/$(TARGET)/$(BUILD_TYPE)/reports/coverage/ -T obj/$(TARGET)/$(BUILD_TYPE)/$(PROG_TESTS).trace
	find obj/$(TARGET)/$(BUILD_TYPE)/reports/coverage/. -name "*.html" -exec cp '{}' $(REPORTS_DIR)/$(PROG)/$(TARGET)/coverage/. \;
	find obj/$(TARGET)/$(BUILD_TYPE)/reports/coverage/. -name "*.css" -exec cp '{}' $(REPORTS_DIR)/$(PROG)/$(TARGET)/coverage/. \;
	find obj/$(TARGET)/$(BUILD_TYPE)/reports/coverage/. -name "*.js" -exec cp '{}' $(REPORTS_DIR)/$(PROG)/$(TARGET)/coverage/. \;
	find obj/$(TARGET)/$(BUILD_TYPE)/reports/xreq/. -name "xreq_html_report.log" -exec cp '{}' $(REPORTS_DIR)/$(PROG)/$(TARGET)/xreq/xreq_report.html \;
endif
ifeq ($(TARGET),arm-eabi)
	# For the moment, arm target does not support coverage report
	cp ../../../templates/no_coverage_report_supported.html $(REPORTS_DIR)/$(PROG)/$(TARGET)/coverage/index.html

	# Here we generate an html report from output logs
	../../../tools/xreq_text_report_to_html.sh ./obj/$(TARGET)/$(BUILD_TYPE)/$(TARGET)_$(BUILD_TYPE)_$(PLATFORM)_$(PROG).log $(REPORTS_DIR)/$(PROG)/$(TARGET)/xreq/xreq_report.html
endif
endif
	mkdir -p $(REPORTS_DIR)/$(PROG)/$(TARGET)/check
	-$(GNATCHECK) --subdirs=reports/check -xml -U -XPRJ_ROOT_DIR=$(PROJECT_ROOT_DIR) -XPRJ_BUILD_TYPE=analyze -XPRJ_TARGET=native -P $(PROG_IMPL).gpr
	find ./obj/native/analyze/reports/check/. -name "*gnatcheck*" -exec cp '{}' $(REPORTS_DIR)/$(PROG)/$(TARGET)/check/. \;
	../../../tools/gnatcheck_text_report_to_html.sh $(REPORTS_DIR)/$(PROG)/$(TARGET)/check $(REPORTS_DIR)/$(PROG)/$(TARGET)/check/index.html
	mkdir -p $(REPORTS_DIR)/$(PROG)/$(TARGET)/metrics
	-$(GNATMETRIC) --subdirs=reports/metrics -og ./obj/native/analyze/reports/metrics/global.metrix -xs -U -XPRJ_ROOT_DIR=$(PROJECT_ROOT_DIR) -XPRJ_BUILD_TYPE=analyze -XPRJ_TARGET=native -P $(PROG_IMPL).gpr
	find ./obj/native/analyze/reports/metrics/. -name "*metrix*" -exec cp '{}' $(REPORTS_DIR)/$(PROG)/$(TARGET)/metrics/. \;
	../../../tools/gnatmetric_text_report_to_html.sh $(REPORTS_DIR)/$(PROG)/$(TARGET)/metrics $(REPORTS_DIR)/$(PROG)/$(TARGET)/metrics/index.html
	mkdir -p $(REPORTS_DIR)/$(PROG)/$(TARGET)
	cp ../../../templates/root_report_full.html $(REPORTS_DIR)/$(PROG)/$(TARGET)/report.html

