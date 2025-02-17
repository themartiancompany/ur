#
# SPDX-License-Identifier: GPL-3.0-or-later

PREFIX ?= /usr/local
_PROJECT=ur
SOLIDITY_COMPILER_BACKEND ?= solc
DOC_DIR=$(DESTDIR)$(PREFIX)/share/doc/ur
BIN_DIR=$(DESTDIR)$(PREFIX)/bin
LIB_DIR=$(DESTDIR)$(PREFIX)/lib/$(_PROJECT)
BUILD_DIR=build

DOC_FILES=\
  $(wildcard *.rst) \
  $(wildcard *.md)
SCRIPT_FILES=$(wildcard $(_PROJECT)/*)

_INSTALL_FILE=install -Dm644
_INSTALL_EXE=install -Dm755
_INSTALL_CONTRACTS_DEPLOYMENT_FUN:=\
  install-contracts-deployments-$(SOLIDITY_COMPILER_BACKEND)
_BUILD_TARGETS:=\
  contracts
_BUILD_TARGETS_ALL:=\
  all \
  $(_BUILD_TARGETS)
_CHECK_TARGETS:=\
  shellcheck
_CHECK_TARGETS_ALL:=\
  check \
  $(_CHECK_TARGETS)
_CLEAN_TARGETS_ALL:=\
  clean
_INSTALL_CONTRACTS_TARGETS:=\
  $(_INSTALL_CONTRACTS_DEPLOYMENT_FUN) \
  install-contracts-deployments-config \
  install-contracts-sources
_INSTALL_CONTRACTS_TARGETS_ALL:=\
  install-contracts \
  install-contracts-deployments-hardhat \
  install-contracts-deployments-solc \
  install-contracts-deployments-config \
  install-contracts-sources
_INSTALL_TARGETS:=\
  install-doc \
  $(_INSTALL_CONTRACTS_TARGETS) \
  install-scripts
_INSTALL_TARGETS_ALL:=\
  install \
  install-doc \
  $(_INSTALL_CONTRACTS_TARGETS_ALL) \
  install-scripts
_PHONY_TARGETS:=\
  $(_BUILD_TARGETS_ALL) \
  $(_CHECK_TARGETS_ALL) \
  $(_CLEAN_TARGETS_ALL) \
  $(_INSTALL_TARGETS_ALL)

all: $(_BUILD_TARGETS)

install: $(_INSTALL_TARGETS)

check: $(_CHECK_TARGETS)

install-contracts: $(_INSTALL_CONTRACTS_TARGETS)

clean:

	rm \
	  -rf \
	  "$(BUILD_DIR)"

shellcheck:

	shellcheck \
	  -s \
	    bash \
	  $(SCRIPT_FILES)

contracts:

	evm-make \
	  -v \
	  -C \
	    . \
	  -b \
	    "$(SOLIDITY_COMPILER_BACKEND)" \
	  -w \
	    "$(BUILD_DIR)"

install-contracts-sources:

	evm-make \
	  -v \
	  -C \
	    . \
	  -b \
	    "$(SOLIDITY_COMPILER_BACKEND)" \
	  -w \
	    "$(BUILD_DIR)" \
	  -o \
	    "$(LIB_DIR)" \
	  install_sources

install-contracts-deployments-config:

	evm-make \
	  -v \
	  -C \
	    . \
	  -b \
	    "$(SOLIDITY_COMPILER_BACKEND)" \
	  -w \
	    "$(BUILD_DIR)" \
	  -o \
	    "$(LIB_DIR)" \
	  install_deployments_config

install-contracts-deployments-solc:

	evm-make \
	  -v \
	  -C \
	    . \
	  -b \
	    "solc" \
	  -w \
	    "$(BUILD_DIR)" \
	  -o \
	    "$(LIB_DIR)" \
	  install_deployments

install-contracts-deployments-hardhat:

	evm-make \
	  -v \
	  -C \
	    . \
	  -b \
	    "hardhat" \
	  -w \
	    "$(BUILD_DIR)" \
	  -o \
	    "$(LIB_DIR)" \
	  install_deployments

install-doc:

	$(_INSTALL_FILE) \
	  $(DOC_FILES) \
	  -t $(DOC_DIR)

install-scripts:

	$(_INSTALL_EXE) \
	  "$(_PROJECT)/$(_PROJECT)" \
	  "$(BIN_DIR)/$(_PROJECT)"
	$(_INSTALL_EXE) \
	  "$(_PROJECT)/$(_PROJECT)-package-info" \
	  "$(BIN_DIR)/$(_PROJECT)-package-info"
	$(_INSTALL_EXE) \
	  "$(_PROJECT)/$(_PROJECT)-packages" \
	  "$(BIN_DIR)/$(_PROJECT)-packages"
	$(_INSTALL_EXE) \
	  "$(_PROJECT)/$(_PROJECT)-publishers" \
	  "$(BIN_DIR)/$(_PROJECT)-publishers"
	$(_INSTALL_EXE) \
	  "$(_PROJECT)/$(_PROJECT)-purchase" \
	  "$(BIN_DIR)/$(_PROJECT)-purchase"
	# the following files will have to be removed
	$(_INSTALL_EXE) \
	  "$(_PROJECT)/gen_key.sh" \
	  "$(LIB_DIR)/gen_key"
	$(_INSTALL_EXE) \
	  "$(_PROJECT)/build_repo.sh" \
	  "$(LIB_DIR)/mkrepo"
	$(_INSTALL_EXE) \
	  "$(_PROJECT)/install_pkg.sh" \
	  "$(LIB_DIR)/install"
	$(_INSTALL_EXE) \
	  "$(_PROJECT)/gen_pacman_conf.sh" \
	  "$(LIB_DIR)/gen_pacman_conf"

.PHONY: $(_PHONY_TARGETS)
