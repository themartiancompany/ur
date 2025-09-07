# SPDX-License-Identifier: GPL-3.0-or-later

#    ----------------------------------------------------------------------
#    Copyright © 2024, 2025  Pellegrino Prevete
#
#    All rights reserved
#    ----------------------------------------------------------------------
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Affero General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.

PREFIX ?= /usr/local
_PROJECT=ur
SOLIDITY_COMPILER_BACKEND ?= solc
DATA_DIR=$(DESTDIR)$(PREFIX)/share
ICONS_DIR=$(DATA_DIR)/icons
DOC_DIR=$(DATA_DIR)/doc/$(_PROJECT)
BIN_DIR=$(DESTDIR)$(PREFIX)/bin
LIB_DIR=$(DESTDIR)$(PREFIX)/lib/$(_PROJECT)
MAN_DIR?=$(DATA_DIR)/man
BUILD_DIR=build

DOC_FILES=\
  $(wildcard *.rst) \
  $(wildcard *.md) \
  $(wildcard docs/*.md)
SCRIPT_FILES=$(wildcard $(_PROJECT)/*)

_INSTALL_FILE=install -vDm644
_INSTALL_EXE=install -vDm755
_INSTALL_DIR=install vdm755

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
_INSTALL_DOC_TARGETS:=\
  install-doc \
  install-man
_INSTALL_TARGETS:=\
  $(_INSTALL_DOC_TARGETS) \
  $(_INSTALL_CONTRACTS_TARGETS) \
  install-scripts \
  install-data
_INSTALL_TARGETS_ALL:=\
  install \
  $(_INSTALL_DOC_TARGETS) \
  $(_INSTALL_CONTRACTS_TARGETS_ALL) \
  install-scripts \
  install-data
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
	  -l \
	    "n" \
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
	  -l \
	    "n" \
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
	  -l \
	    "n" \
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
	  -l \
	    "n" \
	  install_deployments

install-doc:

	$(_INSTALL_FILE) \
	  $(DOC_FILES) \
	  -t $(DOC_DIR)

install-man:

	$(_INSTALL_DIR) \
	  "$(MAN_DIR)/man1"
	rst2man \
	  "man/$(_PROJECT).1.rst" \
	  "$(MAN_DIR)/man1/$(_PROJECT).1"
	rst2man \
	  "man/$(_PROJECT)-package-info.1.rst" \
	  "$(MAN_DIR)/man1/$(_PROJECT)-package-info.1"
	rst2man \
	  "man/$(_PROJECT)-packages.1.rst" \
	  "$(MAN_DIR)/man1/$(_PROJECT)-packages.1"
	rst2man \
	  "man/$(_PROJECT)-publishers.1.rst" \
	  "$(MAN_DIR)/man1/$(_PROJECT)-publishers.1"
	rst2man \
	  "man/$(_PROJECT)-purchase.1.rst" \
	  "$(MAN_DIR)/man1/$(_PROJECT)-purchase.1"


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

install-data:

	$(_INSTALL_FILE) \
	  "data/$(_PROJECT).png" \
	  "$(ICONS_DIR)/$(_PROJECT).png"


.PHONY: $(_PHONY_TARGETS)
