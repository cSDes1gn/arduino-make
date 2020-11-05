# Makefile for Arduino Interfacing
# ================================
# Makefile for linting, compiling, flashing larger scale ardunio projects and
# interfacing with the arduino serial monitor
# 
# Modified: 2020-11
# Copyright © 2020 Christian Sargusingh

OKGREEN=\033[92m
# WARNING=\033[93m
# FAIL=\033[91m
OKBLUE=\033[94m
UNDERLINE=\033[4m
NC=\033[0m

# Source user env flags
include .env
export $(shell sed 's/=.*//' .env)

# scrape serial port from /dev
# TODO: scrape using `arduino-cli board list` (requires FBQN resolvers)
TTY = $$(ls /dev/tty.usbserial*)
kill_serial := $$(kill -9 $$(lsof ${TTY} | awk 'NR>1 {print $$2}'))

.PHONY: help
help:
	@echo Usage:
	@echo "  make [target]"
	@echo
	@echo Targets:
	@awk -F ':|##' \
		'/^[^\t].+?:.*?##/ {\
			printf "  %-30s %s\n", $$1, $$NF \
		 }' $(MAKEFILE_LIST)

.PHONY: all
all: lint compile flash

.PHONY: setup
setup: ## configure arduino-cli and install cpplinter
	@arduino-cli config init;
	@arduino-cli core update-index;
	@arduino-cli core install arduino:avr;
	@arduino-cli core upgrade;
	@arduino-cli core list;
	@arduino-cli board listall;
	@python3 -m pip install cpplint

.PHONY: lint
lint: ## lint with cpplint for Google cpp guidelines and code styling
	@printf "${OKBLUE}Linting filesystems ... \n\tExtensions:\t${OKGREEN}${LINT_EXT} \n${OKBLUE}\
		Source dir:\t${OKGREEN}${SOURCE_PATH}\n\t${OKBLUE}Include dir:\t${OKGREEN}${LD_PATH}${NC}\n"
	@cpplint --recursive --extensions=${LINT_EXT} ${SOURCE_PATH} ${LD_PATH}
	@printf "${OKGREEN} ✓ ${NC} Complete\n"

.PHONY: compile
compile: ## build arduino artefacts
	@printf "${OKBLUE}Compiling .ino into ${OKGREEN}${BUILD_PATH}${NC}\n"
	@arduino-cli compile -v --warnings "all" \
		--libraries ${PWD}/${LD_PATH}\
		--fqbn ${CORE} ${SOURCE_PATH}\
		--output-dir ${BUILD_PATH}
	@printf "${OKGREEN} ✓ ${NC} Complete\n"

.PHONY: flash
flash: ## flash arduino build artefacts to board
	@printf "${OKBLUE}Flashing ${BUILD_PATH}/${CORE} to ${TTY}${NC}\n"
	@if [[ -n "$$(lsof ${TTY})" ]]; then \
		printf "${OKBLUE}Closing serial montior @ ${TTY}${NC}\n" \
		$(call kill_serial); fi;
	@arduino-cli upload -v -p ${TTY} --fqbn ${CORE} ${SOURCE_PATH} --input-dir ${BUILD_PATH};
	@printf "${OKGREEN} ✓ ${NC} Complete\n"

.PHONY: clean
clean: ## clear build artefacts and close serial monitor
	@printf "${OKBLUE}Cleaning build artefacts: ${BUILD_PATH}${NC}\n";
	@rm -rfv ${BUILD_PATH};
	@if [[ -n "$$(lsof ${TTY})" ]]; then \
		printf "${OKBLUE}Closing serial montior @ ${TTY}${NC}\n" \
		$(call kill_serial); fi;
	@printf "${OKGREEN} ✓ ${NC} Complete\n"

.PHONY: monitor
monitor: ## Open serial port using tty. Ctrl-a + d to exit screen
	@screen ${TTY}
	# to reconnnect to serial monitor: screen -r [pid.]tty.host