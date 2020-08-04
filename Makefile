########################################################################
# MPP management
########################################################################

# Parameters:
# 	prefix
# 	bindir
# 	datadir
# 	mandir

PROJECT := jqt

prefix	?= /usr/local
bindir	?= $(prefix)/bin
datadir	?= $(prefix)/share
mandir	?= $(prefix)/share/man

########################################################################
# Prerequisites
########################################################################

# We are using some of the newest GNU Make features... so require GNU
# Make version >= 3.82
version_test := $(filter 3.82,$(firstword $(sort $(MAKE_VERSION) 3.82)))
ifndef version_test
$(error GNU Make version $(MAKE_VERSION); version >= 3.82 is needed)
endif

ifeq (,$(filter install uninstall,$(MAKECMDGOALS)))
ifeq (0,$(shell id --user))
$(error Root only can make "(un)install" targets)
endif
else
ifneq (0,$(shell id --user))
$(error Only root can make "(un)install" targets)
endif
endif

########################################################################
# Configuration
########################################################################

# Disable builtins.
MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --no-builtin-variables

# Warn when an undefined variable is referenced.
MAKEFLAGS += --warn-undefined-variables

# Make will not print the recipe used to remake files.
.SILENT:

# Eliminate use of the built-in implicit rules. Also clear out the
# default list of suffixes for suffix rules.
.SUFFIXES:

# Sets the default goal to be used if no targets were specified on the
# command line.
.DEFAULT_GOAL := all

# When it is time to consider phony targets, make will run its recipe
# unconditionally, regardless of whether a file with that name exists or
# what its last-modification time is.
.PHONY: all clean

# Default shell: if we require GNU Make, why not require Bash?
SHELL := /bin/bash

# Argument(s) passed to the shell.
.SHELLFLAGS := -o errexit -o pipefail -o nounset -c

# Make will delete the target of a rule if it has changed and its recipe
# exits with a nonzero exit status.
.DELETE_ON_ERROR:

# Debug utility
print-%: ; @echo $* = $($*)

########################################################################
# Tests
########################################################################

clean: ; rm -f tests/generated/*

.PHONY: header test-mpmd

all: header test-mpmd

header:
	@echo =========================
	@echo Macro Processing Markdown 
	@echo =========================

# Run one example
test-mpmd-%.md:
	echo "==> $(subst test-,,$(basename $@))"
	./mpp < tests/$(subst test-,,$@) > tests/generated/$(subst test-,,$@)
	diff tests/expected/$(subst test-,,$@) tests/generated/$(subst test-,,$@)

# Run one example named without file suffix
test-mpmd-%: test-mpmd-%.md ;

# Run all tests
test-mpmd: $(sort $(subst tests/,test-,$(wildcard tests/mpmd-[0-9][0-9].md)))

# vim:ai:sw=8:ts=8:noet:syntax=make
