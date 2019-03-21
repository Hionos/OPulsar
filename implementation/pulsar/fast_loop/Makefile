include ../../../Makefile.mk

MODULE := $(MODULE)/Implementation/Pulsar/Fast_Loop

PROG := fast_loop
PROG_IMPL := $(PROG)_impl
PROG_TESTS := $(PROG)_tests

XREQ_DESC_FILE_EXT := cpt

$(info *******************************************************************************)
$(info MODULE: ${MODULE})
$(info *******************************************************************************)
$(info $$PROJECT_ROOT_DIR is [${PROJECT_ROOT_DIR}])
$(info $$PROG             is [${PROG}])
$(info $$BUILD_TYPE       is [${BUILD_TYPE}])
$(info $$TARGET           is [${TARGET}])
$(info $$PLATFORM         is [${PLATFORM}])
$(info $$PROG_IMPL        is [${PROG_IMPL}])
$(info $$PROG_TESTS       is [${PROG_TESTS}])
$(info *******************************************************************************)

# --------------------------------------------------------------------------- #
# All reachable targets
# --------------------------------------------------------------------------- #
.PHONY : help clean build reports

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

# --------------------------------------------------------------------------- #
# TARGET: build
# --------------------------------------------------------------------------- #
build: build-rts
	$(info *******************************************************************************)
	$(info [${MODULE}] Build)
	$(info *******************************************************************************)
	$(GPRBUILD) $(GPRBUILD_FLAGS) -XPRJ_BUILD_TYPE=$(BUILD_TYPE) -XPRJ_TARGET=$(TARGET) -XPRJ_PLATFORM=$(PLATFORM) -P $(PROG_IMPL).gpr


# --------------------------------------------------------------------------- #
# TARGET: reports
# --------------------------------------------------------------------------- #
reports:
	$(info *******************************************************************************)
	$(info [${MODULE}] Reports)
	$(info *******************************************************************************)
	mkdir -p $(REPORTS_DIR)/$(PROG)/$(TARGET)/check
	-$(GNATCHECK) --subdirs=reports/check -xml -U -XPRJ_ROOT_DIR=$(PROJECT_ROOT_DIR) -XPRJ_BUILD_TYPE=analyze -XPRJ_TARGET=native -P $(PROG_IMPL).gpr
	find ./obj/native/analyze/reports/check/. -name "*gnatcheck*" -exec cp '{}' $(REPORTS_DIR)/$(PROG)/$(TARGET)/check/. \;
	../../../tools/gnatcheck_text_report_to_html.sh $(REPORTS_DIR)/$(PROG)/$(TARGET)/check $(REPORTS_DIR)/$(PROG)/$(TARGET)/check/index.html
	mkdir -p $(REPORTS_DIR)/$(PROG)/$(TARGET)/metrics
	-$(GNATMETRIC) --subdirs=reports/metrics -og ./obj/native/analyze/reports/metrics/global.metrix -xs -U -XPRJ_ROOT_DIR=$(PROJECT_ROOT_DIR) -XPRJ_BUILD_TYPE=analyze -XPRJ_TARGET=native -P $(PROG_IMPL).gpr
	find ./obj/native/analyze/reports/metrics/. -name "*metrix*" -exec cp '{}' $(REPORTS_DIR)/$(PROG)/$(TARGET)/metrics/. \;
	../../../tools/gnatmetric_text_report_to_html.sh $(REPORTS_DIR)/$(PROG)/$(TARGET)/metrics $(REPORTS_DIR)/$(PROG)/$(TARGET)/metrics/index.html
	mkdir -p $(REPORTS_DIR)/$(PROG)/$(TARGET)
	cp ../../../templates/root_report_check_and_metrics_only.html $(REPORTS_DIR)/$(PROG)/$(TARGET)/report.html

