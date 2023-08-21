#
# SPDX-License-Identifier: GPL-3.0-or-later

PREFIX ?= /usr/local
DOC_DIR=$(DESTDIR)$(PREFIX)/share/doc/ur
LIB_DIR=$(DESTDIR)$(PREFIX)/lib

DOC_FILES=$(wildcard *.rst)
SCRIPT_FILES=$(wildcard ur/*)

all:

check: shellcheck

shellcheck:
	shellcheck -s bash $(SCRIPT_FILES)

install: install-scripts install-doc

install-scripts:

        install -vDm 755 ur/gen_key.sh "$(LIB_DIR)/gen_key"
        install -vDm 755 ur/build_repo.sh "$(LIB_DIR)/mkrepo"
        install -vDm 755 ur/install_pkg.sh "$(LIB_DIR)/install"
        install -vDm 755 ur/gen_pacman_conf.sh "$(LIB_DIR)/gen_pacman_conf"
        install -vDm 755 ur/setup_user.sh "$(LIB_DIR)/repo_builder"

install-doc:
        install -vDm 644 $(DOC_FILES) -t $(DOC_DIR)

.PHONY: check install install-doc install-scripts shellcheck
